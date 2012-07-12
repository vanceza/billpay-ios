//
//  Bill.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "BillViewController.h"
#import "AddViewController.h"
#import "MasterViewController.h"
#import "EditBillItemView.h"

@interface BillViewController () <AddViewControllerDelegate, EditBillItemDelegate>
@end

@implementation BillViewController

@synthesize dataController = _dataController;
@synthesize editButton = _editButton;

- (void)addViewControllerDidCancel:(AddViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addViewControllerDidFinish:(AddViewController *)controller dollars:(NSInteger)dollars cents:(NSInteger)cents description:(NSString *)description
{
    if(dollars || cents || description) {
        if(!description)
        {
            description = @"";
        }
        [[self dataController] addBillItemWithDollars:dollars cents:cents description:description];
        [[self tableView] reloadData];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancelClicked:(MasterViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)editBillControllerCancelled:(EditBillItemView *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)editBillControllerDeleted:(EditBillItemView *)controller deleteKey:(NSUInteger)deleteKey
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.dataController removeObjectAtIndex:deleteKey];
    [[self tableView] reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"AddMenuItem"]) {
        AddViewController *addController = (AddViewController *)[[[segue destinationViewController]viewControllers] objectAtIndex:0];
        addController.delegate = self;
    } else if([[segue identifier] isEqualToString:@"EditMenuItem"]) {
        EditBillItemView *editController = (EditBillItemView *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        editController.delegate = self;
        NSInteger row = [[self.tableView indexPathForSelectedRow] row];
        editController.data = [self.dataController objectInListAtIndex:row];
        editController.deleteKey = row;
    }
}

- (void)setDataController:(BillDataController *)dataController
{
    if(_dataController != dataController)
    {
        _dataController = dataController;
    }
    //[self configureView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.editing) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return [self.dataController countOfList];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath section]==0) {
        static NSString *CellIdentifier = @"menuitem";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        BillItem *item = [self.dataController objectInListAtIndex:indexPath.row];
        [[cell textLabel] setText:item.description];
        [[cell detailTextLabel] setText:item.costAsString];
        return cell;
    } else if([indexPath section]==1) {
        static NSString *CellIdentifier = @"addmenuitem";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        return cell;
    } else {
        assert(false);
    }

}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0) {
        return YES;
    } else if ([indexPath section]==1) {
        return NO;
    } else {
        assert(false);
        return NO;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    assert([sourceIndexPath section]==0);
    if([proposedDestinationIndexPath section] != 0) {
        NSIndexPath *counterProposal = [NSIndexPath indexPathForRow:[self.dataController countOfList]-1 inSection:0];
        return counterProposal;
    } else {
        return proposedDestinationIndexPath;        
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.dataController moveObjectFromIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0) {
        return UITableViewCellEditingStyleDelete;
        //return UITableViewCellEditingStyleNone;
    } else if([indexPath section]==1) {
        return UITableViewCellEditingStyleInsert;
    } else {
        assert(false);
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataController removeObjectAtIndex:[indexPath row]];
        [[self tableView] reloadData];
    } else if (editingStyle==UITableViewCellEditingStyleInsert) {
        [self performSegueWithIdentifier:@"AddMenuItem" sender:self];
    }
}

- (void)viewDidUnload {
    [self setEditButton:nil];
    [super viewDidUnload];
}

- (IBAction)editClicked:(id)sender {
    if(self.editing) {
        self.editing = NO;
        //self.editButton = 
    } else {
        [self setEditing:YES animated:YES];
    }
    [[self tableView] reloadData];
}
@end