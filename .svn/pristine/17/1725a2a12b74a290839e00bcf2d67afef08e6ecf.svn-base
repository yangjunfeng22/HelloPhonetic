//
//  FetchedResultsCollectionDataSource.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/28.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ConfigureBlock)(id cell, id item, id indexPath);;

@interface FetchedResultsCollectionDataSource : NSObject<UICollectionViewDataSource>
@property (nonatomic, copy)ConfigureBlock configureCellBlock;

- (id)initWithCollectionView:(UICollectionView *)aCollectionView cellIdentifiers:(NSDictionary *)cellIdentifiers fetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController;
- (void)changePredicate:(NSPredicate *)predicate;
- (id)selectedItem;

@end
