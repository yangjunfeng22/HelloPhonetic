//
//  ToneLabel.m
//  HelloMyWords
//
//  Created by junfengyang on 15/6/15.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "ToneLabel.h"
#import <QuartzCore/QuartzCore.h>

#define toneHeight 2

@interface ToneLabelLayer : CALayer

@property (nonatomic, strong) UIColor *toneTintColor;
@property (nonatomic) NSInteger tone;


@end

@implementation ToneLabelLayer

@dynamic toneTintColor;


+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"tone"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void)setTone:(NSInteger)tone
{
    _tone = tone;
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx
{
    [super drawInContext:ctx];
    
    switch (self.tone) {
        case 1:
            [self drawLevelToneInContext:ctx];
            break;
        case 2:
            [self drawRisingToneInContext:ctx];
            break;
        case 3:
            [self drawThirdToneInContext:ctx];
            break;
        case 4:
            [self drawFallingToneInContext:ctx];
            break;
        case 11:
            
            break;
        case 12:
            
            break;
        case 13:
            break;
        case 14:
            
            break;
        case 21:
            
            break;
        case 22:
            
            break;
        case 23:
            
            break;
        case 24:
            
            break;
        case 31:
            
            break;
        case 32:
            
            break;
        case 33:
            
            break;
        case 34:
            
            break;
        case 41:
            
            break;
        case 42:
            
            break;
        case 43:
            
            break;
        case 44:
            
            break;
            
        default:
            [self clearToneInContext:ctx];
            break;
    }
}

// 阴平(1声)
- (void)drawLevelToneInContext:(CGContextRef)ctx
{
    CGRect rect = self.bounds;
    
    CGFloat totalWidth = rect.size.width * 0.4;
    CGRect bFrame = CGRectMake(rect.size.width * 0.3, (rect.size.height-toneHeight)*0.5, totalWidth, toneHeight);
    CGContextSetFillColorWithColor(ctx, self.toneTintColor.CGColor);
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathAddRoundedRect(trackPath, NULL, bFrame, toneHeight*0.5, toneHeight*0.5);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(ctx, trackPath);
    CGContextFillPath(ctx);
    CGPathRelease(trackPath);
}

// 阳平(2声)
- (void)drawRisingToneInContext:(CGContextRef)ctx
{
    CGRect rect = self.bounds;
    CGFloat totalWidth = rect.size.width * 0.4;
    
    /*************************** 转换坐标系 *****************************/
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y);//4
    CGContextTranslateCTM(ctx, rect.size.width*0.5, rect.size.height*0.5);//3
    CGContextScaleCTM(ctx, 1.0, -1.0);//2
    /*************************** 转换坐标系 *****************************/
    
    // 音调条的背景
    CGRect bFrame = CGRectMake(-totalWidth*0.5, -toneHeight*0.5, totalWidth, toneHeight);
    CGContextSetFillColorWithColor(ctx, self.toneTintColor.CGColor);
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGAffineTransform m = CGAffineTransformMakeRotation(M_PI_4*0.5);
    CGPathAddRoundedRect(trackPath, &m, bFrame, toneHeight*0.5, toneHeight*0.5);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(ctx, trackPath);
    CGContextFillPath(ctx);
    CGPathRelease(trackPath);
    
    CGContextRestoreGState(ctx);
}

// 上声(3声)
- (void)drawThirdToneInContext:(CGContextRef)ctx
{
    CGRect rect = self.bounds;
    CGFloat totalWidth = rect.size.width * 0.4;
    CGFloat s = fabs(totalWidth*0.5 / cos(M_PI_4*0.4));
    
    /*************************** 转换坐标系 *****************************/
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y);//4
    CGContextTranslateCTM(ctx, rect.size.width*0.5, rect.size.height*0.5);//3
    CGContextScaleCTM(ctx, 1.0, -1.0);//2
    /*************************** 转换坐标系 *****************************/
    
    // 音调条
    CGRect bf1 = CGRectMake(-totalWidth*0.5-3, -toneHeight*1.1, s+5, toneHeight);
    CGRect bf2 = CGRectMake(totalWidth*0.5-s-5+3, -toneHeight*1.1, s+5, toneHeight);
    CGAffineTransform t1 = CGAffineTransformMakeRotation(-M_PI_4*1.2);
    CGAffineTransform t2 = CGAffineTransformMakeRotation(M_PI_4*1.2);
    
    CGContextSetFillColorWithColor(ctx, self.toneTintColor.CGColor);
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathAddRoundedRect(trackPath, &t1, bf1, toneHeight*0.5, toneHeight*0.5);
    CGPathAddRoundedRect(trackPath, &t2, bf2, toneHeight*0.5, toneHeight*0.5);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(ctx, trackPath);
    CGContextFillPath(ctx);
    CGPathRelease(trackPath);
    
    CGContextRestoreGState(ctx);
}

// 去声(4声)
- (void)drawFallingToneInContext:(CGContextRef)ctx
{
    CGRect rect = self.bounds;
    CGFloat totalWidth = rect.size.width * 0.4;
    
    /*************************** 转换坐标系 *****************************/
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y);//4
    CGContextTranslateCTM(ctx, rect.size.width*0.5, rect.size.height*0.5);//3
    CGContextScaleCTM(ctx, 1.0, -1.0);//2
    /*************************** 转换坐标系 *****************************/
    
    // 音调条的背景
    CGRect bFrame = CGRectMake(-totalWidth*0.5, -toneHeight*0.5, totalWidth, toneHeight);
    CGContextSetFillColorWithColor(ctx, self.toneTintColor.CGColor);
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGAffineTransform m = CGAffineTransformMakeRotation(-M_PI_4*0.5);
    CGPathAddRoundedRect(trackPath, &m, bFrame, toneHeight*0.5, toneHeight*0.5);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(ctx, trackPath);
    CGContextFillPath(ctx);
    CGPathRelease(trackPath);
    
    CGContextRestoreGState(ctx);
}

- (void)clearToneInContext:(CGContextRef)ctx
{
    CGRect rect = self.bounds;
    CGContextClearRect(ctx, rect);
}

@end


@implementation ToneLabel

+ (void)initialize
{
    if (self == [ToneLabel class]) {
        ToneLabel *toneButtonAppearance = [ToneLabel appearance];
        [toneButtonAppearance setToneTintColor:[UIColor whiteColor]];
        [toneButtonAppearance setBackgroundColor:[UIColor whiteColor]];
    }
}

+ (Class)layerClass
{
    return [ToneLabelLayer class];
}

- (ToneLabelLayer *)toneLayer
{
    return (ToneLabelLayer *)self.layer;
}

- (instancetype)init
{
    return [super initWithFrame:CGRectMake(0, 0, 40, 40)];
}

- (void)didMoveToWindow
{
    CGFloat windowContentsScale = self.window.screen.scale;
    self.toneLayer.contentsScale = windowContentsScale;
    [self.toneLayer setNeedsDisplay];
}

- (void)clearTone
{
    // 重新设置
    [self toneLayer].tone = -1;
}

- (NSInteger)tone
{
    return self.toneLayer.tone;
}

- (void)setTone:(NSInteger)tone
{
    self.toneLayer.tone = tone;
}

#pragma mark - UIAppearance methods
- (UIColor *)toneTintColor
{
    return self.toneLayer.toneTintColor;
}

-(void)setToneTintColor:(UIColor *)toneTintColor
{
    self.toneLayer.toneTintColor = toneTintColor;
    [self.toneLayer setNeedsDisplay];
}

@end
