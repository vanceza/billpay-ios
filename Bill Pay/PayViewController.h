//
//  PayViewController.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/9/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillDataController.h"

@interface PayViewController : UITableViewController
@property (strong, nonatomic) BillDataController *dataController;
@property (weak, nonatomic) IBOutlet UILabel *billWithTaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *whoPaysCell;
- (IBAction)newBill:(id)sender;
@end
