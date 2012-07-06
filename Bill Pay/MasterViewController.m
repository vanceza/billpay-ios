//
//  FinishViewControllerViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "MasterViewController.h"
#import "BillViewController.h"

@interface MasterViewController ()
- (void)configureView;
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
    [self configureView];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTotalCostLabel:nil];
    self.dataController = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)configureView
{
    BillDataController *data = self.dataController;
    self.cost = [data.totalBeforeTaxOrTip asString];
    if(self.totalCostLabel) {
        self.totalCostLabel.text = self.cost;
    }
}

-(void)billChanged
{
    [self configureView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"EditBill"]) {
        //BillViewController *billController = (BillViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        BillViewController *billController = (BillViewController *)[segue destinationViewController];
        billController.delegate = self;
        billController.dataController = self.dataController;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
