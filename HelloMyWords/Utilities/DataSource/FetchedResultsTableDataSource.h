//
//  FetchedResultsTableDataSource.h
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/17.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^ConfigureBlock)(id cell, id item, id indexPath);

@interface FetchedResultsTableDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, copy) ConfigureBlock configureCellBlock;

- (id)initWithTableView:(UITableView *)aTableView fetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController;
- (id)initWithTableView:(UITableView *)aTableView cellIdentifier:(NSString *)cellIdentifier fetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController;
- (void)changePredicate:(NSPredicate *)predicate;
- (id)selectedItem;


@end
