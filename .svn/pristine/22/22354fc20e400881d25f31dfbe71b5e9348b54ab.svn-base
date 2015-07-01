//
//  AudioNavViewController.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/15.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "AudioNavViewController.h"

#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlySpeechConstant.h>

#import <iflyMSC/IFlySpeechRecognizerDelegate.h>
#import <iflyMSC/IFlySpeechRecognizer.h>

#import "UIView+Additions.h"

#import "MBProgressHUD.h"

#import "AudioRecord.h"
#import "AudioHeaderView.h"
#import "AudioTableViewCell.h"



#define identify @"lu"

@interface AudioNavViewController ()<IFlyRecognizerViewDelegate, IFlySpeechRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    IFlyRecognizerView *_iflyRecognizerView;
    IFlySpeechRecognizer *_iflySpeechRecognizer;
    UITableView *audioTableView;
}

@property (nonatomic, strong) NSMutableArray *arrAudioHistory;


@end

@implementation AudioNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"语音识别";
    
    self.view.backgroundColor = kColorLightRed;
    
    // 初始化语音识别空间
    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    _iflyRecognizerView.delegate = self;
    
    _iflySpeechRecognizer = [[IFlySpeechRecognizer alloc] init];
    _iflySpeechRecognizer.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect frame = CGRectMake(0, self.navigationController.navigationBar.bottom, self.view.width, self.view.bottom-56-self.navigationController.navigationBar.bottom);
    audioTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    audioTableView.tableFooterView = [[UIView alloc] init];
    audioTableView.dataSource = self;
    audioTableView.delegate = self;
    [audioTableView registerClass:[AudioTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [audioTableView registerClass:[AudioHeaderView class] forHeaderFooterViewReuseIdentifier:@"Header"];
    [self.view addSubview:audioTableView];
    
    UIImage *imgVoice = [UIImage imageNamed:@"icon_mircophone2"];
    UIButton *btnRestart = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRestart.backgroundColor = kColorMain;
    
    btnRestart.bounds = CGRectMake(0, 0, self.view.width, 56);
    btnRestart.centerX = self.view.width * 0.5;
    btnRestart.bottom = self.view.height;
    [btnRestart addTarget:self action:@selector(restartAudio:) forControlEvents:UIControlEventTouchUpInside];
    [btnRestart setTitle:@"开始识别" forState:UIControlStateNormal];
    [btnRestart setImage:imgVoice forState:UIControlStateNormal];
    [btnRestart setImage:imgVoice forState:UIControlStateHighlighted];
    
    [self.view addSubview:btnRestart];
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)restartAudio:(id)sender
{
//    // 启动识别服务
//    [_iflyRecognizerView setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
//    //设置结果数据格式，可设置为json，xml，plain，默认为json。
//    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
//    [_iflyRecognizerView start];
    
    // 无界面识别。
    if (_iflySpeechRecognizer.isListening)
    {
        [_iflySpeechRecognizer stopListening];
    }
    else
    {
        [_iflySpeechRecognizer setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        [_iflySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        [_iflySpeechRecognizer startListening];
    }
}

#pragma mark - deelgate
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    if (!isLast) {
        //DLog(@"识别结束之后的结果: resultArray: %@", resultArray);
        
        NSMutableString *result = [[NSMutableString alloc] init];
        NSString *pinyin;
        NSString *phone;
        
        NSDictionary *dic = [resultArray objectAtIndex:0];
        //DLog(@"识别出来的字符: %@", dic);
        
        AudioRecord *record = [[AudioRecord alloc] init];
        
        for (NSString *key in dic)
        {
            [result appendFormat:@"%@",key];
            
            //NSString *str = [self replaceUnicode:key];
            CFStringRef strRef = (__bridge CFStringRef)key;
            CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, strRef);
            CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
            //CFStringTransform(string, NULL, kCFStringTransformToUnicodeName, NO);
            pinyin = [((__bridge NSString *)string) copy];
            
            CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
            phone = [((__bridge NSString *)string) copy];
            
            NSLog(@"解析之后的拼音 %@", string);
        }
        record.chinese = [result copy];
        record.phone = [phone copy];
        record.pinyin = [pinyin copy];
        
        [self.arrAudioHistory insertObject:record atIndex:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [audioTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [_iflySpeechRecognizer cancel];
    }
}

- (void)onError:(IFlySpeechError *)error
{
    //DLog(@"识别发生错误: error: %@", error);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"识别结束";
    hud.animationType = MBProgressHUDAnimationZoomOut;
    [hud hide:YES afterDelay:0.8];
}


#pragma mark - IFlySpeechRecognizerDelegate
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    if (!isLast) {
        //DLog(@"识别结束之后的结果: results: %@", results);
        
        NSMutableString *result = [[NSMutableString alloc] init];
        NSString *pinyin;
        NSString *phone;
        
        NSDictionary *dic = [results objectAtIndex:0];
        //DLog(@"识别出来的字符: %@", dic);
        
        AudioRecord *record = [[AudioRecord alloc] init];
        
        for (NSString *key in dic)
        {
            [result appendFormat:@"%@",key];
            
            //NSString *str = [self replaceUnicode:key];
            CFStringRef strRef = (__bridge CFStringRef)key;
            CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, strRef);
            CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
            //CFStringTransform(string, NULL, kCFStringTransformToUnicodeName, NO);
            pinyin = [((__bridge NSString *)string) copy];
            
            CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
            phone = [((__bridge NSString *)string) copy];
            
            NSLog(@"解析之后的拼音 %@", string);
        }
        record.chinese = [result copy];
        record.phone = [phone copy];
        record.pinyin = [pinyin copy];
        
        [self.arrAudioHistory insertObject:record atIndex:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [audioTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        [_iflyRecognizerView cancel];
    }
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.arrAudioHistory count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    AudioRecord *record = [self.arrAudioHistory objectAtIndex:indexPath.row];
    
    NSString *result = [[NSString alloc] initWithFormat:@"识别: \t%@", record.chinese];
    NSString *phone = [[NSString alloc] initWithFormat:@"无声调: \t%@", record.phone];
    
    cell.textLabel.text = result;
    cell.detailTextLabel.text = phone;
    
    if ([record.phone isEqualToString:identify]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 68;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AudioHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    header.textLabel.text = identify;
    
    return header;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.arrAudioHistory removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - 属性
- (NSMutableArray *)arrAudioHistory
{
    if (!_arrAudioHistory) {
        _arrAudioHistory = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _arrAudioHistory;
}

@end
