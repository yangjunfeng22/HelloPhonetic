//
//  RegistViewController.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/22.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;

@end
