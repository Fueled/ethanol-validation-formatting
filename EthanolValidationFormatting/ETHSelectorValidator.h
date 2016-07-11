//
//  ETHStringValidator.h
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
