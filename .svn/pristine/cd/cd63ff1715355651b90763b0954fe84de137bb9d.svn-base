//
//  Record+Import.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/28.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "Record+Import.h"

@implementation Record (Import)

+ (instancetype)findOrCreateWithIdentifier:(id)identifier inContext:(NSManagedObjectContext *)context
{
    NSString *entityName = NSStringFromClass(self);
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"recordID = %@", identifier];
    fetchRequest.fetchLimit = 1;
    fetchRequest.returnsObjectsAsFaults = NO;
    NSError *error = nil;
    id object = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
    if (object == nil)
    {
        // error Happen
        object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    }
    return object;
}

+ (void)importCSVComponents:(NSArray *)components intoContext:(NSManagedObjectContext *)context
{
    // identifier为chinese+tone。
    NSString *chinese   = components[0];
    NSString *pinyin    = components[1];
    NSString *phone     = components[2];
    NSString *tone      = components[3];
    NSString *audioName = components[4];
    NSString *picName   = components[5];
    NSString *type      = components[6];
    NSString *weight    = components[7];
    NSNumber *learnType = @(type.integerValue);
    NSNumber *nWeight   = @(weight.floatValue);
    
    //DLog(@"chinese: %@, type: %@", chinese, learnType);
    
    NSString *recordID  = [[NSString alloc] initWithFormat:@"%@%@%@", chinese, tone, learnType];
    
    Record *record = [self findOrCreateWithIdentifier:recordID inContext:context];
    record.recordID  = recordID;
    record.chinese   = chinese;
    record.pinyin    = pinyin;
    record.phone     = phone;
    record.tone      = tone;
    record.audioName = audioName;
    record.picName   = picName;
    record.learnType = learnType;
    record.weight    = nWeight;
}

@end
