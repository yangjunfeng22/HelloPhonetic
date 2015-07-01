//
//  ExciseSecondCell.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/28.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearnCollectionViewCell.h"
#import "AudioRecordAndPlayView.h"
#import "ToneButton.h"

@interface ExciseSecondCell : LearnCollectionViewCell

@property (weak, nonatomic) IBOutlet AudioRecordAndPlayView *audioControlView;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle2;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone11;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone12;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone13;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone14;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone21;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone22;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone23;
@property (weak, nonatomic) IBOutlet ToneButton *btnTone24;


@end
