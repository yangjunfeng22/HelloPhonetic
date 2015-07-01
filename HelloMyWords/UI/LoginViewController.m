//
//  LoginViewController.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/22.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UIView+Additions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //self.tfEmail.text = kEmail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.btnLogin.layer.cornerRadius = self.btnLogin.height*0.1;
    //self.btnLogin.layer.borderColor = kColor00Background.CGColor;
    //self.btnLogin.layer.borderWidth = 2;
    
    RAC(self.btnLogin, enabled) = [RACSignal combineLatest:@[_tfEmail.rac_textSignal, _tfPassword.rac_textSignal] reduce:^id (NSString *userName, NSString *password){
        return @(userName.length >= 6 && password.length >=6);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(userLogined:)]) {
        [self.delegate userLogined:self];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)goRegistViewAction:(id)sender {
    RegistViewController *regist = [[RegistViewController alloc] initWithNibName:@"RegistViewController" bundle:nil];
    [self.navigationController pushViewController:regist animated:YES];
    
}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
