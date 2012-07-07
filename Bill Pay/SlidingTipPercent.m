//
//  SlidingTipPercent.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/6/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "SlidingTipPercent.h"

static NSString *slidingTipBillData = @"Total after tax and before tip, in the data model";
static NSString *slidingTipTotalData = @"Total after both tax and tip, in the data model";
static NSString *slidingTipTipAmount = @"Tip amount, in the data model";
static NSString *slidingTipTipPercentage = @"Tip percentage, in the data model";

@interface SlidingTipPercent ()
-(void)updateBill;
-(void)updateTotal;
-(void)updateTipAmount;
-(void)updateTipPercentage;
-(void)configureSlider;
@end

@implementation SlidingTipPercent
@synthesize billAmountLabel;
@synthesize tipPercentLabel;
@synthesize tipAmountLabel;
@synthesize totalAmountLabel;
@synthesize tipPercentSlider;
@synthesize dataController = _dataController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self configureSlider];
    [self updateBill];
    [self updateTipAmount];
    [self updateTipPercentage];
    [self updateTotal];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setBillAmountLabel:nil];
    [self setTipPercentLabel:nil];
    [self setTipAmountLabel:nil];
    [self setTotalAmountLabel:nil];
    [self setTipPercentSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)setDataController:(BillDataController *)dataController
{
    if(_dataController==dataController)
        return;
    if(_dataController)
    {
        [_dataController removeObserver:self forKeyPath:@"totalAfterTaxBeforeTip" context:&slidingTipBillData];
        [_dataController removeObserver:self forKeyPath:@"tipPercent" context:&slidingTipTipPercentage];
        [_dataController removeObserver:self forKeyPath:@"tip" context:&slidingTipTipAmount];
        [_dataController removeObserver:self forKeyPath:@"totalAfterTaxAndTip" context:&slidingTipTotalData];        
    }
    
    if(dataController)
    {
        [dataController addObserver:self forKeyPath:@"totalAfterTaxBeforeTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&slidingTipBillData];
        [dataController addObserver:self forKeyPath:@"tipPercent" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&slidingTipTipPercentage];
        [dataController addObserver:self forKeyPath:@"tip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&slidingTipTipAmount];
        [dataController addObserver:self forKeyPath:@"totalAfterTaxAndTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&slidingTipTotalData];
    }
    _dataController = dataController;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context==&slidingTipBillData) {
        [self updateBill];
    } else if(context == &slidingTipTipPercentage) {
        [self updateTipPercentage];
    } else if(context == &slidingTipTipAmount) {
        [self updateTipAmount];
    } else if(context == &slidingTipTotalData) {
        [self updateTotal];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)updateBill
{
    if(self.billAmountLabel)
    {
        self.billAmountLabel.text = self.dataController.totalAfterTaxBeforeTip.asString;
    }
}

-(void)updateTotal
{
    if(self.totalAmountLabel)
    {
        self.totalAmountLabel.text = self.dataController.totalAfterTaxAndTip.asString;
    }
}

-(void)updateTipAmount
{
    if(self.tipAmountLabel)
    {
        self.tipAmountLabel.text = self.dataController.tip.asString;
    }
}

-(void)updateTipPercentage
{
    if(self.tipPercentLabel)
    {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterPercentStyle];
        [formatter setMaximumFractionDigits:2];
        NSNumber *percent = self.dataController.tipPercent;
        self.tipPercentLabel.text = [formatter stringFromNumber:percent];
    }
}

-(void)configureSlider
{
    if(self.tipPercentSlider)
    {
        float percent = [self.dataController.tipPercent floatValue];
        self.tipPercentSlider.value = percent;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sliderValueChanged:(id)sender {
    NSDecimalNumber *fraction = [[NSDecimalNumber alloc] initWithFloat:self.tipPercentSlider.value];
    self.dataController.tipPercent = fraction;
}

- (void)dealloc
{
    self.dataController= nil;
}

@end
