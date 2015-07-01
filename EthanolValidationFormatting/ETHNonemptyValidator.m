//
//  ETHNonemptyValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/7/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHNonemptyValidator.h"
#import "NSString+EthanolValidation.h"

@implementation ETHNonemptyValidator

- (BOOL)validateObject:(id)object error:(NSError **)error {
  void (^ setError)(void) = ^ {
    if(error != nil) {
      *error = [NSError errorWithDomain:@"com.Ethanol.ValidationFormatting" code:ETHValidatorErrorCode userInfo:nil];
    }
  };
  
  if(object == nil) {
    setError();
    
    return NO;
  }
  
  if(![object isKindOfClass:[NSString class]]) {
    return YES;
  }
  
  NSString * string = object;
  if([string eth_isNonempty]) {
    return YES;
  }
  
  setError();
  
  return NO;
}

@end
