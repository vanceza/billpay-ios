//
//  BillItem.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "BillItem.h"

@implementation BillItem

@synthesize cost=_cost;
@synthesize description=_description;

- (id) initWithCost:(NSNumber *)theCost description:(NSString *) theDescription
{
    self = [super init];
    if (self) {
        _cost = theCost;
        _description = theDescription;
        return self;
    }
    return nil;
}

@end