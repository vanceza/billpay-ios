//
//  BillDataController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "BillDataController.h"
#import "Cost.h"

@interface BillDataController ()
- (void) initializeDefaultDataList;
@property NSMutableArray *dataStore;
@end

@implementation BillDataController
@synthesize dataStore = _dataStore;

- (id)init 
{
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void) initializeDefaultDataList
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    self.dataStore = list;
    [self addBillItemWithDollars:1 cents:20 description:@"Description here"];
}

- (NSInteger) countOfList
{
    return [self.dataStore count];
}

- (BillItem *)objectInListAtIndex:(NSInteger)theIndex
{
    return [self.dataStore objectAtIndex:theIndex];
}

- (void)addBillItem:(BillItem *)item
{
    [self.dataStore addObject:item];
}

- (void)addBillItemWithDollars:(NSInteger)dollars cents:(NSInteger)cents description:(NSString *) description 
{
    Cost *cost = [[Cost alloc] initFromDollars:dollars cents:cents];
    [self addBillItem:[[BillItem alloc] initWithCost:cost description:description]];
}

- (Cost *)totalBeforeTaxOrTip
{
    NSInteger totalCostInCents=0;
    BillItem *i = [BillItem alloc];
    for(i in self.dataStore)
    {
        totalCostInCents += i.cost.inCents;
    }
    Cost *ret = [[Cost alloc] initFromCostInCents:totalCostInCents]; 
    return ret;
}

//- (IBAction)goBackFromBill:(id)sender {
//    [[self delegate] finishViewControllerDidGoBack:self];
//}

@end
