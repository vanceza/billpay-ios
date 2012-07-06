//
//  FinishViewControllerViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "MasterViewController.h"
#import "BillViewController.h"
#import "SlidingPercentController.h"

static NSString *totalBeforeTaxOrTip = @"Total before tax or tip";
static NSString *tax = @"Tax";
static NSString *tip = @"Tip";
static NSString *totalAfterTaxAndTip = @"Total after tax and tip";

@interface MasterViewController ()
//- (void)configureView;
-(void)updateTotalBeforeTaxOrTip;
-(void)updateTip;
-(void)updateTax;
-(void)updateTotalAfterTaxAndTip;
@end

@implementation MasterViewController
@synthesize billCostLabel = _billCostLabel;
@synthesize taxCostLabel = _taxCostLabel;
@synthesize tipCostLabel = _tipCostLabel;
@synthesize totalCostLabel = _totalCostLabel;
//@synthesize delegate = _delegate;
@synthesize dataController = _dataController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateTotalBeforeTaxOrTip];
    [self updateTax];
    [self updateTip];
    [self updateTotalAfterTaxAndTip];
	// Do any additional setup after loading the view.
}

- (void) setDataController:(BillDataController *)dataController
{
    if(_dataController)
    {
        [dataController removeObserver:self forKeyPath:@"totalBeforeTaxOrTip" context:&totalBeforeTaxOrTip];
        [dataController removeObserver:self forKeyPath:@"tax" context:&tax];
        [dataController removeObserver:self forKeyPath:@"tip" context:&tip];
        [dataController removeObserver:self forKeyPath:@"totalAfterTaxAndTip" context:&totalAfterTaxAndTip];
        _dataController = nil;
    }
    _dataController = dataController;
    [dataController addObserver:self forKeyPath:@"totalBeforeTaxOrTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&totalBeforeTaxOrTip];
    [dataController addObserver:self forKeyPath:@"tax" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&tax];
    [dataController addObserver:self forKeyPath:@"tip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&tip];
    [dataController addObserver:self forKeyPath:@"totalAfterTaxAndTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&totalAfterTaxAndTip];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context == &totalBeforeTaxOrTip) {
        [self updateTotalBeforeTaxOrTip];
    } else if(context == &tax) {
        [self updateTax];
    } else if(context == &tip) {
        [self updateTip];
    } else if(context == &totalAfterTaxAndTip) {
        [self updateTotalAfterTaxAndTip];
    }
}

-(void)updateTotalBeforeTaxOrTip
{
    if(self.billCostLabel) {
        self.billCostLabel.text = self.dataController.totalBeforeTaxOrTip.asString;
    }
}

-(void)updateTip
{
    if(self.tipCostLabel) {
        self.tipCostLabel.text = self.dataController.tip.asString;
    }
}

-(void)updateTax
{
    if(self.taxCostLabel) {
        self.taxCostLabel.text = self.dataController.tax.asString;
    }
}

-(void)updateTotalAfterTaxAndTip
{
    if(self.totalCostLabel) {
        self.totalCostLabel.text = self.dataController.totalAfterTaxAndTip.asString;
    }
}

- (void)viewDidUnload
{
    [self setBillCostLabel:nil];
    self.dataController = nil;
    [self setTaxCostLabel:nil];
    [self setTipCostLabel:nil];
    [self setTotalCostLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"EditBill"]) {
        BillViewController *billController = (BillViewController *)[segue destinationViewController];
        billController.dataController = self.dataController;
    } else if ([[segue identifier] isEqualToString:@"ChangeTax"]) {
        SlidingPercentController *slidingController = (SlidingPercentController *)[segue destinationViewController];
        slidingController.dataController = self.dataController;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
