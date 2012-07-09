//
//  MasterViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "MasterViewController.h"
#import "BillViewController.h"
#import "SlidingTaxPercentController.h"
#import "SlidingTipPercent.h"
#import "PayViewController.h"

static NSString *mstrTotalBeforeTaxOrTip = @"Total before tax or tip";
static NSString *mstrTax = @"Tax";
static NSString *mstrTip = @"Tip";
static NSString *mstrTotalAfterTaxAndTip = @"Total after tax and tip";

@interface MasterViewController ()
//- (void)configureView;
-(void)updateTotalBeforeTaxOrTip;
-(void)updateTip;
-(void)updateTax;
-(void)updateTotalAfterTaxAndTip;
@end

@implementation MasterViewController
@synthesize deleteButton = _deleteButton;
@synthesize payButton = _payButton;
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
    if(_dataController == dataController)
        return;
    if(_dataController)
    {
        [dataController removeObserver:self forKeyPath:@"totalBeforeTaxOrTip" context:&mstrTotalBeforeTaxOrTip];
        [dataController removeObserver:self forKeyPath:@"tax" context:&mstrTax];
        [dataController removeObserver:self forKeyPath:@"tip" context:&mstrTip];
        [dataController removeObserver:self forKeyPath:@"totalAfterTaxAndTip" context:&mstrTotalAfterTaxAndTip];
    }
    if(dataController)
    {
        [dataController addObserver:self forKeyPath:@"totalBeforeTaxOrTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&mstrTotalBeforeTaxOrTip];
        [dataController addObserver:self forKeyPath:@"tax" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&mstrTax];
        [dataController addObserver:self forKeyPath:@"tip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&mstrTip];
        [dataController addObserver:self forKeyPath:@"totalAfterTaxAndTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&mstrTotalAfterTaxAndTip];
    }
    _dataController = dataController;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context == &mstrTotalBeforeTaxOrTip) {
        [self updateTotalBeforeTaxOrTip];
    } else if(context == &mstrTax) {
        [self updateTax];
    } else if(context == &mstrTip) {
        [self updateTip];
    } else if(context == &mstrTotalAfterTaxAndTip) {
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
    [self setTaxCostLabel:nil];
    [self setTipCostLabel:nil];
    [self setTotalCostLabel:nil];
    [self setDeleteButton:nil];
    [self setPayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)dealloc
{
    self.dataController=nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row]==0) {
        static NSString *dynamicCellName = @"bill";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellName];
        self.billCostLabel = cell.detailTextLabel;
        [self updateTotalBeforeTaxOrTip];
        return cell;
    } else if([indexPath row]==1) {
        static NSString *dynamicCellName = @"tax";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellName];
        self.taxCostLabel = cell.detailTextLabel;
        [self updateTax];
        return cell;
    } else if([indexPath row]==2) {
        static NSString *dynamicCellName = @"tip";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellName];
        self.tipCostLabel = cell.detailTextLabel;
        [self updateTip];
        return cell;
    } else if([indexPath row]==3) {
        static NSString *dynamicCellName = @"total";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellName];
        self.totalCostLabel = cell.detailTextLabel;
        [self updateTotalAfterTaxAndTip];
        return cell;
    } 
    assert(false);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"EditBill"]) {
        BillViewController *billController = (BillViewController *)[segue destinationViewController];
        billController.dataController = self.dataController;
    } else if ([[segue identifier] isEqualToString:@"ChangeTax"]) {
        SlidingTaxPercentController *slidingController = (SlidingTaxPercentController *)[segue destinationViewController];
        slidingController.dataController = self.dataController;
    } else if ([[segue identifier] isEqualToString:@"ChangeTip"]) {
        SlidingTipPercent *slidingController = (SlidingTipPercent *)[segue destinationViewController];
        slidingController.dataController = self.dataController;
    } else if ([[segue identifier] isEqualToString:@"Pay"]) {
        PayViewController *payController = (PayViewController *)[segue destinationViewController];        payController.dataController = self.dataController;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)deletePressed:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Clear Bill" otherButtonTitles:nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self.dataController removeAllObjects];
    }
}

@end
