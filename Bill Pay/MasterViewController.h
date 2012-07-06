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

@interface MasterViewController : UITableViewController
@property (strong, nonatomic) NSString *cost;
@property (weak, nonatomic) IBOutlet UILabel *totalCostLabel;
@property (strong, nonatomic) BillDataController *dataController;
@end
