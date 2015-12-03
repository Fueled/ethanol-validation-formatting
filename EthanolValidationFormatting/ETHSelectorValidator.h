//
//  ETHStringValidator.h
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHValidator.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  A subclass of ETHValidator that allows to specify a selector and a target as a validation method.
 */
@interface ETHSelectorValidator : ETHValidator

/**
 *  Create a new ETHSelectorValidator with a specified selector and error message.
 *  The selector must return a BOOL or a value convertible to BOOL implicitely.
 *  The selector will be called on the object to be validated.
 *
 *  @param selector The selector to initialize the validator with.
 *  @param error    The error key to use when the validation fails.
 *
 *  @return A new instance of ETHObjectValidator
 */
+ (instancetype)validatorWithSelector:(SEL)selector error:(NSString * _Nullable)error;

/**
 *  Create a new ETHSelectorValidator with a specified selector, target and error message.
 *  The selector must return a BOOL or a value convertible to BOOL implicitely.
 *  The selector must have a single parameter of type id, which corresponds to the object to be validated.
 *
 *  @param selector The selector to initialize the validator with.
 *  @param target   The target to call the selector on.
 *  @param error    The error key to use when the validation fails.
 *
 *  @return A new instance of ETHObjectValidator
 */
+ (instancetype)validatorWithSelector:(SEL)selector target:(id)target error:(NSString * _Nullable)error;

/**
 *  Initialize the instance with a specified selector, target and error message.
 *  The selector must return a BOOL or a value convertible to BOOL implicitely.
 *  The selector will be called on the object to be validated.
 *
 *  @param selector The selector to initialize the validator with.
 *  @param error    The error key to use when the validation fails.
 *
 *  @return A new instance of ETHObjectValidator
 */
- (instancetype)initWithSelector:(SEL)selector error:(NSString * _Nullable)error;

/**
 *  Initialize the instance with a specified selector, target and error message.
 *  The selector must return a BOOL or a value convertible to BOOL implicitely.
 *  The selector must have a single parameter of type id, which corresponds to the object to be validated.
 *
 *  @param selector The selector to initialize the validator with.
 *  @param target   The target to call the selector on.
 *  @param error    The error key to use when the validation fails.
 *
 *  @return A new instance of ETHObjectValidator
 */
- (instancetype)initWithSelector:(SEL)selector target:(nullable id)target error:(NSString * _Nullable)error NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
