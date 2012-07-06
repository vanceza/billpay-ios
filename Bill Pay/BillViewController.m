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

@interface BillViewController () <AddViewControllerDelegate>
@end

@implementation BillViewController

@synthesize dataController = _dataController;

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

- (void)finishViewControllerDidGoBack:(MasterViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"AddMenuItem"]) {
        AddViewController *addController = (AddViewController *)[[[segue destinationViewController]viewControllers] objectAtIndex:0];
        addController.delegate = self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"menuitem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    BillItem *item = [self.dataController objectInListAtIndex:indexPath.row];
    [[cell textLabel] setText:item.description];
    [[cell detailTextLabel] setText:item.costAsString];
    return cell;
}

@end