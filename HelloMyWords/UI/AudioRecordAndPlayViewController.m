//
//  AudioRecordAndPlayViewController.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/21.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "AudioRecordAndPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <iflyMSC/IFlySpeechRecognizer.h>
#import <iflyMSC/IFlySpeechRecognizerDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>

#import "FileHelper.h"

/**
 *  整个的逻辑如下：
 *  -- 录音按钮开始的时候两边的音频及按钮的状态都要重置掉。
 *  -- 播放录音的时候，源音频的播放要pause。
 *  -- 播放源音频的时候，录音的播放要pause。
 *  -- 两边音频播放的时候，录音重置。
 */
@interface AudioRecordAndPlayViewController ()<AVAudioPlayerDelegate, IFlySpeechRecognizerDelegate>
{
    IFlySpeechRecognizer *_iflySpeechRecognizer;
}
@property (nonatomic, strong) UIButton *btnRecorder;
@property (nonatomic, strong) UIButton *btnPlay;
@property (nonatomic, strong) UIButton *btnSource;
@property (nonatomic, strong) UIImageView *imgvSoundLoading;
@property (nonatomic, strong) AVAudioRecorder *recorder;    // 录音器
@property (nonatomic, strong) AVAudioPlayer *player;        // 播放器
@property (nonatomic, strong) AVAudioPlayer *sourcePlayer;  // 源的播放器
@property (nonatomic, strong) NSTimer *timer;               // 定时器
@property (nonatomic, strong) NSDictionary *dicRecorderSettings;
@property (nonatomic, strong) NSMutableArray *arrVolumImages; // 图片组
@property (nonatomic) double lowPassResults;

@property (nonatomic, copy) NSString *playName;

- (void)downAction:(id)sender;
- (void)upAction:(id)sender;
- (void)playAction:(id)sender;

@end

@implementation AudioRecordAndPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending) {
        // 7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if (session) {
            [session setActive:YES error:nil];
        } else {
            DLog(@"Error creating session:%@", [sessionError description]);
        }
    }
    // 语音识别
    _iflySpeechRecognizer = [[IFlySpeechRecognizer alloc] init];
    _iflySpeechRecognizer.delegate = self;
    
    [self btnRecorder];
    [self btnSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma mark - 判断
- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted){
                if (granted) {
                    bCanRecord = YES;
                }else{
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    return bCanRecord;
}

#pragma mark - 按钮方法
- (void)downAction:(id)sender
{
    // 录音的时候先禁止记录的播放
    [self stopRecordPlayer];
    // 同时禁止source的播放
    [self stopSourcePlayer];
    
    // 无界面识别。(开始语音识别)
    if (_iflySpeechRecognizer.isListening)
    {
        [_iflySpeechRecognizer stopListening];
    }
    else
    {
        [_iflySpeechRecognizer setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        [_iflySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        [_iflySpeechRecognizer startListening];
    }
    
    // 按下录音
    ((UIButton *)sender).backgroundColor = [UIColor cyanColor];
    if ([self canRecord]) {
        NSError *error = nil;
        // 模拟器上测试有可能崩溃
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.playName] settings:self.dicRecorderSettings error:&error];
        if (_recorder) {
            // 可以获取电平
            _recorder.meteringEnabled = YES;
            [_recorder prepareToRecord];
            [_recorder record];
            
            // 启动定时器
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
        }else {
            int errorCode = CFSwapInt32HostToBig((int32_t)error.code);
            NSLog(@"Error: %@ [%4.4s]", [error localizedDescription], (char *)&errorCode);
        }
    }
}

- (void)upAction:(id)sender
{
    ((UIButton *)sender).backgroundColor = [UIColor grayColor];
    // 松开结束录音
    // 录音停止
    [_recorder stop];
    _recorder = nil;
    
    // 结束定时器
    [_timer invalidate];
    _timer = nil;
    // 图片重置
    self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:0]];
    
    [self btnPlay];
}

