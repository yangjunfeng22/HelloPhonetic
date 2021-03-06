//
//  RegistViewController.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/22.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "RegistViewController.h"
#import "UIView+Additions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnRegist.layer.cornerRadius = self.btnRegist.height*0.1;
//    self.btnRegist.layer.borderColor = kColor00Background.CGColor;
//    self.btnRegist.layer.borderWidth = 2;
    
    RAC(self.btnRegist, enabled) = [RACSignal combineLatest:@[_tfEmail.rac_textSignal, _tfPassword.rac_textSignal, _tfConfirm.rac_textSignal] reduce:^id (NSString *userName, NSString *password, NSString *rePassword){
        return @(userName.length >= 6 && password.length >= 6 && rePassword.length >= 6);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registAction:(id)sender {
    
    kSetUDUserEamil(self.tfEmail.text);
    [self.navigationController popViewControllerAnimated:YES];
    [[[UIAlertView alloc] initWithTitle:nil message:@"已成功注册账号，请登陆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

@end
