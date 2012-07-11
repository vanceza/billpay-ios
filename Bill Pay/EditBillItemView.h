//
//  EditBillItemView.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/9/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillDataController.h"

@protocol EditBillItemDelegate;

@interface EditBillItemView : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) BillDataController *dataController;
- (IBAction)cancelPressed:(id)sender;
@property (weak, nonatomic) id <EditBillItemDelegate> delegate;
@end

@protocol EditBillItemDelegate
- (void)editBillControllerCancelled:(EditBillItemView *)controller;
- (void)editBillControllerDeleted:(EditBillItemView *)controller;
@end
