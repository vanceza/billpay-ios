//
//  Bill.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "Bill.h"
#import "AddViewController.h"

@interface Bill () <AddViewControllerDelegate>

@end

@implementation Bill

- (NSNumber *) totalBeforeTax
{
    return [NSNumber numberWithInt:1];
}

- (NSInteger) countOfList
{
    //TODO
    return 3;
}

- (BillItem *)objectInListAtIndex:(NSInteger)theIndex
{
    //TODO
    return [[BillItem alloc] initWithCost:[NSNumber numberWithInt:1] description:@"Desc"];
}

- (void)addBillItemWithCost:(NSNumber *)inputBillCost description:(NSString *)description
{
    //TODO
}

- (Bill *)dataController
{
    return self;
}

- (void)addViewControllerDidCancel:(AddViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)addViewControllerDidFinish:(AddViewController *)controller dollars:(NSNumber *)dollars cents:(NSNumber *)cents description:(NSString *)description
{
    if(dollars && cents) {
        [[self dataController] addBillItemWithCost:dollars description:description]; //TODO
        [[self tableView] reloadData];
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"AddMenuItem"]) {
        AddViewController *addController = (AddViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        addController.delegate = self;
    }
}

@end