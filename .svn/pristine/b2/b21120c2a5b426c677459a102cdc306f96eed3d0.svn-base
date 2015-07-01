//
//  ToneKnowledge+Record.m
//  HelloMyWords
//
//  Created by junfengyang on 15/6/12.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "ToneKnowledge+Record.h"

@implementation ToneKnowledge (Record)

+ (instancetype)findOrCreateWithIdentifier:(id)identifier inContext:(NSManagedObjectContext *)context
{
    NSString *entityName = NSStringFromClass(self);
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"tone == %@", identifier];
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

+ (void)recordToneKnowledge:(Record *)record intoContext:(NSManagedObjectContext *)context
{
    ToneKnowledge *toneKno = [self findOrCreateWithIdentifier:record.tone inContext:context];
    toneKno.tone = record.tone;
    toneKno.wrongTimes = record.wrongTimes;
    toneKno.rightTimes = record.rightTimes;
    toneKno.learnType = record.learnType;
}

+ (void)importToneKnowledgeComponents:(NSArray *)components intoContext:(NSManagedObjectContext *)context
{
    // identifier为chinese+tone。
    NSString *tone      = components[0];
    NSString *type      = components[4];
    NSString *weight    = components[5];
    NSNumber *learnType = @(type.integerValue);
    NSNumber *nWeight   = @(weight.floatValue);
    
    //DLog(@"chinese: %@, type: %@", chinese, learnType);
    
    NSString *recordID  = [[NSString alloc] initWithFormat:@"%@", tone];
    
    ToneKnowledge *toneKno = [self findOrCreateWithIdentifier:recordID inContext:context];
    toneKno.tone           = tone;
    toneKno.learnType      = learnType;
    toneKno.weight         = nWeight;
}

@end
