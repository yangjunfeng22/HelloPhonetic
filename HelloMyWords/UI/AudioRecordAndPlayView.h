//
//  AudioRecordAndPlayView.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/21.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSAudioPlayerButton.h"

typedef NS_ENUM(NSUInteger, AudioControlMode) {
    AudioControlModeDefault,
    AudioControlModeSourceOnly,
    AudioControlModeRecordOnly,
    AudioControlModePlayOnly
};

typedef NS_ENUM(NSUInteger, ComponentsAnimateMode) {
    ComponentsAnimateModeDefault,
    ComponentsAnimateModeSourceOnly,
    ComponentsAnimateModeRecorderOnly,
    ComponentsAnimateModePlayOnly
};

@class AudioRecord;

@protocol AudioRecordAndPlayDelegate;

@interface AudioRecordAndPlayView : UIView
@property (nonatomic, weak) id<AudioRecordAndPlayDelegate>delegate;
@property (nonatomic, copy) NSString *sourceAudio;
@property (nonatomic, strong) HSAudioPlayerButton *btnSource;
@property (nonatomic) AudioControlMode controlMode;
@property (nonatomic) ComponentsAnimateMode animateMode;

- (void)playSourceAction:(id)sender;
- (void)resetAudioControlState;

@end


@protocol AudioRecordAndPlayDelegate <NSObject>

@optional
- (void)startPlayAudio:(NSString *)audioPath duration:(NSTimeInterval)duration;
- (void)sourceAudioPlayerDidFinishPlaying:(id)player successfully:(BOOL)flag;
- (void)audioRecorderDidFinishedRecord:(id)recorder;
- (void)audioRecorderDidFinishedAnalysisResult:(AudioRecord *)result successuflly:(BOOL)flag;

@end