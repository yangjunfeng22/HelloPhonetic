//
//  ToneReportCell.h
//  HelloMyWords
//
//  Created by junfengyang on 15/6/10.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDProgressView.h"
#import "HSLearnCircleProgressView.h"
#import "ToneLabel.h"

@interface ToneReportCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ToneLabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgvTone;

@property (weak, nonatomic) IBOutlet LDProgressView *progressView;


@end
