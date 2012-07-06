//
//  FinishViewControllerViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "MasterViewController.h"
#import "BillViewController.h"

static NSString *totalBeforeTaxOrTip = @"Total before tax or tip";

@interface MasterViewController ()
//- (void)configureView;
-(void)updateTotalBeforeTaxOrTip;
@end

@implementation MasterViewController
@synthesize totalCostLabel = _totalCostLabel;
@synthesize cost = _cost;
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
	// Do any additional setup after loading the view.
}

- (void) setDataController:(BillDataController *)dataController
{
    if(_dataController)
    {
        [dataController removeObserver:self forKeyPath:@"totalBeforeTaxOrTip" context:&totalBeforeTaxOrTip];
        _dataController = nil;
    }
    _dataController = dataController;
    [dataController addObserver:self forKeyPath:@"totalBeforeTaxOrTip" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:&totalBeforeTaxOrTip];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context == &totalBeforeTaxOrTip)
    {
        [self updateTotalBeforeTaxOrTip];
    }
}

-(void)updateTotalBeforeTaxOrTip
{
    if(self.totalCostLabel) {
        BillDataController *data = self.dataController;
        self.cost = [data.totalBeforeTaxOrTip asString];
        self.totalCostLabel.text = self.cost;
    }
}

- (void)viewDidUnload
{
    [self setTotalCostLabel:nil];
    self.dataController = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"EditBill"]) {
        BillViewController *billController = (BillViewController *)[segue destinationViewController];
        billController.dataController = self.dataController;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
