//
//  ExciseSecondCell.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/28.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "ExciseSecondCell.h"
#import "Record+path.h"
#import "ToneKnowledge.h"
#import "ToneKnowledge+Record.h"
#import "ToneRecordOperation.h"
#import "UIView+Additions.h"
#import "AnimateHelper.h"
#import "AudioPlayHelper.h"

#import <AVFoundation/AVFoundation.h>

static const NSString *audioBundle = @"ExciseSecond";


@interface ExciseSecondCell ()<AudioRecordAndPlayDelegate>

// 双音节需要播放两个音节的音频，用以控制播放代理的回调次数
@property (nonatomic) NSInteger roopCount;
@property (nonatomic, strong) NSMutableArray *arrTones;
@property (nonatomic, strong) NSMutableArray *arrPhones;
@property (nonatomic, strong) NSMutableArray *arrPinyins;
@property (nonatomic, strong) NSMutableArray *arrAudioNames;

@property (nonatomic, weak) ToneButton *selectedButton1;
@property (nonatomic, weak) ToneButton *selectedButton2;

@property (nonatomic) BOOL phone1Selected;
@property (nonatomic) BOOL phone2Selected;

// 只有两个都对才算是对, 只要有一个错误就算错误。
@property (nonatomic) BOOL selectedRight;

@property (nonatomic, strong) NSOperationQueue* operationQueue;

@end

@implementation ExciseSecondCell

- (void)awakeFromNib
{
    _roopCount = 1;
    
    self.backgroundColor = self.superview.backgroundColor;
    self.audioControlView.controlMode = AudioControlModeSourceOnly;
    self.audioControlView.backgroundColor = self.backgroundColor;
    self.audioControlView.delegate = self;
    self.lblContent.backgroundColor = self.backgroundColor;
    self.lblContent.textColor = kContentColor;
    
    self.btnTone11.backgroundColor = kColorFFBackground;
    self.btnTone11.layer.cornerRadius = self.btnTone11.height*0.1;
    self.btnTone11.toneTintColor = kToneTintColor;
    self.btnTone11.tone = 1;
    
    self.btnTone12.backgroundColor = kColorFFBackground;
    self.btnTone12.layer.cornerRadius = self.btnTone12.height*0.1;
    self.btnTone12.toneTintColor = kToneTintColor;
    self.btnTone12.tone = 2;
    
    self.btnTone13.backgroundColor = kColorFFBackground;
    self.btnTone13.layer.cornerRadius = self.btnTone13.height*0.1;
    self.btnTone13.toneTintColor = kToneTintColor;
    self.btnTone13.tone = 3;
    
    self.btnTone14.backgroundColor = kColorFFBackground;
    self.btnTone14.layer.cornerRadius = self.btnTone14.height*0.1;
    self.btnTone14.toneTintColor = kToneTintColor;
    self.btnTone14.tone = 4;
    
    self.btnTone21.backgroundColor = kColorFFBackground;
    self.btnTone21.layer.cornerRadius = self.btnTone21.height*0.1;
    self.btnTone21.toneTintColor = kToneTintColor;
    self.btnTone21.tone = 1;
    
    self.btnTone22.backgroundColor = kColorFFBackground;
    self.btnTone22.layer.cornerRadius = self.btnTone22.height*0.1;
    self.btnTone22.toneTintColor = kToneTintColor;
    self.btnTone22.tone = 2;
    
    self.btnTone23.backgroundColor = kColorFFBackground;
    self.btnTone23.layer.cornerRadius = self.btnTone23.height*0.1;
    self.btnTone23.toneTintColor = kToneTintColor;
    self.btnTone23.tone = 3;
    
    self.btnTone24.backgroundColor = kColorFFBackground;
    self.btnTone24.layer.cornerRadius = self.btnTone24.height*0.1;
    self.btnTone24.toneTintColor = kToneTintColor;
    self.btnTone24.tone = 4;
    
    
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _roopCount = 1;
    
    self.phone1Selected = NO;
    self.phone2Selected = NO;
    self.selectedRight  = NO;
    
    [self.arrTones removeAllObjects];
    [self.arrPhones removeAllObjects];
    [self.arrPinyins removeAllObjects];
    [self.arrAudioNames removeAllObjects];
    
    // 重置之前选择过的那个按钮的状态
    self.selectedButton1.toneTintColor = kToneTintColor;
    self.selectedButton1.backgroundColor = kColorFFBackground;
    
    self.selectedButton2.toneTintColor = kToneTintColor;
    self.selectedButton2.backgroundColor = kColorFFBackground;
}

