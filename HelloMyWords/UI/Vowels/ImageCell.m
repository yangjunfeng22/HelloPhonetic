//
//  ImageCell.m
//  HelloMyWords
//
//  Created by junfengyang on 15/6/2.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (void)awakeFromNib
{
    self.backgroundColor = self.superview.backgroundColor;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imgvTeach.image = nil;
}

@end
