//
//  NSString+EthanolValidation.m
//  Ethanol
//
//  Created by Stephane Copin on 3/21/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "NSString+EthanolValidation.h"
#import "ETHUSAStateValidator.h"

static NSString * const kAlphabeticRegEx = @"[a-zA-Z\\s]+";
static NSString * const kAlphaNumericRegEx = @"[a-zA-Z0-9\\s]+";
static NSString * const kEmailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

@implementation NSString (EthanolValidation)

- (BOOL)eth_matchRegex:(NSString *)regex {
  NSPredicate * regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  return [regexPredicate evaluateWithObject:self];
}

- (BOOL)eth_isNonempty {
  return self.length != 0;
}

- (BOOL)eth_isAlphabetic {
  return [self eth_matchRegex:kAlphabeticRegEx];
}

- (BOOL)eth_isNumeric {
  if (nil == self || [self length] == 0) {
    return NO;
  }
  NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
  return ([self rangeOfCharacterFromSet:notDigits].location == NSNotFound);
}

- (BOOL)eth_isAlphanumeric {
  return [self eth_matchRegex:kAlphaNumericRegEx];
}

- (BOOL)eth_isValidEmail {
  return [self eth_matchRegex:kEmailRegEx];
}

- (BOOL)eth_isValidURL {
  NSURL *URL = [NSURL URLWithString:self];
  if (URL.scheme && URL.host) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)eth_isValidPassword {
  return self.length >= 6;
}

- (BOOL)eth_isValidCreditCardExpirationDate {
  if(self.length < 4) {
    return NO;
  }
  
  NSRange slashIndex = [self rangeOfString:@"/"];
  if(slashIndex.location == NSNotFound) {
    return NO;
  }
  NSString * monthString = [NSString eth_extractDigitsFromString:[self substringToIndex:slashIndex.location]];
  if(monthString.length == 0) {
    return NO;
  }
  
  NSString * yearString = [NSString eth_extractDigitsFromString:[self substringFromIndex:slashIndex.location + 1]];
  if(yearString.length == 0) {
    return NO;
  }
  
  NSDateComponents * components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
  NSUInteger month = [monthString integerValue];
  NSUInteger year = [yearString integerValue];
  NSInteger currentYear = [components year];
  if(yearString.length <= 2) {
    year += 2000;
  }
  
  if(year == currentYear) {
    return month >= [components month];
  }
  
  return ((NSInteger)year) > currentYear;
}

- (BOOL)eth_isValidCreditCardNumber {
  NSString * digitString = [NSString eth_extractDigitsFromString:self];
  if(digitString.length < 12 || digitString.length > 20) {
    return NO;
  }
  
  NSInteger verification = [NSString eth_luhnAlgorithm:digitString];
  NSRange range = {.location = [digitString length] - 1, .length = 1};
  unichar verificationChar;
  [digitString getCharacters:&verificationChar range:range];
  
  return [NSString eth_unicharToDigit:verificationChar] == verification;
}

- (BOOL)eth_isValidCardVerificationCode {
  NSString * digitString = [NSString eth_extractDigitsFromString:self];
  NSInteger digitStringLength = [digitString length];
  if([self length] == digitStringLength && (digitStringLength == 3 || digitStringLength == 4)) {
    return YES;
  }
  
  return NO;
}

- (BOOL)eth_isValidUSAState {
  return [[ETHUSAStateValidator USAStatesList] containsObject:self];
}

#pragma mark - Helpers methods

+ (NSInteger)eth_unicharToDigit:(unichar)unicharValue {
  return unicharValue - '0';
}

// See on wikipedia for explanation: http://en.wikipedia.org/wiki/Luhn_algorithm
+ (NSInteger)eth_luhnAlgorithm:(NSString *)cardNumber {
  // Do not take the last digit into account, since it's the verification digit
  NSInteger length = [cardNumber length] - 1;
  unichar buffer[length];
  NSRange range = {.location = 0, .length =  length};
  [cardNumber getCharacters:buffer range:range];
  
  NSInteger sum = 0;
  BOOL doubleDigit = YES;
  for(NSInteger i = length - 1;i >= 0;--i) {
    NSInteger value = [self eth_unicharToDigit:buffer[i]];
    if(doubleDigit) {
      value *= 2;
      value  = value / 10 + value % 10;
    }
    
    sum += value;
    
    doubleDigit = !doubleDigit;
  }
  
  return (10 - (sum % 10)) % 10;
}

+ (NSString *)eth_extractDigitsFromString:(NSString *)string {
  NSMutableString *strippedString = [NSMutableString stringWithCapacity:string.length];
  NSScanner *scanner = [NSScanner scannerWithString:string];
  NSCharacterSet *numbers = [NSCharacterSet
                             characterSetWithCharactersInString:@"0123456789"];
  
  while ([scanner isAtEnd] == NO) {
    NSString *buffer;
    if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
      [strippedString appendString:buffer];
    } else {
      [scanner setScanLocation:([scanner scanLocation] + 1)];
    }
  }
  
  return strippedString;
}

@end
