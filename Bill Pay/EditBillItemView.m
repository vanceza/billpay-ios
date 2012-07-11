//
//  EditBillItemView.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/9/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "EditBillItemView.h"

@interface EditBillItemView ()

@end

@implementation EditBillItemView
@synthesize dataController = _dataController, delegate=_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row]==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cost"];
        return cell;
    } else if([indexPath row]==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"description"];
        return cell;
    } else {
        assert(false);
    }
}

- (IBAction)cancelPressed:(id)sender {
    [[self delegate] editBillControllerCancelled:self];
}
@end
