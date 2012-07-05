//
//  BillItem.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillItem : NSObject

@property NSInteger costInCents;
- (NSInteger) dollars;
- (NSInteger) cents;
- (NSString *)costAsString;
@property (nonatomic, copy) NSString *description;

- (id) initWithCostInCents:(NSInteger)theCost description:(NSString *) theDescription;

@end
