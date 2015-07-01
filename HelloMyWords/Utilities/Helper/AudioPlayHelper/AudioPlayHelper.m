//
//  AudioPlayHelper.m
//  HelloHSK
//
//  Created by yang on 14-3-18.
//  Copyright (c) 2014年 yang. All rights reserved.
//

#import "AudioPlayHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPVolumeView.h>

// 1、全局静态对象、并置为nil。
static AudioPlayHelper *audioPlay = nil;

@interface AudioPlayHelper ()<AVAudioPlayerDelegate>

@property (weak, nonatomic)id<AudioPlayHelperDelegate>delegate;
@property (strong, nonatomic, readwrite)AVAudioPlayer *player;
@property (readwrite) NSTimeInterval duration;
@property (readwrite, getter=isPlaying) BOOL playing;


@end

@implementation AudioPlayHelper
@dynamic playing;
@synthesize volume = _volume;

// 2、构造实例
+ (AudioPlayHelper *)instance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioPlay = [[self alloc] init];
    });
     
    return audioPlay;
}

+ (id)initWithAudioName:(NSString *)audioName delegate:(id<AudioPlayHelperDelegate>)delegate
{
    [[self instance] initAudioPlayerWithSource:audioName delegate:delegate];
    return [self instance];
}

+ (void)stopAndCleanAudioPlay
{
    [[self instance] stopAudio];
    //audioPlay = nil;
}

- (void)initAudioPlayerWithSource:(NSString *)source delegate:(id<AudioPlayHelperDelegate>)delegate
{
    //NSLog(@"%@: source: %@", NSStringFromSelector(_cmd), source);
    NSString *path = @"";
    if ([[NSFileManager defaultManager] fileExistsAtPath:source])
    {
        //NSLog(@"存在音频");
        path = source;
    }
    
    NSError *error;
    if (!_player)
    {
//        AVAudioSession * audioSession = [AVAudioSession sharedInstance]; //得到AVAudioSession单例对象
//        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];//设置类别,表示该应用同时支持播放和录音
//        [audioSession setActive:YES error: &error];//启动音频会话管理,此时会阻断后台音乐的播放.
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path isDirectory:NO] error:&error];
        //DLog(@"音频问题： %@", error.description);
        
        _player.delegate = self;
    }
    
    _player.numberOfLoops = self.loops;
    [_player prepareToPlay];
    
    self.duration = _player.duration;
    self.delegate = delegate;
}

- (BOOL)isPlaying
{
    return _player.playing;
}

- (void)setLoops:(NSInteger)loops
{
    _loops = loops;
    _player.numberOfLoops = loops;
}

- (void)playAudio
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    if (_player)
    {
        _player.volume = self.volume;
        //NSLog(@"音频播放: %f, %f, %f", player.duration, player.currentTime, player.deviceCurrentTime);
        [_player play];
    
        // 阻止锁屏
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
}

- (void)stopAudio
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioPlayerBeginInterruption:)])
    {
        [self.delegate audioPlayerBeginInterruption:_player];
    }
    
    if (_player)
    {
        [_player stop];
        _player = nil;
        
    }
    
    // 还原锁屏
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)aPlayer successfully:(BOOL)flag
{
    // 还原锁屏
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioPlayerDidFinishPlaying:successfully:)])
    {
        [self.delegate audioPlayerDidFinishPlaying:aPlayer successfully:flag];
    }
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)aPlayer
{
    // 还原锁屏
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioPlayerBeginInterruption:)])
    {
        [self.delegate audioPlayerBeginInterruption:aPlayer];
    }
}

#pragma mark - 属性设置
- (void)setVolume:(CGFloat)volume
{
    _volume = volume;
}

- (CGFloat)volume
{
    if (_volume <= 0)
    {
        
//        UInt32 doChangeDefaultRoute = 1;
//        AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
        
//        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
//        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        //and whereever you want to play the sound, call the lines below
//        float currentVolume = [MPMusicPlayerController applicationMusicPlayer].volume;
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
//        float currentVolume;
//        UInt32 dataSize = sizeof(float);
//        AudioSessionGetProperty (kAudioSessionProperty_CurrentHardwareOutputVolume, &dataSize, &currentVolume);
        
        return session.outputVolume;
    }
    return _volume;
}

#pragma mark - Memory Manager

@end
