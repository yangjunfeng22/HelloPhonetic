//
//  ExciseFirstCell.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/28.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "ExciseFirstCell.h"
#import "Record+path.h"
#import "ToneKnowledge.h"
#import "ToneKnowledge+Record.h"
#import "ToneRecordOperation.h"
#import "AnimateHelper.h"
#import "AudioPlayHelper.h"
#import "UIView+Additions.h"

static const NSString *audioBundle = @"ExciseFirst";

@interface ExciseFirstCell ()
@property (nonatomic, weak) ToneButton *selectedButton;
@property (nonatomic, strong) NSOperationQueue* operationQueue;

@end

@implementation ExciseFirstCell

- (void)awakeFromNib
{
    self.backgroundColor = self.superview.backgroundColor;
    
    self.audioControlView.controlMode = AudioControlModeSourceOnly;
    self.audioControlView.backgroundColor = self.backgroundColor;
    self.lblContent.backgroundColor = [UIColor clearColor];
    self.lblContent.textColor = kContentColor;
    
    self.btnToneOne.backgroundColor = kColorFFBackground;
    self.btnToneOne.layer.cornerRadius = self.btnToneOne.height*0.1;
    self.btnToneOne.toneTintColor = kToneTintColor;
    self.btnToneOne.tone = 1;
    
    self.btnToneTwo.backgroundColor = kColorFFBackground;
    self.btnToneTwo.layer.cornerRadius = self.btnToneTwo.height*0.1;
    self.btnToneTwo.toneTintColor = kToneTintColor;
    self.btnToneTwo.tone = 2;
    
    self.btnToneThree.backgroundColor = kColorFFBackground;
    self.btnToneThree.layer.cornerRadius = self.btnToneThree.height*0.1;
    self.btnToneThree.toneTintColor = kToneTintColor;
    self.btnToneThree.tone = 3;
    
    self.btnToneFour.backgroundColor = kColorFFBackground;
    self.btnToneFour.layer.cornerRadius = self.btnToneFour.height*0.1;
    self.btnToneFour.toneTintColor = kToneTintColor;
    self.btnToneFour.tone = 4;
    
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.audioControlView.controlMode = AudioControlModeSourceOnly;
    
    // 重置之前选择过的那个按钮的状态
    self.selectedButton.toneTintColor = kToneTintColor;
    self.selectedButton.backgroundColor = kColorFFBackground;
}

- (void)prepareForAppearLayout
{
    self.btnToneOne.alpha       = 0;
    self.btnToneTwo.alpha       = 0;
    self.btnToneThree.alpha     = 0;
    self.btnToneFour.alpha      = 0;
    self.audioControlView.alpha = 0;
    self.lblContent.alpha       = 0;
}

