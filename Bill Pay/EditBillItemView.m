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
//@synthesize navigationItem = _navigationItem;
@synthesize data = _data, delegate=_delegate, deleteKey=_deleteKey;

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
    //[self setNavigationItem:nil];
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

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [[self delegate] editBillControllerDeleted:self deleteKey:self.deleteKey];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row]==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cost"];
        cell.detailTextLabel.text = self.data.cost.asString;
        return cell;
    } else if([indexPath row]==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"description"];
        cell.detailTextLabel.text = self.data.description;
        self.navigationItem.title = self.data.description;
        return cell;
    } else {
        assert(false);
    }
}

- (IBAction)cancelPressed:(id)sender {
    [[self delegate] editBillControllerCancelled:self];
}

- (IBAction)deleteClicked:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Bill Item" otherButtonTitles:nil];
    [sheet showInView:self.view];
}
@end
