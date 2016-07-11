//
//  ETHCompoundValidator.h
//  GoGetter
//
//  Created by Bastien Falcou on 1/11/16.
//  Copyright © 2016 Falcou. All rights reserved.
//

#import "ETHValidator.h"

typedef NS_ENUM(NSInteger, ETHCompoundValidatorOperatorType) {
  ETHCompoundValidatorOperatorTypeAnd,
  ETHCompoundValidatorOperatorTypeOr
};

@interface ETHCompoundValidator : ETHValidator

+ (instancetype)validatorWithValidators:(NSArray *)validators;
+ (instancetype)validatorWithValidators:(NSArray *)validators compoundOperator:(ETHCompoundValidatorOperatorType)operator;

- (instancetype)initWithValidators:(NSArray *)validators;
- (instancetype)initWithValidators:(NSArray *)validators compoundOperator:(ETHCompoundValidatorOperatorType)operator;

@property (nonatomic, copy) NSArray *validators;
@property (nonatomic, assign) ETHCompoundValidatorOperatorType validatorsOperator;

@end