- (void)playAction:(id)sender
{
    // 重置录音状态
    //[self upAction:self.btnRecorder];
    // 先暂停录音的播放
    [self pauseSourcePlayer];
    
    if (_player.isPlaying)
    {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateNormal];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateHighlighted];
        
        [_player pause];
        
    }
    else
    {
        UIImage *imgPlay = [UIImage imageNamed:@"pause"];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateNormal];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateHighlighted];
        
        if (_player)
        {
            [_player play];
        }
        else
        {
            NSError *playerError;
            // 播放
            _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.playName] error:&playerError];
            _player.delegate = self;
            if (_player)
            {
                DLog(@"音频持续时间: %@", @(_sourcePlayer.duration));
                [_player play];
            }
            else
            {
                DLog(@"ERror creating player: %@", [playerError description]);
                UIImage *imgPlay = [UIImage imageNamed:@"play"];
                [((UIButton *)sender) setImage:imgPlay forState:UIControlStateNormal];
                [((UIButton *)sender) setImage:imgPlay forState:UIControlStateHighlighted];
            }
        }
    }
}

- (void)playSourceAction:(id)sender
{
    // 重置录音状态
    //;
    // 先暂停录音的播放
    [self pauseRecordPlayer];
    
    if (_sourcePlayer.isPlaying)
    {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateNormal];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateHighlighted];
        
        [_sourcePlayer pause];
        
    }
    else
    {
        UIImage *imgPlay = [UIImage imageNamed:@"pause"];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateNormal];
        [((UIButton *)sender) setImage:imgPlay forState:UIControlStateHighlighted];
        
        if (_sourcePlayer)
        {
            [_sourcePlayer play];
        }
        else
        {
            NSError *playerError;
            // 播放
            _sourcePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.sourceAudio] error:&playerError];
            _sourcePlayer.delegate = self;
            if (_sourcePlayer)
            {
                DLog(@"音频持续时间: %@", @(_sourcePlayer.duration));
                [_sourcePlayer play];
            }
            else
            {
                DLog(@"ERror creating player: %@", [playerError description]);
                
                UIImage *imgPlay = [UIImage imageNamed:@"play"];
                [((UIButton *)sender) setImage:imgPlay forState:UIControlStateNormal];
                [((UIButton *)sender) setImage:imgPlay forState:UIControlStateHighlighted];
                
                if (![[NSFileManager defaultManager] fileExistsAtPath:self.sourceAudio]) {
                    [[[UIAlertView alloc] initWithTitle:nil message:@"找不到所要的音频" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
            }
        }
    }
}

#pragma mark - 播放控制的逻辑
- (void)pauseRecordPlayer
{
    if (_player.isPlaying)
    {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        
        [_btnPlay setImage:imgPlay forState:UIControlStateNormal];
        [_btnPlay setImage:imgPlay forState:UIControlStateHighlighted];
        
        [_player pause];
        
    }
}

- (void)pauseSourcePlayer
{
    if (_sourcePlayer.isPlaying)
    {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        
        [_btnSource setImage:imgPlay forState:UIControlStateNormal];
        [_btnSource setImage:imgPlay forState:UIControlStateHighlighted];
        
        [_sourcePlayer pause];
    }
}

- (void)stopRecordPlayer
{
    if (_player.isPlaying)
    {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        
        [_btnPlay setImage:imgPlay forState:UIControlStateNormal];
        [_btnPlay setImage:imgPlay forState:UIControlStateHighlighted];
        
        [_player stop];
        _player = nil;
    }
}

- (void)stopSourcePlayer
{
    if (_sourcePlayer.isPlaying)
    {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        
        [_btnSource setImage:imgPlay forState:UIControlStateNormal];
        [_btnSource setImage:imgPlay forState:UIControlStateHighlighted];
        
        [_sourcePlayer stop];
        _sourcePlayer = nil;
    }
}

#pragma mark - 定时器方法
- (void)levelTimer:(NSTimer *)aTimer
{
    //call to refresh meter values
    // 刷新平均和峰值功率,此计数是以对数刻度计量的,-160表示完全安静，0表示最大输入值
    [_recorder updateMeters];
    
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (ALPHA * [_recorder peakPowerForChannel:0]));
    _lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * _lowPassResults;
    
    DLog(@"Average input: %f Peak input: %f Low pass results: %f", [_recorder averagePowerForChannel:0], [_recorder peakPowerForChannel:0], _lowPassResults);
    
    if (_lowPassResults>=0.8) {
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:7]];
    }else if(_lowPassResults>=0.7){
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:6]];
    }else if(_lowPassResults>=0.6){
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:5]];
    }else if(_lowPassResults>=0.5){
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:4]];
    }else if(_lowPassResults>=0.4){
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:3]];
    }else if(_lowPassResults>=0.3){
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:2]];
    }else if(_lowPassResults>=0.2){
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:1]];
    }else if(_lowPassResults>=0.1){
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:0]];
    }else{
        self.imgvSoundLoading.image = [UIImage imageNamed:[self.arrVolumImages objectAtIndex:0]];
    }
    
}


