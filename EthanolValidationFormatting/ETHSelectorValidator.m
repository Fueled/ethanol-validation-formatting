//
//  ETHStringValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHSelectorValidator.h"

@interface ETHSelectorValidator ()

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy) NSString * error;

@end

@implementation ETHSelectorValidator

+ (instancetype)validatorWithSelector:(SEL)selector error:(NSString *)error {
  return [[self alloc] initWithSelector:selector error:error];
}

+ (instancetype)validatorWithSelector:(SEL)selector target:(id)target error:(NSString *)error {
  return [[self alloc] initWithSelector:selector target:target error:error];
}

- (instancetype)initWithSelector:(SEL)selector error:(NSString *)error {
  return [self initWithSelector:selector target:nil error:error];
}

- (instancetype)initWithSelector:(SEL)selector target:(id)target error:(NSString *)error {
  self = [self init];
  if(self) {
    _selector = selector;
    _target = target;
    _error = error;
  }
  return self;
}

- (BOOL)validateObject:(id)object error:(NSError **)error {
  if(error != nil) {
    *error = [NSError errorWithDomain:@"com.Ethanol.ValidationFormatting"
                                 code:ETHValidatorErrorCode
                             userInfo:nil];
  }
  
  id target = self.target ?: object;
  
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[target class] instanceMethodSignatureForSelector:self.selector]];
  [invocation setSelector:self.selector];
  [invocation setTarget:target];
  if(self.target != nil) {
    [invocation setArgument:&object atIndex:2];
  }
  [invocation invoke];
  
  BOOL returnValue;
  [invocation getReturnValue:&returnValue];
  
  return returnValue;
}

@end