- (void)prepareForAppearLayout
{
    self.lblTitle1.alpha = 0;
    self.btnTone11.alpha = 0;
    self.btnTone12.alpha = 0;
    self.btnTone13.alpha = 0;
    self.btnTone14.alpha = 0;
    self.lblTitle2.alpha = 0;
    self.btnTone21.alpha = 0;
    self.btnTone22.alpha = 0;
    self.btnTone23.alpha = 0;
    self.btnTone24.alpha = 0;
    self.audioControlView.alpha = 0;
    self.lblContent.alpha = 0;
}

- (void)layoutSubviewsAppear
{
    
    CGPoint centerT1O = self.lblTitle1.center;
    CGPoint centerT1N = CGPointMake(self.lblTitle1.centerX, self.height+self.lblTitle1.height*0.5);
    [AnimateHelper transitionLayer:self.lblTitle1.layer fromCenterY:centerT1O.y toCenterY:centerT1N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.lblTitle1.alpha = 1;
        [AnimateHelper transitionLayer:self.lblTitle1.layer fromCenterY:centerT1N.y toCenterY:centerT1O.y duration:0.8 delay:0 completion:nil];
    }];
    
    
    CGPoint center1O = self.btnTone11.center;
    CGPoint center1N = CGPointMake(self.btnTone11.centerX, self.height+self.btnTone11.height);
    [AnimateHelper transitionLayer:self.btnTone11.layer fromCenterY:center1O.y toCenterY:center1N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone11.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone11.layer fromCenterY:center1N.y toCenterY:center1O.y duration:0.8 delay:0 completion:nil];
    }];
    
    
    CGPoint center2O = self.btnTone12.center;
    CGPoint center2N = CGPointMake(self.btnTone12.centerX, self.height+self.btnTone12.height);
    [AnimateHelper transitionLayer:self.btnTone12.layer fromCenterY:center2O.y toCenterY:center2N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone12.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone12.layer fromCenterY:center2N.y toCenterY:center2O.y duration:0.8 delay:0.05 completion:nil];
    }];
    
    
    CGPoint center3O = self.btnTone13.center;
    CGPoint center3N = CGPointMake(self.btnTone13.centerX, self.height+self.btnTone13.height);
    [AnimateHelper transitionLayer:self.btnTone13.layer fromCenterY:center3O.y toCenterY:center3N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone13.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone13.layer fromCenterY:center3N.y toCenterY:center3O.y duration:0.8 delay:0.1 completion:nil];
    }];
    
    
    CGPoint center4O = self.btnTone14.center;
    CGPoint center4N = CGPointMake(self.btnTone14.centerX, self.height+self.btnTone14.height);
    [AnimateHelper transitionLayer:self.btnTone14.layer fromCenterY:center4O.y toCenterY:center4N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone14.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone14.layer fromCenterY:center4N.y toCenterY:center4O.y duration:0.8 delay:0.15 completion:nil];
    }];
    
    
    CGPoint centerT2O = self.lblTitle2.center;
    CGPoint centerT2N = CGPointMake(self.lblTitle2.centerX, self.height+self.lblTitle2.height);
    [AnimateHelper transitionLayer:self.lblTitle2.layer fromCenterY:centerT2O.y toCenterY:centerT2N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.lblTitle2.alpha = 1;
        [AnimateHelper transitionLayer:self.lblTitle2.layer fromCenterY:centerT2N.y toCenterY:centerT2O.y duration:0.8 delay:0 completion:nil];
    }];
    
    
    CGPoint center5O = self.btnTone21.center;
    CGPoint center5N = CGPointMake(self.btnTone21.centerX, self.height+self.btnTone21.height);
    [AnimateHelper transitionLayer:self.btnTone21.layer fromCenterY:center5O.y toCenterY:center5N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone21.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone21.layer fromCenterY:center5N.y toCenterY:center5O.y duration:0.8 delay:0 completion:nil];
    }];
    
    
    CGPoint center6O = self.btnTone22.center;
    CGPoint center6N = CGPointMake(self.btnTone22.centerX, self.height+self.btnTone22.height);
    [AnimateHelper transitionLayer:self.btnTone22.layer fromCenterY:center6O.y toCenterY:center6N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone22.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone22.layer fromCenterY:center6N.y toCenterY:center6O.y duration:0.8 delay:0.05 completion:nil];
    }];
    
    
    CGPoint center7O = self.btnTone23.center;
    CGPoint center7N = CGPointMake(self.btnTone23.centerX, self.height+self.btnTone23.height);
    [AnimateHelper transitionLayer:self.btnTone23.layer fromCenterY:center7O.y toCenterY:center7N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone23.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone23.layer fromCenterY:center7N.y toCenterY:center7O.y duration:0.8 delay:0.1 completion:nil];
    }];
    
    
    CGPoint center8O = self.btnTone24.center;
    CGPoint center8N = CGPointMake(self.btnTone24.centerX, self.height+self.btnTone24.height);
    [AnimateHelper transitionLayer:self.btnTone24.layer fromCenterY:center8O.y toCenterY:center8N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnTone24.alpha = 1;
        [AnimateHelper transitionLayer:self.btnTone24.layer fromCenterY:center8N.y toCenterY:center8O.y duration:0.8 delay:0.15 completion:nil];
    }];
    
    
    CGPoint centerAcO = self.audioControlView.center;
    CGPoint centerAcN = CGPointMake(self.audioControlView.centerX, -self.audioControlView.height*0.5);
    [AnimateHelper transitionLayer:self.audioControlView.layer fromCenterY:centerAcO.y toCenterY:centerAcN.y duration:0 delay:0 completion:^(BOOL finished) {
        self.audioControlView.alpha = 1;
        [AnimateHelper transitionLayer:self.audioControlView.layer fromCenterY:centerAcN.y toCenterY:centerAcO.y duration:0.8 delay:0 completion:^(BOOL finished) {
            // 一开始自动播放相关音频
            [self playSourceAudio];
        }];
    }];

    
    CGFloat duration = 0.5;
    
    [AnimateHelper transitionView:self.lblContent fromAlpha:0 toAlpha:1 duration:duration*3];
}

