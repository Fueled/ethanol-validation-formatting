//
//  NSString+EthanolValidationPhone.m
//  Ethanol
//
//  Created by Stephane Copin on 3/21/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "NSString+EthanolValidationPhone.h"

@import libPhoneNumberiOS;

@implementation NSString (EthanolValidationPhone)

- (BOOL)eth_isValidPhoneNumber {
  NSString * countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
  return [self eth_isValidPhoneNumberForCountryCode:countryCode];
}

- (BOOL)eth_isValidPhoneNumberForCountryCode:(NSString *)countryCode {
  NSError * error;
  NBPhoneNumber * phoneNumber = [[NBPhoneNumberUtil performSelector:NSSelectorFromString(@"sharedInstance")] parse:self defaultRegion:[countryCode uppercaseString] error:&error];
  
  if(error == nil) {
    return [[NBPhoneNumberUtil performSelector:NSSelectorFromString(@"sharedInstance")] isValidNumber:phoneNumber];
  }
  
  return NO;
}

#pragma mark - Deprecated methods

- (BOOL)isValidPhoneNumber {
  return [self eth_isValidPhoneNumber];
}

- (BOOL)isValidPhoneNumberForCountryCode:(NSString *)countryCode {
  return [self eth_isValidPhoneNumberForCountryCode:countryCode];
}

@end
