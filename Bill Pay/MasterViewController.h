//
//  MasterViewController.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillViewController.h"
#import "BillDataController.h"

@interface MasterViewController : UIViewController <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UILabel *billCostLabel;
@property (weak, nonatomic) UILabel *taxCostLabel;
@property (weak, nonatomic) UILabel *tipCostLabel;
@property (weak, nonatomic) UILabel *totalCostLabel;
@property (strong, nonatomic) BillDataController *dataController;
- (IBAction)deletePressed:(id)sender;
@property (weak, nonatomic) UIBarButtonItem *deleteButton;
@property (weak, nonatomic) UIBarButtonItem *payButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
