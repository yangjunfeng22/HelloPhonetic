//
//  ExciseCell.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/28.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearnCollectionViewCell.h"
#import "AudioRecordAndPlayView.h"

@interface ExciseCell : LearnCollectionViewCell
@property (weak, nonatomic) IBOutlet AudioRecordAndPlayView *audioControlView;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgvPraise;

@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@end
