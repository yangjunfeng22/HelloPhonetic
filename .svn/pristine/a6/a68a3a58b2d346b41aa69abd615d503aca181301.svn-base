//
//  Store.m
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/18.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "Store.h"
#import <CoreData/CoreData.h>
@interface Store ()
@property (nonatomic, strong, readwrite) NSManagedObjectContext *mainManagedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation Store
- (instancetype)init
{
    if (self = [super init]) {
        [self setupSaveNofification];
    }
    return self;
}

- (void)setupSaveNofification
{
    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSManagedObjectContext *moc = self.mainManagedObjectContext;
        if (note.object != moc) {
            [moc performBlock:^{
                [moc mergeChangesFromContextDidSaveNotification:note];
            }];
        }
    }];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.mainManagedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // 如果已经有改变，且这个改变没有被保存, 那说明出错了。
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)mainManagedObjectContext
{
    if (_mainManagedObjectContext != nil) {
        return _mainManagedObjectContext;
    }
    
    _mainManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _mainManagedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
    return _mainManagedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HelloMyWords" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    // FIXME:后期修改成工程里面的sqlite文件
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HelloMyWords.sqlite"];
    
    DLog(@"数据库文件地址: %@", storeURL);
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        //
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectContext *)privateContext
{
    // 设置一个 persistent store coordinator 和两个独立的 contexts 被证明了是在后台处理 Core Data 的好方法。
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = [self persistentStoreCoordinator];
    return context;
}

@end
