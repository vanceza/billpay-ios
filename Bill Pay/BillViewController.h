//
//  Bill.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillDataController.h"
#import "MasterViewController.h"

@protocol MasterViewControllerDelegate;

@interface BillViewController : UITableViewController
@property (strong, nonatomic) BillDataController *dataController;
@property (weak, nonatomic) id <MasterViewControllerDelegate> delegate;
@end
