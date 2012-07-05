//
//  AddViewController.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/2/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddViewControllerDelegate;

@interface AddViewController : UIViewController <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;
- (IBAction)updateCost:(id)sender;
- (IBAction)doneClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;

@property (copy, nonatomic, readwrite) NSString *currentCost;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMoney;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDescription;
@property (weak, nonatomic) id <AddViewControllerDelegate> delegate;

@end

@protocol AddViewControllerDelegate <NSObject>
- (void)addViewControllerDidCancel:(AddViewController *)controller;
- (void)addViewControllerDidFinish:(AddViewController *)controller dollars:(NSInteger)dollars cents:(NSInteger)cents description:(NSString *)description;
@end
