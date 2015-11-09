//
//  ETHUSAStateValidator.h
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHNonemptyValidator.h"

@interface ETHUSAStateValidator : ETHNonemptyValidator

/**
 *  Returns the list of USA states (Abbr, sorted alphabetically
 *
 *  @return A NSArray of NSString containing the list of all USA states.
 */
+ (NSArray *)USAStatesList;

@end
