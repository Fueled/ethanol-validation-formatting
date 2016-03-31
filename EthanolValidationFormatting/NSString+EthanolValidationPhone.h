//
//  NSString+EthanolValidationPhone.h
//  Ethanol
//
//  Created by Stephane Copin on 3/21/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EthanolValidationPhone)

/**
 *  Returns YES if the string is a valid phone number with the current locale country code.
 *  @discussion Uses libphonenumber internally to validate the phone number.
 *  @return A BOOL describing whether or not the string is a valid phone number.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidPhoneNumber;
/**
 *  Returns YES if the string is a valid phone number with the specified locale country code.
 *  @param countryCode The country code to use to validate the phone number.
 *  @discussion Uses libphonenumber internally to validate the phone number.
 *  @return A BOOL describing whether or not the string is a valid phone number.
 */
- (BOOL)eth_isValidPhoneNumberForCountryCode:(NSString *)countryCode;

@property (nonatomic, assign, readonly) BOOL isValidPhoneNumber __deprecated_msg("Please use the eth_ prefixed method instead");
- (BOOL)isValidPhoneNumberForCountryCode:(NSString *)countryCode __deprecated_msg("Please use the eth_ prefixed method instead");

@end
