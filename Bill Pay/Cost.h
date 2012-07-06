//
//  Cost.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cost : NSObject
-(id)initFromDollars:(NSInteger)dollars cents:(NSInteger)cents;
-(id)initFromCostInCents:(NSInteger)cents;
-(NSString *)asString;
@property (readonly) NSInteger inCents;
@property (readonly) NSInteger dollars;
@property (readonly) NSInteger cents;
@end
