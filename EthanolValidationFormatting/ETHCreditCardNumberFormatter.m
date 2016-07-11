//
//  ETHCreditCardNumberFormatter.m
//  Ethanol
//
//  Created by Stéphane Copin on 2/13/14.
//  Copyright (c) 2014 Fueled Digital Media, LLC.
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
    
    *cursor += characterOffset;
    
    switch ([object eth_creditCardType]) {
        // masking and length is different for the amex type.
      case ETHCreditCardTypeAmex:
        for (NSUInteger i = 0; i < length; ++i) {
          if (i == 4 || i == 10) {
            [result appendString:@" "];
          }
          
          [result appendString:[NSString stringWithCharacters:buffer + i length:1]];
        }
        *cursor += (*cursor > 4) ? 1 : 0;
        *cursor += (*cursor > 10) ? 1 : 0;
        break;
      case ETHCreditCardTypeNotACreditCard:
        if (!self.asYouTypeFormatter) {
          result = object;
          break;
        }
      default:
        for (NSUInteger i = 0; i < length; ++i) {
          if (i > 0 && (i % 4) == 0 && i < ETHCreditCardNumberDefaultLength) {
            [result appendString:@" "];
          }
          
          [result appendString:[NSString stringWithCharacters:buffer + i length:1]];
        }
        
        *cursor += (MIN(*cursor, ETHCreditCardNumberDefaultLength) - 1) / 4;
        break;
    };
    
    return result;
  }
  
  return nil;
}

- (id)unformatString:(NSString *)formattedString preserveCursor:(NSInteger *)cursor {
  if([[ETHSelectorValidator validatorWithSelector:@selector(eth_isValidCreditCardNumber) error:nil] validateObject:formattedString error:nil] || self.asYouTypeFormatter) {
    return [formattedString eth_stringByRemovingCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]
                                            preserveCursor:cursor];
  }
  return formattedString;
}

@end
