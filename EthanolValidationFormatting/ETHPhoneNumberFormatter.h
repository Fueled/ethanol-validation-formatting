//
//  PhoneNumberFormatter.h
//  TabView
//
//  Created by Stéphane Copin on 7/27/12.
//  Copyright (c) 2012 Fueled. All rights reserved.
//

#import "ETHFormatter.h"

@interface ETHPhoneNumberFormatter : ETHFormatter

@property (nonatomic, copy) NSString * countryCode;
/**
 *  Defaults to [NSBundle mainBundle] when uninitialized or set to nil
 */
@property (nonatomic, strong) NSBundle * bundle;

/**
 *  Create a ETHPhoneNumberFormatter with a specific country code.
 *
 *  @param countryCode The country code (2 letters) to initialize the formatter with. May be nil.
 *
 *  @return A new instance of ETHPhoneNumberFormatter
 */
+ (instancetype)formatterWithCountryCode:(NSString *)countryCode;

/**
 *  Initialize the instance with a specific country code.
 *
 *  @param countryCode The country code (2 letters) to initialize the formatter with. May be nil.
 *
 *  @return The initialized instance
 */
- (instancetype)initWithCountryCode:(NSString *)countryCode;

@end
