//
//  ArrayDataSource.h
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/4.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TableViewCellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject<UITableViewDataSource>

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
