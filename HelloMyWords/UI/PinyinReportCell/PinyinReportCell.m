//
//  PinyinReportCell.m
//  HelloMyWords
//
//  Created by junfengyang on 15/6/11.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "PinyinReportCell.h"
#import "AudioPlayHelper.h"
#import "Record+path.h"

@interface PinyinReportCell ()<AudioPlayHelperDelegate>

@end

@implementation PinyinReportCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imageView.image = [UIImage imageNamed:@"ico_audioPlay_3"];
    self.imageView.animationDuration = 1.2;
    self.imageView.animationImages = [NSArray arrayWithObjects:ImageNamed(@"ico_audioPlay_0"), ImageNamed(@"ico_audioPlay_1"), ImageNamed(@"ico_audioPlay_2"), ImageNamed(@"ico_audioPlay_3"), nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected) {
        [self playAudio];
    }else{
        [self stopAudio];
    }
}

- (void)setRecord:(Record *)record
{
    _record = record;
    
}

- (void)playAudio
{
    [self.imageView startAnimating];
    
    NSString *audioName = [[NSString alloc] initWithFormat:@"%@%@", self.record.phone, self.record.wrongTone];
    
    NSString *audio = [Record pathOfAudio:audioName bundle:@"Excise"];
    DLog(@"audioName : %@; audio: %@", audioName, audio);
    [AudioPlayHelper stopAndCleanAudioPlay];
    AudioPlayHelper *audioPlayer = [AudioPlayHelper initWithAudioName:audio delegate:self];
    audioPlayer.volume = 0;
    [audioPlayer playAudio];
}

- (void)stopAudio
{
    [self.imageView stopAnimating];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self stopAudio];
}

@end
