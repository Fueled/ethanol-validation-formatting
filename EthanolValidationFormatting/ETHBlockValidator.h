//
//  ETHBlockValidator.h
//  Ethanol
//
//  Created by Stephane Copin on 3/10/14.
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