#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == _player) {
        _player = nil;
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        [self.btnPlay setImage:imgPlay forState:UIControlStateNormal];
        [self.btnPlay setImage:imgPlay forState:UIControlStateHighlighted];
    }else{
        _sourcePlayer = nil;
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        [self.btnSource setImage:imgPlay forState:UIControlStateNormal];
        [self.btnSource setImage:imgPlay forState:UIControlStateHighlighted];
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    
}


#pragma mark - IFlySpeechRecognizerDelegate
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    
}

- (void)onError:(IFlySpeechError *)errorCode
{
    
}

#pragma mark - 属性
- (UIButton *)btnRecorder
{
    
    if (!_btnRecorder)
    {
        UIImage *imgRecord = [UIImage imageNamed:@"micphone"];
        CGRect frame = CGRectMake(0, 0, 60, 60);
        _btnRecorder = [[UIButton alloc] initWithFrame:frame];
        _btnRecorder.center = CGPointMake(self.view.bounds.size.width*0.5, _btnRecorder.center.y);
        _btnRecorder.layer.cornerRadius = 30;
        _btnRecorder.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btnRecorder.backgroundColor = [UIColor grayColor];
        [_btnRecorder setImage:imgRecord forState:UIControlStateNormal];
        [_btnRecorder setImage:imgRecord forState:UIControlStateHighlighted];
        [_btnRecorder addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchDown];
        [_btnRecorder addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        [self.view addSubview:_btnRecorder];
    }
    return _btnRecorder;
}

- (UIButton *)btnPlay
{
    if (!_btnPlay) {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        CGRect frame = CGRectMake(0, 0, 40, 40);
        _btnPlay = [[UIButton alloc] initWithFrame:frame];
        _btnPlay.center = CGPointMake(self.view.bounds.size.width*0.75, 30);
        _btnPlay.layer.cornerRadius = 20;
        _btnPlay.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btnPlay.backgroundColor = [UIColor grayColor];
        [_btnPlay setImage:imgPlay forState:UIControlStateNormal];
        [_btnPlay setImage:imgPlay forState:UIControlStateHighlighted];
        [_btnPlay addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btnPlay];
    }
    return _btnPlay;
}

- (UIButton *)btnSource
{
    if (!_btnSource) {
        UIImage *imgPlay = [UIImage imageNamed:@"play"];
        CGRect frame = CGRectMake(0, 0, 40, 40);
        _btnSource = [[UIButton alloc] initWithFrame:frame];
        _btnSource.center = CGPointMake(self.view.bounds.size.width*0.25, 30);
        _btnSource.layer.cornerRadius = 20;
        _btnSource.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btnSource.backgroundColor = [UIColor grayColor];
        [_btnSource setImage:imgPlay forState:UIControlStateNormal];
        [_btnSource setImage:imgPlay forState:UIControlStateHighlighted];
        [_btnSource addTarget:self action:@selector(playSourceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btnSource];
    }
    return _btnSource;
}

- (UIImageView *)imgvSoundLoading
{
    if (!_imgvSoundLoading) {
        _imgvSoundLoading = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_imgvSoundLoading];
    }
    return _imgvSoundLoading;
}

- (NSDictionary *)dicRecorderSettings
{
    if (!_dicRecorderSettings) {// 录音设置
        _dicRecorderSettings = @{AVFormatIDKey:@(kAudioFormatMPEG4AAC), AVSampleRateKey:@(1000.0), AVNumberOfChannelsKey:@(2), AVLinearPCMBitDepthKey:@(8), AVLinearPCMIsBigEndianKey:@(NO), AVLinearPCMIsFloatKey:@(NO)};
    }
    return _dicRecorderSettings;
}

- (NSMutableArray *)arrVolumImages
{
    if (!_arrVolumImages) {
        // 音量图片数组
        _arrVolumImages = [[NSMutableArray alloc] initWithObjects: @"RecordingSignal001", @"RecordingSignal002", @"RecordingSignal003", @"RecordingSignal004", @"RecordingSignal005", @"RecordingSignal006", @"RecordingSignal007", @"RecordingSignal008", nil];
    }
    return _arrVolumImages;
}

- (NSString *)playName
{
    if (!_playName) {
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _playName = [NSString stringWithFormat:@"%@/play.acc", docDir];
    }
    return _playName;
}

@end
