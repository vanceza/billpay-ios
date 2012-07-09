//
//  PayViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/9/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController
@synthesize dataController = _dataController;
@synthesize billWithTaxLabel = _billWithTaxLabel;
@synthesize tipLabel = _tipLabel;
@synthesize totalLabel = _totalLabel;
@synthesize whoPaysCell = _whoPaysCell;

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
    [self setBillWithTaxLabel:nil];
    [self setTipLabel:nil];
    [self setTotalLabel:nil];
    [self setWhoPaysCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)setDataController:(BillDataController *)dataController
{
    _dataController = dataController;
    [self configureView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) configureView
{
    UITableViewCell *cell = self.whoPaysCell;
    // What someone unlucky paid for
    BillItem *item = self.dataController.randomBillItem;
    cell.textLabel.text = item.description;
    cell.detailTextLabel.text = item.cost.asString;

    self.billWithTaxLabel.text = self.dataController.totalAfterTaxBeforeTip.asString;
    self.tipLabel.text = self.dataController.tip.asString;
    self.totalLabel.text = self.dataController.totalAfterTaxAndTip.asString;
}


- (IBAction)newBill:(id)sender {
}
@end
