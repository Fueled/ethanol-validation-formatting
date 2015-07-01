//
//  ETHValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHValidator.h"

@implementation ETHValidator

+ (instancetype)validator {
  return [[self alloc] init];
}

- (BOOL)validateObject:(id)object error:(NSError **)error {
  return NO;
}

@end
