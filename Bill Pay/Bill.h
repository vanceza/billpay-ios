//
//  Bill.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillItem.h"

@interface Bill : UITableViewController

- (NSInteger)countOfList;
- (BillItem *)objectInListAtIndex:(NSInteger)theIndex;
- (void)addBillItemWithCost:(NSNumber *)inputBillCost description:(NSString *)description;
@property (nonatomic, readonly) Bill *dataController;

@property (nonatomic, copy, readonly) NSNumber *totalBeforeTax;
@end
