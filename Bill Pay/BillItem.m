//
//  BillItem.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "BillItem.h"

@implementation BillItem

@synthesize costInCents=_cost;
@synthesize description=_description;

- (id) initWithCostInCents:(NSInteger)theCost description:(NSString *) theDescription
{
    self = [super init];
    if (self) {
        _cost = theCost;
        _description = theDescription;
        return self;
    }
    return nil;
}

- (NSInteger) dollars
{
    return (self.costInCents - self.cents) / 100;
}

- (NSInteger) cents
{
    return (self.costInCents % 100);
}

- (NSString *)costAsString
{
    return [[NSString alloc] initWithFormat:@"$%d.%02d", self.dollars, self.cents];
}

@end