//
//  SlidingTipPercent.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/6/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillDataController.h"

@interface SlidingTipPercent : UITableViewController
@property (strong, nonatomic) BillDataController *dataController;
@property (weak, nonatomic) IBOutlet UILabel *billAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentSlider;
- (IBAction)sliderValueChanged:(id)sender;

@end
