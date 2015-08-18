//
//  ETHFormatter.m
//  Ethanol
//
//  Created by Stéphane Copin on 2/14/14.
//  Copyright (c) 2014 Fueled. All rights reserved.
//

#import "ETHFormatter.h"

@implementation ETHFormatter

+ (instancetype)formatter {
  return [[self alloc] init];
}

- (instancetype)init {
  NSAssert([self class] != [ETHFormatter class], @"ETHFormatter should not be initialized directly. Please use one of its subclasses.");
  return [super init];
}

- (NSString *)formatObject:(id)object {
  NSInteger temp;
  return [self formatObject:object preserveCursor:&temp changeInCharacterOffset:0];
}

- (NSString *)formatObject:(id)object preserveCursor:(NSInteger *)cursor changeInCharacterOffset:(NSInteger)characterOffset {
  return nil;
}

- (id)unformatString:(NSString *)formattedString {
  NSInteger temp;
  return [self unformatString:formattedString preserveCursor:&temp];
}

- (id)unformatString:(NSString *)formattedString preserveCursor:(NSInteger *)cursor {
  return nil;
}

@end
