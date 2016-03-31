//
//  ETHPhoneNumberValidator.h
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHNonemptyValidator.h"

@interface ETHPhoneNumberValidator : ETHNonemptyValidator

/**
 *  Create a ETHPhoneNumberValidator with a specific country code.
 *
 *  @param countryCode The country code (2 letters) to initialize the validator with. May be nil.
 *
 *  @return A new instance of ETHPhoneNumberValidator
 */
+ (instancetype)validatorWithCountryCode:(NSString *)countryCode;

/**
 *  Initialize the instance of ETHPhoneNumberValidator with a specific country code.
 *
 *  @param countryCode The country code (2 letters) to initialize the validator with. May be nil.
 *
 *  @return The initialized instance
 */
- (instancetype)initWithCountryCode:(NSString *)countryCode;

@end
