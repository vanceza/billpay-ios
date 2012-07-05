//
//  BillItem.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "BillItem.h"


@interface BillItem ()
@end

@implementation BillItem

@synthesize cost = _cost;
@synthesize costInCents=_costInCents;
@synthesize description=_description;

- (id) initWithCost:(Cost *)theCost description:(NSString *) theDescription
{
    self = [super init];
    if (self) {
        _cost = theCost;
        _description = theDescription;
        return self;
    }
    return nil;
}

//- (id) initWithCostInCents:(NSInteger)theCost description:(NSString *) theDescription
//{
//    self = [super init];
//    if (self) {
//        _cost = [[Cost alloc] initFromCostInCents:theCost];
//        _description = theDescription;
//        return self;
//    }
//    return nil;
//}

- (NSInteger) dollars
{
    return [self.cost dollars];
}

- (NSInteger) cents
{
    return [self.cost cents];
}

- (NSInteger) costInCents
{
    return [self.cost inCents];
}

- (NSString *) costAsString
{
    return [self.cost asString];
}


@end