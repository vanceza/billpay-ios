//
//  SlidingPercentControllerViewController.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/6/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillDataController.h"

@interface SlidingTaxPercentController : UITableViewController
@property (strong, nonatomic) BillDataController *dataController;
@property (weak, nonatomic) IBOutlet UILabel *taxPercent;
@property (weak, nonatomic) IBOutlet UISlider *taxSlider;
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
- (IBAction)sliderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@end
