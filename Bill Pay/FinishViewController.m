//
//  FinishViewControllerViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "FinishViewController.h"

@interface FinishViewController ()
- (void)configureView;
@end

@implementation FinishViewController
@synthesize totalCostLabel = _totalCostLabel;
@synthesize cost = _cost;
@synthesize delegate = _delegate;
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

- (void)setDataController:(BillDataController *)dataController
{
    if(_dataController != dataController)
    {
        _dataController = dataController;
    }
    [self configureView];
}

- (void)configureView
{
    BillDataController *data = self.dataController;
    self.cost = [data.totalBeforeTaxOrTip asString];
    self.totalCostLabel.text = @"Test";
    if(self.totalCostLabel) {
        self.totalCostLabel.text = self.cost;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goBack:(id)sender {
    [[self delegate] finishViewControllerDidGoBack:self];
}
@end
