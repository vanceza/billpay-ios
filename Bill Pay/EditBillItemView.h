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

@interface EditBillItemView : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (strong, nonatomic) BillItem *data;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)deleteClicked:(id)sender;
@property (weak, nonatomic) id <EditBillItemDelegate> delegate;
@property (nonatomic) NSUInteger deleteKey;
//@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@end

@protocol EditBillItemDelegate
- (void)editBillControllerCancelled:(EditBillItemView *)controller;
- (void)editBillControllerDeleted:(EditBillItemView *)controller deleteKey:(NSUInteger)deleteKey;
@end
