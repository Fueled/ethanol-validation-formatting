//
//  ETHValidator.h
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ETHValidatorErrorCode 1213

/**
 *  Interface for validator. This class is designed to be subclassed.
 */
@interface ETHValidator : NSObject

/**
 *  Create a ETHValidator or one of its subclass.
 *
 *  @return A new instance of ETHValidator or one of its subclass.
 */
+ (instancetype)validator;

- (BOOL)validateObject:(id)object error:(NSError * _Nullable * _Nullable)error __attribute__((swift_error(none)));

@end

NS_ASSUME_NONNULL_END
