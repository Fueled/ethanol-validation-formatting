//
//  ETHUSAStateValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHUSAStateValidator.h"

@implementation ETHUSAStateValidator

- (BOOL)validateObject:(id)object error:(NSError **)error {
  if(![super validateObject:object error:error]) {
    return NO;
  }
  
  if([[[self class] USAStatesList] containsObject:object]) {
    return YES;
  }
  
  if(error != nil) {
    *error = [NSError errorWithDomain:@"com.Ethanol.ValidationFormatting"
                                 code:ETHValidatorErrorCode
                             userInfo:nil];
  }
  
  return NO;
}

+ (NSArray *)USAStatesList {
  static NSArray * USAStatesList;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // From wikipedia, http://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations
    USAStatesList = @[@"AK", @"AL", @"AR", @"AS", @"AZ", @"CA", @"CO", @"CT", @"DC", @"DE", @"FL", @"FM", @"GA", @"GU", @"HI", @"IA", @"ID", @"IL", @"IN", @"KS", @"KY", @"LA", @"MA", @"MD", @"ME", @"MH", @"MI", @"MN", @"MO", @"MP", @"MS", @"MT", @"NC", @"ND", @"NE", @"NH", @"NJ", @"NM", @"NV", @"NY", @"OH", @"OK", @"OR", @"PA", @"PR", @"PW", @"RI", @"SC", @"SD", @"TN", @"TX", @"UM", @"UT", @"VA", @"VI", @"VT", @"WA", @"WI", @"WV", @"WY"];
  });
  
  return USAStatesList;
}

@end
