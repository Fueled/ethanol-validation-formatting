//
//  ETHBlockValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/10/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHBlockValidator.h"

@interface ETHBlockValidator ()

@property (nonatomic, copy) ETHValidationBlockType validationBlock;

@end

@implementation ETHBlockValidator

+ (instancetype)validatorWithBlock:(ETHValidationBlockType)validationBlock {
  return [[self alloc] initWithBlock:validationBlock];
}

- (instancetype)initWithBlock:(ETHValidationBlockType)validationBlock {
  self = [self init];
  if(self != nil) {
    _validationBlock = validationBlock;
  }
  return self;
}

- (BOOL)validateObject:(id)object error:(NSError **)error {
  NSString * errorMessage;
  if(!self.validationBlock(object, &errorMessage)) {
    if(error != nil) {
      *error = [NSError errorWithDomain:@"com.Ethanol.ValidationFormatting"
                                   code:ETHValidatorErrorCode
                               userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
    }
    
    return NO;
  }
  
  return YES;
}

@end