- (void)layoutSubviewsDisappear
{
    CGFloat duration = 0.5;
    
    CGPoint centerT1O = self.lblTitle1.center;
    CGPoint centerT1N = CGPointMake(self.lblTitle1.centerX, self.height+self.lblTitle1.height*0.5);
    [AnimateHelper transitionLayer:self.lblTitle1.layer fromCenterY:centerT1O.y toCenterY:centerT1N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.lblTitle1 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center1O = self.btnTone11.center;
    CGPoint center1N = CGPointMake(self.btnTone11.centerX, self.height+self.btnTone11.height);
    [AnimateHelper transitionLayer:self.btnTone11.layer fromCenterY:center1O.y toCenterY:center1N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone11 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center2O = self.btnTone12.center;
    CGPoint center2N = CGPointMake(self.btnTone12.centerX, self.height+self.btnTone12.height);
    [AnimateHelper transitionLayer:self.btnTone12.layer fromCenterY:center2O.y toCenterY:center2N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone12 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center3O = self.btnTone13.center;
    CGPoint center3N = CGPointMake(self.btnTone13.centerX, self.height+self.btnTone13.height);
    [AnimateHelper transitionLayer:self.btnTone13.layer fromCenterY:center3O.y toCenterY:center3N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone13 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center4O = self.btnTone14.center;
    CGPoint center4N = CGPointMake(self.btnTone14.centerX, self.height+self.btnTone14.height);
    [AnimateHelper transitionLayer:self.btnTone14.layer fromCenterY:center4O.y toCenterY:center4N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone14 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint centerT2O = self.lblTitle2.center;
    CGPoint centerT2N = CGPointMake(self.lblTitle2.centerX, self.height+self.lblTitle2.height*0.5);
    [AnimateHelper transitionLayer:self.lblTitle2.layer fromCenterY:centerT2O.y toCenterY:centerT2N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.lblTitle2 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center5O = self.btnTone21.center;
    CGPoint center5N = CGPointMake(self.btnTone21.centerX, self.height+self.btnTone21.height);
    [AnimateHelper transitionLayer:self.btnTone21.layer fromCenterY:center5O.y toCenterY:center5N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone21 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center6O = self.btnTone22.center;
    CGPoint center6N = CGPointMake(self.btnTone22.centerX, self.height+self.btnTone22.height);
    [AnimateHelper transitionLayer:self.btnTone22.layer fromCenterY:center6O.y toCenterY:center6N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone22 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center7O = self.btnTone23.center;
    CGPoint center7N = CGPointMake(self.btnTone23.centerX, self.height+self.btnTone23.height);
    [AnimateHelper transitionLayer:self.btnTone23.layer fromCenterY:center7O.y toCenterY:center7N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone23 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center8O = self.btnTone24.center;
    CGPoint center8N = CGPointMake(self.btnTone24.centerX, self.height+self.btnTone24.height);
    [AnimateHelper transitionLayer:self.btnTone24.layer fromCenterY:center8O.y toCenterY:center8N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnTone24 fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint centerAcO = self.audioControlView.center;
    CGPoint centerAcN = CGPointMake(self.audioControlView.centerX, -self.audioControlView.height*0.5);
    [AnimateHelper transitionLayer:self.audioControlView.layer fromCenterY:centerAcO.y toCenterY:centerAcN.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.audioControlView fromAlpha:1 toAlpha:0 duration:duration];
    
    [AnimateHelper transitionView:self.lblContent fromAlpha:1 toAlpha:0 duration:duration];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)playSourceAudio
{
    [self.audioControlView playSourceAction:nil];
}

#pragma mark - Action Manager
- (IBAction)tone1Action:(id)sender
{
    ToneButton *button = ((ToneButton *)sender);
    NSInteger tone = button.tag;
    if (self.selectedButton1.tag != tone)
    {
        self.selectedButton1.toneTintColor = kToneTintColor;
        self.selectedButton1.backgroundColor = kColorFFBackground;
        self.selectedButton1 = sender;
    }
    
    NSInteger toneCount = [self.arrTones count];
    if (toneCount > 0)
    {
        NSString *tone = self.arrTones[0];
        [self selectedToneButton:self.selectedButton1 rightTone:tone.integerValue];
    }
}

- (IBAction)tone2Action:(id)sender
{
    ToneButton *button = ((ToneButton *)sender);
    NSInteger tone = button.tag;
    if (self.selectedButton2.tag != tone)
    {
        self.selectedButton2.toneTintColor = kToneTintColor;
        self.selectedButton2.backgroundColor = kColorFFBackground;
        self.selectedButton2 = sender;
    }

    NSInteger toneCount = [self.arrTones count];
    if (toneCount > 1)
    {
        NSString *tone = self.arrTones[1];
        [self selectedToneButton:self.selectedButton2 rightTone:tone.integerValue];
    }
}

- (void)selectedToneButton:(id)sender rightTone:(NSInteger)rightTone
{
    ToneButton *button = ((ToneButton *)sender);
    NSInteger tone = button.tag;
    NSString *audio = @"wrong.mp3";
    if (tone == rightTone)
    {
        // 选对
        audio = @"right.mp3";
        button.backgroundColor = kColorLightGreen;
        [AnimateHelper popUpAnimationWithView:button];
        
        if (sender == self.selectedButton1)
        {
            self.lblTitle1.text = self.arrPinyins[0];
            self.phone1Selected = YES;
            self.selectedRight = YES;
        }
        else
        {
            self.lblTitle2.text = self.arrPinyins[1];
            self.phone2Selected = YES;
            self.selectedRight = YES;
        }
        
        self.lblContent.text = [[NSString alloc] initWithFormat:@"%@ %@", self.lblTitle1.text, self.lblTitle2.text];
    }
    else
    {
        // 选错
        button.backgroundColor = kColorLightRed;
        [AnimateHelper shakeAnimationWithView:button];
        
        if (sender == self.selectedButton1)
        {
            self.lblTitle1.text = self.arrPhones[0];
            self.phone1Selected = YES;
            self.selectedRight = NO;
        }
        else
        {
            self.lblTitle2.text = self.arrPhones[1];
            self.phone2Selected = YES;
            self.selectedRight = NO;
        }
        
        self.lblContent.text = [[NSString alloc] initWithFormat:@"%@ %@", self.lblTitle1.text, self.lblTitle2.text];
    }
    
    
    self.selectedRight = self.phone1Selected && self.phone2Selected ? _selectedRight:NO;
    if (self.phone1Selected && self.phone2Selected)
    {
        if (self.selectedRight) {
            self.record.rightTimes = @(self.record.rightTimes.integerValue+1);
        }else{
            self.record.wrongTimes = @(self.record.wrongTimes.integerValue+1);
            self.record.rightTimes = @(0);
        }
    }
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    ToneRecordOperation *operation = [[ToneRecordOperation alloc] initWithStore:appDelegate.store record:self.record];
    [self.operationQueue addOperation:operation];
    
    [AudioPlayHelper stopAndCleanAudioPlay];
    NSString *path = [[NSBundle mainBundle] pathForResource:audio ofType:nil];
    AudioPlayHelper *audioPlayer = [AudioPlayHelper initWithAudioName:path delegate:nil];
    audioPlayer.volume = kSoundVolume;
    [audioPlayer playAudio];
    // 改变声调条的颜色
    button.toneTintColor = kColorFFBackground;
}


#pragma mark - 属性
- (NSMutableArray *)arrTones
{
    if (!_arrTones) {
        _arrTones = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _arrTones;
}

- (NSMutableArray *)arrPhones
{
    if (!_arrPhones) {
        _arrPhones = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _arrPhones;
}

- (NSMutableArray *)arrPinyins
{
    if (!_arrPinyins)
    {
        _arrPinyins = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _arrPinyins;
}

- (NSMutableArray *)arrAudioNames
{
    if (!_arrAudioNames) {
        _arrAudioNames = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _arrAudioNames;
}

- (void)setRecord:(Record *)record
{
    [super setRecord:record];
    
    //DLog(@"totaltimes: %@", @(self.record.rightTimes.integerValue + self.record.wrongTimes.integerValue));
    
    NSArray *arrTPhones = [record.phone componentsSeparatedByString:@"|"];
    if (arrTPhones) {
        [self.arrPhones setArray:arrTPhones];
    }
    NSInteger phoneCount = [self.arrPhones count];
    
    self.lblTitle1.text = phoneCount > 0 ? self.arrPhones[0]:@"";
    self.lblTitle2.text = phoneCount > 1 ? self.arrPhones[1]:@"";
    self.lblContent.text = [[NSString alloc] initWithFormat:@"%@ %@", self.lblTitle1.text, self.lblTitle2.text];
    
    NSString *audioName = [record.chinese stringByReplacingOccurrencesOfString:@"|" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, record.chinese.length)];
    self.audioControlView.sourceAudio = [Record pathOfAudio:audioName bundle:@"ExciseSecond"];
    
//    NSArray *arrTAudioNames = [record.audioName componentsSeparatedByString:@"|"];
//    if (arrTAudioNames) {
//        [self.arrAudioNames setArray:arrTAudioNames];
//    }
//    NSInteger audioCount = [self.arrAudioNames count];
//    if (audioCount > 0) {
//        self.audioControlView.sourceAudio = [Record pathOfAudio:self.arrAudioNames[0] bundle:@"ExciseSecond"];
//    }
    
    NSArray *arrTTones = [record.tone componentsSeparatedByString:@"|"];
    if (arrTTones) {
        [self.arrTones setArray:arrTTones];
    }
    
    NSArray *arrTPinyins = [record.pinyin componentsSeparatedByString:@"|"];
    if (arrTPinyins) {
        [self.arrPinyins setArray:arrTPinyins];
    }
}

#pragma mark - AudioControlView delegate
- (void)startPlayAudio:(NSString *)audioPath duration:(NSTimeInterval)duration
{
    
}

- (void)sourceAudioPlayerDidFinishPlaying:(id)player successfully:(BOOL)flag
{
//    if (self.roopCount >= 2) {
//        self.roopCount = 1;
//        // 重置一下音频
//        NSInteger audioCount = [self.arrAudioNames count];
//        if (audioCount >= self.roopCount)
//        {
//            self.audioControlView.sourceAudio = [Record pathOfAudio:self.arrAudioNames[self.roopCount-1] bundle:@"ExciseSecond"];
//        }
//        return;
//    }
//    self.roopCount++;
//    
//    NSInteger audioCount = [self.arrAudioNames count];
//    if (audioCount >= self.roopCount)
//    {
//        self.audioControlView.sourceAudio = [Record pathOfAudio:self.arrAudioNames[self.roopCount-1] bundle:@"ExciseSecond"];
//        [self.audioControlView playSourceAction:self.audioControlView.btnSource];
//    }
}

- (NSOperationQueue *)operationQueue
{
    if (!_operationQueue)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

@end
