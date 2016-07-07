//
//  ETHStringValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
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
  self = [super init];
  if(self) {
    _selector = selector;
    _target = target;
    _error = error;
  }
  return self;
}

- (instancetype)init {
  self = [self initWithSelector:NSSelectorFromString(@"") target:nil error:@""];
  if (self != nil) {
    self.selector = nil;
  }
  return self;
}

- (BOOL)validateObject:(id)object error:(NSError **)error {
  if (self.selector == nil) {
    return false;
  }
  
  id target = self.target ?: object;
  
  if (target == nil) {
    return false;
  }
  
  NSMethodSignature * methodSignature = [[target class] instanceMethodSignatureForSelector:self.selector];
  if (methodSignature == nil) {
    return false;
  }
  
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[target class] instanceMethodSignatureForSelector:self.selector]];
  [invocation setSelector:self.selector];
  [invocation setTarget:target];
  if(self.target != nil) {
    [invocation setArgument:&object atIndex:2];
  }
  [invocation invoke];
  
  BOOL returnValue;
  [invocation getReturnValue:&returnValue];
  
  if(!returnValue && error != nil) {
    *error = [NSError errorWithDomain:@"com.Ethanol.ValidationFormatting"
                                 code:ETHValidatorErrorCode
                             userInfo:self.error != nil ? @{NSLocalizedDescriptionKey: self.error} : nil];
  }
  
  return returnValue;
}

@end
