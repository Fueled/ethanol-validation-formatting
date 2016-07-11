//
//  NSString+CreditCard.m
//  Ethanol
//
//  Created by Thibault Gauche on 1/7/15.
//  Copyright (c) 2015 Fueled Digital Media, LLC.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSString+CreditCard.h"

@import EthanolUtilities;

@implementation NSString (CreditCard)

- (ETHCreditCardType)eth_creditCardType {
  NSString * formattedString = [self eth_stringByRemovingCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  NSArray * characters = [self componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
  if(characters.count != 1 || formattedString.length < 9 || formattedString.length > 19) {
    return ETHCreditCardTypeNotACreditCard;
  }
  
  ETHCreditCardType cardType[] = {ETHCreditCardTypeAmex, ETHCreditCardTypeVisa, ETHCreditCardTypeMastercard, ETHCreditCardTypeDiscover};
  for(size_t i = 0;i < sizeof(cardType) / sizeof(*cardType);++i) {
    NSPredicate *predicate = [self predicateForType:cardType[i]];
    BOOL isCurrentType = [predicate evaluateWithObject:formattedString];
    if(isCurrentType) {
      return cardType[i];
    }
  }
  
  return ETHCreditCardTypeUnknown;
}

- (NSPredicate *)predicateForType:(ETHCreditCardType)type {
  NSAssert(type == ETHCreditCardTypeAmex || type == ETHCreditCardTypeDiscover || type == ETHCreditCardTypeMastercard || type == ETHCreditCardTypeVisa, @"Unexpected type given");
  
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wswitch"
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
  }
#pragma clang diagnostic pop
  
  return [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
}

@end
