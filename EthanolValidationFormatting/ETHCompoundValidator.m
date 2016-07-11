//
//  ETHCompoundValidator.m
//  GoGetter
//
//  Created by Bastien Falcou on 1/11/16.
//  Copyright © 2016 Falcou. All rights reserved.
//

#import "ETHCompoundValidator.h"

@implementation ETHCompoundValidator

+ (instancetype)validatorWithValidators:(NSArray *)validators {
  return [[self alloc] initWithValidators:validators];
}

+ (instancetype)validatorWithValidators:(NSArray *)validators compoundOperator:(ETHCompoundValidatorOperatorType)operator {
  return [[self alloc] initWithValidators:validators compoundOperator:operator];
}

- (instancetype)initWithValidators:(NSArray *)validators {
  return [self initWithValidators:validators compoundOperator:ETHCompoundValidatorOperatorTypeAnd];
}

- (instancetype)initWithValidators:(NSArray *)validators compoundOperator:(ETHCompoundValidatorOperatorType)operator {
  if (self = [super init]) {
    _validatorsOperator = operator;
    _validators = [validators copy];
  }
  return self;
}

- (BOOL)validateObject:(id)object error:(NSError **)error {
  for (ETHValidator * validator in self.validators) {
    if ([validator validateObject:object error:error] && self.validatorsOperator == ETHCompoundValidatorOperatorTypeOr) {
      return YES;
    } else if(![validator validateObject:object error:error] && self.validatorsOperator == ETHCompoundValidatorOperatorTypeAnd) {
      return NO;
    }
  }
  
  if (self.validators.count > 0) {
    if (self.validatorsOperator == ETHCompoundValidatorOperatorTypeOr) {
      return NO;
    } else if (self.validatorsOperator == ETHCompoundValidatorOperatorTypeAnd) {
      return YES;
    }
  }
  
  return NO;
}

@end
