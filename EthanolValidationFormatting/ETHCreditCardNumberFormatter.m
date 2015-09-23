//
//  ETHCreditCardNumberFormatter.m
//  Ethanol
//
//  Created by Stéphane Copin on 2/13/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHCreditCardNumberFormatter.h"
#import "NSString+CreditCard.h"
#import "NSString+EthanolValidation.h"
#import "ETHSelectorValidator.h"

@import EthanolUtilities;

enum {
  ETHCreditCardNumberDefaultLength = 16,
  ETHCreditCardNumberAmexLength = 15,
};

@implementation ETHCreditCardNumberFormatter

- (NSString *)formatObject:(id)object preserveCursor:(NSInteger *)cursor changeInCharacterOffset:(NSInteger)characterOffset {
  if(object != nil) {
    NSAssert([object isKindOfClass:[NSString class]], @"object must be a string");
    object = [self unformatString:object
                   preserveCursor:cursor];
    
    NSInteger length = [object length];
    unichar buffer[length];
    NSRange range = {.location = 0, .length =  length};
    [object getCharacters:buffer range:range];
    NSMutableString *result = [NSMutableString string];
    
    switch ([object eth_creditCardType]) {
        // masking and length is different for the amex type.
      case ETHCreditCardTypeAmex:
        for (NSUInteger i = 0; i < length; ++i) {
          if (i == 4 || i == 10) {
            [result appendString:@" "];
          }
          
          [result appendString:[NSString stringWithCharacters:buffer + i length:1]];
        }
        *cursor += characterOffset;
        *cursor += (*cursor > 4) ? 1 : 0;
        *cursor += (*cursor > 10) ? 1 : 0;
        break;
      case ETHCreditCardTypeNotACreditCard:
        result = object;
        break;
      default:
        for (NSUInteger i = 0; i < length; ++i) {
          if (i > 0 && (i % 4) == 0 && i < ETHCreditCardNumberDefaultLength) {
            [result appendString:@" "];
          }
          
          [result appendString:[NSString stringWithCharacters:buffer + i length:1]];
        }
        
        *cursor += characterOffset;
        *cursor += (MIN(*cursor, ETHCreditCardNumberDefaultLength) - 1) / 4;
        break;
    };
    
    
    return result;
  }
  
  return nil;
}

- (id)unformatString:(NSString *)formattedString preserveCursor:(NSInteger *)cursor {
  if([[ETHSelectorValidator validatorWithSelector:@selector(eth_isValidCreditCardNumber) error:nil] validateObject:formattedString error:nil]) {
    return [formattedString eth_stringByRemovingCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]
                                            preserveCursor:cursor];
  }
  return formattedString;
}

@end
