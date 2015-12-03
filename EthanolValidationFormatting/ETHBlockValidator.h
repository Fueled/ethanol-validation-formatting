//
//  ETHBlockValidator.h
//  Ethanol
//
//  Created by Stephane Copin on 3/10/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHValidator.h"

NS_ASSUME_NONNULL_BEGIN

@class ETHBlockValidator;

typedef BOOL (^ ETHValidationBlockType)(ETHBlockValidator * validator, _Nullable id object, NSString * _Nullable * _Nonnull errorMessage);

/**
 *  A subclass of ETHValidator that allows to specify a block as a validation method.
 */
@interface ETHBlockValidator : ETHValidator

/**
 *  Creates a new instance of ETHBlockValidator with the given block
 *
 *  @param validationBlock The validation block to use
 *
 *  @return A new instance of ETHBlockValidator initialized with the given block.
 */
+ (instancetype)validatorWithBlock:(ETHValidationBlockType)validationBlock;

- (instancetype)initWithBlock:(ETHValidationBlockType)validationBlock NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