- (void)layoutSubviewsAppear
{
    
    CGPoint center1O = self.btnToneOne.center;
    CGPoint center1N = CGPointMake(self.btnToneOne.centerX, self.height+self.btnToneOne.height);
    [AnimateHelper transitionLayer:self.btnToneOne.layer fromCenterY:center1O.y toCenterY:center1N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnToneOne.alpha = 1;
        [AnimateHelper transitionLayer:self.btnToneOne.layer fromCenterY:center1N.y toCenterY:center1O.y duration:0.8 delay:0 completion:nil];
    }];
    
    
    CGPoint center2O = self.btnToneTwo.center;
    CGPoint center2N = CGPointMake(self.btnToneTwo.centerX, self.height+self.btnToneTwo.height);
    [AnimateHelper transitionLayer:self.btnToneTwo.layer fromCenterY:center2O.y toCenterY:center2N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnToneTwo.alpha = 1;
        [AnimateHelper transitionLayer:self.btnToneTwo.layer fromCenterY:center2N.y toCenterY:center2O.y duration:0.8 delay:0.05 completion:nil];
    }];
    
    
    CGPoint center3O = self.btnToneThree.center;
    CGPoint center3N = CGPointMake(self.btnToneThree.centerX, self.height+self.btnToneThree.height);
    [AnimateHelper transitionLayer:self.btnToneThree.layer fromCenterY:center3O.y toCenterY:center3N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnToneThree.alpha = 1;
        [AnimateHelper transitionLayer:self.btnToneThree.layer fromCenterY:center3N.y toCenterY:center3O.y duration:0.8 delay:0.1 completion:nil];
    }];
    
    
    CGPoint center4O = self.btnToneFour.center;
    CGPoint center4N = CGPointMake(self.btnToneFour.centerX, self.height+self.btnToneFour.height);
    [AnimateHelper transitionLayer:self.btnToneFour.layer fromCenterY:center4O.y toCenterY:center4N.y duration:0 delay:0 completion:^(BOOL finished) {
        self.btnToneFour.alpha = 1;
        [AnimateHelper transitionLayer:self.btnToneFour.layer fromCenterY:center4N.y toCenterY:center4O.y duration:0.8 delay:0.15 completion:nil];
    }];
    
    
    CGPoint centerAO = self.audioControlView.center;
    CGPoint centerAN = CGPointMake(self.audioControlView.centerX, -self.audioControlView.height*0.5);
    [AnimateHelper transitionLayer:self.audioControlView.layer fromCenterY:centerAO.y toCenterY:centerAN.y duration:0 delay:0 completion:^(BOOL finished) {
        self.audioControlView.alpha = 1;
        [AnimateHelper transitionLayer:self.audioControlView.layer fromCenterY:centerAN.y toCenterY:centerAO.y duration:0.8 delay:0 completion:^(BOOL finished) {
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
    
    CGPoint center1O = self.btnToneOne.center;
    CGPoint center1N = CGPointMake(self.btnToneOne.centerX, self.height+self.btnToneOne.height);
    [AnimateHelper transitionLayer:self.btnToneOne.layer fromCenterY:center1O.y toCenterY:center1N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnToneOne fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center2O = self.btnToneTwo.center;
    CGPoint center2N = CGPointMake(self.btnToneTwo.centerX, self.height+self.btnToneTwo.height);
    [AnimateHelper transitionLayer:self.btnToneTwo.layer fromCenterY:center2O.y toCenterY:center2N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnToneTwo fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center3O = self.btnToneThree.center;
    CGPoint center3N = CGPointMake(self.btnToneThree.centerX, self.height+self.btnToneThree.height);
    [AnimateHelper transitionLayer:self.btnToneThree.layer fromCenterY:center3O.y toCenterY:center3N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnToneThree fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint center4O = self.btnToneFour.center;
    CGPoint center4N = CGPointMake(self.btnToneFour.centerX, self.height+self.btnToneFour.height);
    [AnimateHelper transitionLayer:self.btnToneFour.layer fromCenterY:center4O.y toCenterY:center4N.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.btnToneFour fromAlpha:1 toAlpha:0 duration:duration];
    
    CGPoint centerAO = self.audioControlView.center;
    CGPoint centerAN = CGPointMake(self.audioControlView.centerX, -self.audioControlView.height*0.5);
    [AnimateHelper transitionLayer:self.audioControlView.layer fromCenterY:centerAO.y toCenterY:centerAN.y duration:0.8 delay:0 completion:nil];
    [AnimateHelper transitionView:self.audioControlView fromAlpha:1 toAlpha:0 duration:duration];
    
    [AnimateHelper transitionView:self.lblContent fromAlpha:1 toAlpha:0 duration:duration];
}

- (void)playSourceAudio
{
    [self.audioControlView playSourceAction:nil];
}

#pragma mark - Action Manager
- (IBAction)selectToneAction:(id)sender
{
    ToneButton *button = ((ToneButton *)sender);
    NSInteger tone = button.tag;
    NSString *audio = @"wrong.mp3";
    if (tone == self.record.tone.integerValue)
    {
        // 选对
        audio = @"right.mp3";
        button.backgroundColor = kColorLightGreen;
        [AnimateHelper popUpAnimationWithView:button];
        
        self.lblContent.text = self.record.pinyin;
        
        self.record.rightTimes = @(self.record.rightTimes.integerValue+1);
    }
    else
    {
        // 选错
        button.backgroundColor = kColorLightRed;
        [AnimateHelper shakeAnimationWithView:button];
        
        self.lblContent.text = self.record.phone;
        
        self.record.wrongTimes = @(self.record.wrongTimes.integerValue+1);
        self.record.rightTimes = @(0);
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
    
    if (self.selectedButton.tag != tone)
    {
        self.selectedButton.toneTintColor = kToneTintColor;
        self.selectedButton.backgroundColor = kColorFFBackground;
        self.selectedButton = sender;
    }
}

#pragma mark - 属性
- (void)setRecord:(Record *)record
{
    [super setRecord:record];
    
    //DLog(@"totaltimes: %@", @(self.record.rightTimes.integerValue + self.record.wrongTimes.integerValue));
    
    self.lblContent.text = record.phone;
    self.audioControlView.sourceAudio = [Record pathOfAudio:record.chinese bundle:@"ExciseFirst"];
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
