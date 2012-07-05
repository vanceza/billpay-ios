//
//  BillDataController.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillItem.h"

@interface BillDataController : NSObject
- (NSInteger)countOfList;
- (BillItem *)objectInListAtIndex:(NSInteger)theIndex;
- (void)addBillItem:(BillItem *)item;
- (void)addBillItemWithDollars:(NSInteger)dollars cents:(NSInteger)cents description:(NSString *) description;
@end
