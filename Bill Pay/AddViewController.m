//
//  ViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/2/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
{
}
@property (readonly) NSNumber *currentCostDollars;
@property (readonly) NSNumber *currentCostCents;
@property (readonly) BOOL currentCostValid;
@end

@implementation AddViewController
{
}
@synthesize doneButton = _doneButton;
@synthesize textFieldDescription = _textFieldDescription;

@synthesize label;
@synthesize textFieldMoney;
@synthesize currentCost=_currentCost;
@synthesize currentCostValid = _valid;
@synthesize currentCostDollars = _dollars;
@synthesize currentCostCents = _cents;

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextFieldMoney:nil];
    [self setTextFieldDescription:nil];
    [self setLabel:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)setCurrentCost:(NSString *)text
{
    _valid = NO;
    NSError *error = NULL;
    NSRegularExpression *dollarsAndCentsRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\$?([0-9]+)\\.([0-9]{2})$" options:0 error:&error];
    NSRegularExpression *dollarsOnlyRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\$?([0-9]+)$" options:0 error:&error];
    NSRegularExpression *centsOnlyRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\$?\\.([0-9]{2})$" options:0 error:&error];
    
    NSTextCheckingResult *match = [dollarsAndCentsRegex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if(match) {
        self.valid = YES;
        _dollars = [NSNumber numberWithInteger: [[text substringWithRange: [match rangeAtIndex:1]] integerValue]];
        _cents = [NSNumber numberWithInteger: [[text substringWithRange: [match rangeAtIndex:2]] integerValue]];
        return;
    }
    match = [centsOnlyRegex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if(match) {
        self.valid = YES;
        _dollars = nil;
        _cents = [NSNumber numberWithInteger: [[text substringWithRange: [match rangeAtIndex:1]] integerValue]];
        return;
    } 
    match = [dollarsOnlyRegex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if(match) {
        self.valid = YES;
        _cents = nil;
        _dollars = [NSNumber numberWithInteger: [[text substringWithRange: [match rangeAtIndex:1]] integerValue]];
        return;
    } else {
        self.valid = NO;
        _dollars = nil;
        _cents = nil;
        return;
    }
}

- (NSString *)currentCost
{
    if(self.currentCostValid) {
        return [[NSString alloc] initWithFormat:@"$%d.%02d", [self.currentCostDollars integerValue] , [self.currentCostCents integerValue]];
    } else {
        return @"Invalid";
    }
}

- (void)setValid:(BOOL)validity
{
    _valid = validity;
    if(_valid)
    {
        self.textFieldMoney.backgroundColor = [UIColor whiteColor];
    } else {
        self.textFieldMoney.backgroundColor = [UIColor redColor];
    }
    self.doneButton.enabled = _valid;
}

- (IBAction)updateCost:(id)sender {
    self.currentCost = self.textFieldMoney.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textFieldMoney) {
        [theTextField resignFirstResponder];
    }
    if (theTextField == self.textFieldDescription) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)doneClicked:(id)sender {
    [[self delegate] addViewControllerDidFinish:self dollars:self.currentCostDollars cents:self.currentCostCents description:self.description];
}

- (IBAction)cancelClicked:(id)sender {
    [[self delegate] addViewControllerDidCancel:self];
}

@end