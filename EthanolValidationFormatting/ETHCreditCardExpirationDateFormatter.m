//
//  ETHCreditCardExpirationDateFormatter.m
//  Ethanol
//
//  Created by Bastien Falcou on 1/6/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETHCreditCardExpirationDateFormatter.h"

@import EthanolUtilities;

static NSString * const kSeparatorCharacter = @"/";
static NSInteger const kSeparatorCharacterRank = 2;

@implementation ETHCreditCardExpirationDateFormatter

- (NSString *)formatObject:(id)object preserveCursor:(NSInteger *)cursor changeInCharacterOffset:(NSInteger)characterOffset {
  if(object != nil) {
    NSAssert([object isKindOfClass:[NSString class]], @"object must be a string");
    object = [self unformatString:object preserveCursor:cursor];
    
    NSInteger length = [object length];
    unichar buffer[length];
    NSRange range = {.location = 0, .length =  length};
    [object getCharacters:buffer range:range];
    NSMutableString * result = [NSMutableString string];
    
    for(NSUInteger i = 0;i < length;++i) {
      if(i == kSeparatorCharacterRank) {
        [result appendString:kSeparatorCharacter];
      }
      
      [result appendString:[NSString stringWithCharacters:buffer + i length:1]];
    }
    
    *cursor += characterOffset;
    *cursor += (*cursor > kSeparatorCharacterRank) ? 1 : 0;
    
    return result;
  }
  
  return nil;
}

- (id)unformatString:(NSString *)formattedString preserveCursor:(NSInteger *)cursor {
  return [formattedString eth_stringByRemovingCharacters:({ NSMutableCharacterSet * set = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet]; [set formUnionWithCharacterSet: [NSCharacterSet characterSetWithCharactersInString:kSeparatorCharacter]]; set; })
                                          preserveCursor:cursor];
}

@end
