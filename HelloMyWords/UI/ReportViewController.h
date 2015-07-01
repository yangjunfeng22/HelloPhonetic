//
//  ReportViewController.h
//  HelloMyWords
//
//  Created by junfengyang on 15/6/10.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnTone;
@property (weak, nonatomic) IBOutlet UIButton *btnPinyin;
@property (weak, nonatomic) IBOutlet UITableView *tbvPinyinReport;
@property (weak, nonatomic) IBOutlet UITableView *tbvToneReport;

@end
