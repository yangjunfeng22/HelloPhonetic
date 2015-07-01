//
//  LanguageController.m
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/19.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "LanguageController.h"

static LanguageController *languageController =nil;

@implementation LanguageController

+(LanguageController *)languageController
{
    @synchronized(self){
        if (languageController == nil) {
            languageController = [[LanguageController alloc] init];
        }
    }
    return languageController;
}

-(void)setDelegate:(id<LanguageControllerDelegate>)delegate{
    _delegate = delegate;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged:) name:LANGUAGE_STATE_NOTIFICATION object:nil];
}

-(void) languageChanged:(id) sender{
    if(_delegate !=nil && [_delegate respondsToSelector:@selector(updateLanguage)]) {
        [_delegate updateLanguage];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LANGUAGE_STATE_NOTIFICATION object:nil];
    _delegate=nil;

}

@end
