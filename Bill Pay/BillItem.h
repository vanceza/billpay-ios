//
//  BillItem.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cost.h"

@interface BillItem : NSObject

@property (readonly) NSInteger costInCents;
@property (readonly) NSInteger dollars;
@property (readonly) NSInteger cents;
@property (copy, nonatomic) Cost *cost;
- (NSString *)costAsString;
@property (nonatomic, copy) NSString *description;

//- (id) initWithCostInCents:(NSInteger)theCost description:(NSString *) theDescription;
- (id) initWithCost:(Cost *)theCost description:(NSString *) theDescription;

@end
