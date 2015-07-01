//
//  AboutUsViewController.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/25.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UIView+Additions.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.imgvLogo.layer.cornerRadius = self.imgvLogo.height*0.5;
    
    self.btnLogout.layer.cornerRadius = self.btnLogout.height * 0.1;
//    self.btnLogout.layer.borderColor = kColor00Background.CGColor;
//    self.btnLogout.layer.borderWidth = 2.0;
    
    self.btnFeedback.layer.cornerRadius = self.btnFeedback.height * 0.1;
//    self.btnFeedback.layer.borderColor = kColor00Background.CGColor;
//    self.btnFeedback.layer.borderWidth = 2.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Manager
- (IBAction)btnQuit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)logoutAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userLogout:)])
    {
        [self.delegate userLogout:self];
    }
}

- (IBAction)feedbackAction:(id)sender
{
    
}

@end
