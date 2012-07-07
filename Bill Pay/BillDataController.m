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
- (void)updateTotalBeforeTaxOrTip;
@property NSMutableArray *dataStore;
@end

@implementation BillDataController
@synthesize dataStore = _dataStore;
@synthesize totalBeforeTaxOrTip = _totalBeforeTaxOrTip;
@synthesize taxPercent = _taxPercent, tipPercent=_tipPercent;

- (id)init 
{
    if (self = [super init]) {
        [self initializeDefaultDataList];
        self.taxPercent = [NSDecimalNumber decimalNumberWithString:@"0.0825"];
        self.tipPercent = [NSDecimalNumber decimalNumberWithString:@"0.15"];
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
    [self updateTotalBeforeTaxOrTip];
}

- (void)addBillItemWithDollars:(NSInteger)dollars cents:(NSInteger)cents description:(NSString *) description 
{
    Cost *cost = [[Cost alloc] initFromDollars:dollars cents:cents];
    [self addBillItem:[[BillItem alloc] initWithCost:cost description:description]];
}

- (void)updateTotalBeforeTaxOrTip
{
    NSInteger totalCostInCents=0;
    BillItem *i = [BillItem alloc];
    for(i in self.dataStore)
    {
        totalCostInCents += i.cost.inCents;
    }
    Cost *ret = [[Cost alloc] initFromCostInCents:totalCostInCents];
    self.totalBeforeTaxOrTip = ret;
}

- (Cost *) tax
{
    return [self.totalBeforeTaxOrTip costByMultiplyingBy:self.taxPercent];
}

- (Cost *) tip
{
    return [self.totalAfterTaxBeforeTip costByMultiplyingBy:self.tipPercent];
}

- (Cost *) totalAfterTaxBeforeTip
{
    return [self.totalBeforeTaxOrTip costByAdding:self.tax];
}

- (Cost *) totalAfterTaxAndTip
{
    return [self.totalAfterTaxBeforeTip costByAdding:self.tip];
}

+ (NSSet *)keyPathsForValuesAffectingTax
{
    return [NSSet setWithObjects:@"taxPercent", @"totalBeforeTaxOrTip", nil];
}

+ (NSSet *)keyPathsForValuesAffectingTip
{
    return [NSSet setWithObjects:@"tipPercent", @"totalAfterTaxBeforeTip", nil];
}

+ (NSSet *)keyPathsForValuesAffectingTotalAfterTaxBeforeTip
{
    return [NSSet setWithObjects:@"totalBeforeTaxOrTip", @"tax", nil];
}

+ (NSSet *)keyPathsForValuesAffectingTotalAfterTaxAndTip
{
    return [NSSet setWithObjects:@"totalAfterTaxBeforeTip", @"tip", nil];
}

//- (IBAction)goBackFromBill:(id)sender {
//    [[self delegate] finishViewControllerDidGoBack:self];
//}

@end
