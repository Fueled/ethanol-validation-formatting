//
//  ETHPhoneNumberValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHPhoneNumberValidator.h"
#import "NSString+EthanolValidationPhone.h"

@interface ETHPhoneNumberValidator ()

@property (nonatomic, copy) NSString * countryCode;

@end

@implementation ETHPhoneNumberValidator

+ (instancetype)validator {
  return [[self alloc] init];
}

+ (instancetype)validatorWithCountryCode:(NSString *)countryCode {
  return [[self alloc] initWithCountryCode:countryCode];
}

- (instancetype)init {
  self = [self initWithCountryCode:nil];
  if(self != nil) {
    
  }
  return self;
}

- (instancetype)initWithCountryCode:(NSString *)countryCode {
  self = [super init];
  if (self) {
    _countryCode = countryCode;
  }
  return self;
}

- (BOOL)validateObject:(id)object error:(NSError **)error {
  if(![super validateObject:object error:error]) {
    return NO;
  }
  
  void (^ setError)() = ^ {
    if(error != nil) {
      NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"EthanolValidationFailed",
                                 NSLocalizedFailureReasonErrorKey:@"EthanolInvalidPhoneNumber"};
      *error = [NSError errorWithDomain:@"com.fueled.Ethanol" code:ETHValidatorErrorCode userInfo:userInfo];
    }
  };
  
  if(![object isKindOfClass:[NSString class]]) {
    setError();
    return NO;
  }
  
  NSString * phoneNumber = object;
  BOOL result;
  if(self.countryCode != nil) {
    result = [phoneNumber eth_isValidPhoneNumberForCountryCode:self.countryCode];
  } else {
    result = [phoneNumber eth_isValidPhoneNumber];
  }
  
  if(!result) {
    setError();
    return NO;
  }
  
  return YES;
}

@end
