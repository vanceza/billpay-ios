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
- (void)updateRandomBillItem;
- (void)billChanged;
@property NSMutableArray *dataStore;
@end

@implementation BillDataController
@synthesize dataStore = _dataStore;
@synthesize totalBeforeTaxOrTip = _totalBeforeTaxOrTip, randomBillItem = _randomBillItem, taxPercent = _taxPercent, tipPercent=_tipPercent;

-(void) updateRandomBillItem
{
    if([self countOfList] > 0) {
        NSInteger totalCostInCents = self.totalBeforeTaxOrTip.inCents;
        NSInteger randomCent = arc4random_uniform(totalCostInCents)+1;
        NSInteger i=0;
        while(randomCent>=0)
        {
            randomCent-=[self objectInListAtIndex:i].cost.inCents;
            i++;
        }
        _randomBillItem = [self objectInListAtIndex:i-1]; //TODO
    } else {
        _randomBillItem = nil;
    }
}

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
    [self addBillItemWithDollars:1 cents:00 description:@"Sprite"];
    [self addBillItemWithDollars:1 cents:50 description:@"Hot Tea"];
    [self addBillItemWithDollars:2 cents:50 description:@"Fried Rice"];
    [self addBillItemWithDollars:0 cents:75 description:@"Spring Roll"];
    [self addBillItemWithDollars:4 cents:25 description:@"Lo Mein"];
    [self updateRandomBillItem];
}
         
- (NSInteger) countOfList
{
    return [self.dataStore count];
}

- (BillItem *)objectInListAtIndex:(NSInteger)theIndex
{
    return [self.dataStore objectAtIndex:theIndex];
}

- (void)billChanged
{
    [self updateTotalBeforeTaxOrTip];
    [self updateRandomBillItem];
}

- (void)removeAllObjects
{
    [self.dataStore removeAllObjects];
    [self billChanged];
}

- (void) removeObjectAtIndex:(NSUInteger)index
{
    [self.dataStore removeObjectAtIndex:index];
    [self billChanged];
}
     
- (void)addBillItem:(BillItem *)item
{
    [self.dataStore addObject:item];
    [self billChanged];
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
