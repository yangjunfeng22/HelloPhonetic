//
//  LoginViewController.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/22.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate;

@interface LoginViewController : UIViewController
@property (weak, nonatomic) id<LoginDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;

@end

@protocol LoginDelegate <NSObject>

- (void)userLogined:(id)sender;

@end
