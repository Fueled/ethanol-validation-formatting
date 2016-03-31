//
//  PhoneNumberFormatter.m
//  TabView
//
//  Created by Stéphane Copin on 7/27/12.
//  Copyright (c) 2012 Fueled. All rights reserved.
//

#import <UIKit/UIWebView.h>
#import <libPhoneNumber/NBAsYouTypeFormatter.h>
#import "ETHPhoneNumberFormatter.h"

@import EthanolUtilities;

@implementation ETHPhoneNumberFormatter

+ (instancetype)formatterWithCountryCode:(NSString *)countryCode {
  return [[[self class] alloc] initWithCountryCode:countryCode];
}

- (id)init {
  self = [self initWithCountryCode:[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]];
  if(self) {
    
  }
  return self;
}

- (id)initWithCountryCode:(NSString *)countryCode {
  if (self = [super init]) {
    self.countryCode = countryCode;
    // Initialize bundle to mainBundle (See custom setter at end of file)
    self.bundle = nil;
  }
  return self;
}

- (NSString *)formatObject:(id)object preserveCursor:(NSInteger *)cursor changeInCharacterOffset:(NSInteger)characterOffset {
  if(object != nil) {
    NSAssert([object isKindOfClass:[NSString class]], @"object must be a string");
    
    NSMutableString * mutableString = [[self unformatString:object preserveCursor:cursor] mutableCopy];
    NSInteger length = [mutableString length];
    unichar buffer[length];
    NSRange range = {.location = 0, .length = length};
    [mutableString getCharacters:buffer range:range];
    
    *cursor += characterOffset - 1;
    
    NBAsYouTypeFormatter * asYouTypeFormatter = [[NBAsYouTypeFormatter alloc] initWithRegionCode:self.countryCode bundle:self.bundle];
    NSString * result = @"";
    BOOL rememberedPosition = NO;
    for(NSUInteger i = 0;i < length;++i) {
      if(*cursor == i) {
        result = [asYouTypeFormatter inputDigitAndRememberPosition:[NSString stringWithCharacters:buffer + i length:1]];
        rememberedPosition = YES;
      } else {
        result = [asYouTypeFormatter inputDigit:[NSString stringWithCharacters:buffer + i length:1]];
      }
    }
    
    if(rememberedPosition) {
      *cursor = [asYouTypeFormatter getRememberedPosition];
    }
    
    return [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  }
  
  return nil;
}

- (id)unformatString:(NSString *)formattedString preserveCursor:(NSInteger *)cursor {
  return [formattedString eth_stringByRemovingCharacters:[NSCharacterSet characterSetWithCharactersInString:@"-() "]
                                              preserveCursor:cursor];
}

- (void)setBundle:(NSBundle *)bundle {
  if(bundle == nil) {
    bundle = [NSBundle mainBundle];
  }
  
  _bundle = bundle;
}

@end
