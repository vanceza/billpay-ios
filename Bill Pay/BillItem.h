//
//  BillItem.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillItem : NSObject

@property (nonatomic, copy) NSNumber *cost;
@property (nonatomic, copy) NSString *description;

- (id) initWithCost:(NSNumber *)theCost description:(NSString *) theDescription;

@end
