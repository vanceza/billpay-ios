//
//  SlidingTaxPercentController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/6/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "SlidingTaxPercentController.h"

static NSString *dataTaxPercent = @"The percent tax in the data model";
static NSString *dataTax = @"The tax in the data model";
static NSString *dataTotalAfterTax = @"The total after tax, but before tup, in the data model";
static NSString *dataOriginalBillTotal = @"The bill total in the data model";

@interface SlidingTaxPercentController ()
-(void)updateTax;
-(void)updateTaxPercent;
-(void)updateTotalAfterTax;
-(void)updateBill;
-(void)configureSlider;
@end

@implementation SlidingTaxPercentController
@synthesize billLabel;
@synthesize taxPercent;
@synthesize taxSlider;
@synthesize taxLabel;
@synthesize totalLabel;
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
    [super viewDidLoad];
    [self configureSlider];
    [self updateTax];
    [self updateTaxPercent];
    [self updateTotalAfterTax];
    [self updateBill];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setTaxPercent:nil];
    [self setTaxSlider:nil];
    [self setTaxLabel:nil];
    [self setTotalLabel:nil];
    [self setBillLabel:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) setDataController:(BillDataController *)dataController
{    
    if(_dataController==dataController)
        return;
    
    if(_dataController)
    {
        [_dataController removeObserver:self forKeyPath:@"taxPercent" context:&dataTaxPercent];
        [_dataController removeObserver:self forKeyPath:@"tax" context:&dataTax];
        [_dataController removeObserver:self forKeyPath:@"totalAfterTaxBeforeTip" context:&dataTotalAfterTax];
        [_dataController removeObserver:self forKeyPath:@"totalBeforeTaxOrTip" context:&dataOriginalBillTotal];
    }
    
    if(dataController)
    {
        [dataController addObserver:self forKeyPath:@"taxPercent" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&dataTaxPercent];
        [dataController addObserver:self forKeyPath:@"tax" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&dataTax];
        [dataController addObserver:self forKeyPath:@"totalAfterTaxBeforeTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&dataTotalAfterTax];
        [dataController addObserver:self forKeyPath:@"totalBeforeTaxOrTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&dataOriginalBillTotal];
    }
    _dataController = dataController;
 }

- (void)dealloc
{
    self.dataController = nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context == &dataTaxPercent) {
        [self updateTaxPercent];
    } else if(context == &dataTax) {
        [self updateTax];
    } else if(context == &dataTotalAfterTax) {
        [self updateTotalAfterTax];
    } else if(context == &dataOriginalBillTotal) {
        [self updateBill];
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)configureSlider
{
    float fraction = [self.dataController.taxPercent floatValue];
    self.taxSlider.value = fraction;
}

-(void)updateTax
{
    if(self.taxLabel)
    {
        self.taxLabel.text = self.dataController.tax.asString;
    }
}

-(void)updateBill
{
    if(self.billLabel)
    {
        self.billLabel.text = self.dataController.totalBeforeTaxOrTip.asString;
    }
}

-(void)updateTotalAfterTax
{
    if(self.totalLabel)
    {
        self.totalLabel.text = self.dataController.totalAfterTaxBeforeTip.asString;
    }
}

-(void)updateTaxPercent
{
    if(self.taxPercent)
    {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterPercentStyle];
        [formatter setMaximumFractionDigits:2];
        NSNumber *percent = self.dataController.taxPercent;
        self.taxPercent.text = [formatter stringFromNumber:percent];
    }
}

- (IBAction)sliderChanged:(id)sender {
    NSDecimalNumber *fraction = [[NSDecimalNumber alloc] initWithFloat:self.taxSlider.value];
    self.dataController.taxPercent = fraction;
}
@end
