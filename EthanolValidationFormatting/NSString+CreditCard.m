//
//  NSString+CreditCard.m
//  Ethanol
//
//  Created by Thibault Gauche on 1/7/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "NSString+CreditCard.h"

@implementation NSString (CreditCard)

- (ETHCreditCardType)eth_creditCardType {
  NSString *formattedString = [self formatStringForProcessing:self];
  if (formattedString == nil || formattedString.length < 9) {
    return ETHCreditCardTypeUnknown;
  }
  
  NSArray *enums = @[@(ETHCreditCardTypeAmex),
                     @(ETHCreditCardTypeVisa),
                     @(ETHCreditCardTypeMastercard),
                     @(ETHCreditCardTypeDiscover)];
  
  __block ETHCreditCardType type = ETHCreditCardTypeUnknown;
  [enums enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    ETHCreditCardType _type = [obj integerValue];
    NSPredicate *predicate = [self predicateForType:_type];
    BOOL isCurrentType = [predicate evaluateWithObject:formattedString];
    if (isCurrentType) {
      type = _type;
      *stop = YES;
    }
  }];
  
  return type;
}

- (NSString *)formatStringForProcessing:(NSString *)string {
  NSCharacterSet *illegalCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
  NSArray *components = [string componentsSeparatedByCharactersInSet:illegalCharacters];
  return [components componentsJoinedByString:@""];
}

- (NSPredicate *)predicateForType:(ETHCreditCardType)type {
  if (type == ETHCreditCardTypeUnknown) {
    return nil;
  }
  NSString *regex = nil;
  switch (type) {
    case ETHCreditCardTypeAmex:
      regex = @"^3[47][0-9]{5,}$";
      break;
    case ETHCreditCardTypeDiscover:
      regex = @"^6(?:011|5[0-9]{2})[0-9]{3,}$";
      break;
    case ETHCreditCardTypeMastercard:
      regex = @"^5[1-5][0-9]{5,}$";
      break;
    case ETHCreditCardTypeVisa:
      regex = @"^4[0-9]{6,}$";
      break;
    default:
      break;
  }
  return [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
}

@end
