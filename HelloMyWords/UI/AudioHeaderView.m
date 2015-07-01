//
//  AudioHeaderView.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/15.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "AudioHeaderView.h"
#import "UIView+Additions.h"

@implementation AudioHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.centerX = self.width*0.5;
    self.textLabel.font = [UIFont systemFontOfSize:32];
    
    
}

@end
