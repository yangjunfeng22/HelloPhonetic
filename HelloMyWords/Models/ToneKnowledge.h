//
//  ToneKnowledge.h
//  HelloMyWords
//
//  Created by junfengyang on 15/6/14.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToneKnowledge : NSManagedObject

@property (nonatomic, retain) NSNumber * learnType;
@property (nonatomic, retain) NSNumber * rightTimes;
@property (nonatomic, retain) NSString * tone;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * wrongTimes;
@property (nonatomic, retain) NSString * wrongTones;

@end
