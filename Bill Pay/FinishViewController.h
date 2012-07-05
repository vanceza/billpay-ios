//
//  FinishViewControllerViewController.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillViewController.h"
#import "BillDataController.h"

@protocol FinishViewControllerDelegate;

@interface FinishViewController : UIViewController
@property (strong, nonatomic) NSString *cost;
@property (weak, nonatomic) IBOutlet UILabel *totalCostLabel;
@property (weak, nonatomic) id <FinishViewControllerDelegate> delegate;
@property (weak, nonatomic) BillDataController *dataController;
- (IBAction)goBack:(id)sender;
@end

@protocol FinishViewControllerDelegate
- (void)finishViewControllerDidGoBack:(FinishViewController *)controller;
@end
