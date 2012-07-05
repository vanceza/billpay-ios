//
//  Cost.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "Cost.h"

@implementation Cost
{
}

@synthesize dollars = _dollars, cents = _cents;

- (NSString *)asString
{
    return [[NSString alloc] initWithFormat:@"$%d.%02d", self.dollars, self.cents];
}

-(id)init
{
    return [self initFromCostInCents:0];
}

-(id)initFromDollars:(NSInteger)dollars cents:(NSInteger)cents
{
    self = [super init];
    if(self)
    {
        _dollars = dollars;
        _cents = cents;
        return self;
    }
    return nil;
}

-(id)initFromCostInCents:(NSInteger)cents
{
    self = [super init];
    if(self)
    {
        _cents = cents % 100;
        _dollars = (cents - _cents) / 100;
        return self;
    }
    return nil;
}

-(NSInteger)inCents
{
    return self.dollars * 100 + self.cents;
}
@end
