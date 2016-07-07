//
//  ETHFormatter.m
//  Ethanol
//
//  Created by Stéphane Copin on 2/14/14.
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
  NSInteger temp = 0;
  return [self formatObject:object preserveCursor:&temp changeInCharacterOffset:0];
}

- (NSString *)formatObject:(id)object preserveCursor:(NSInteger *)cursor changeInCharacterOffset:(NSInteger)characterOffset {
  return nil;
}

- (id)unformatString:(NSString *)formattedString {
  NSInteger temp = 0;
  return [self unformatString:formattedString preserveCursor:&temp];
}

- (id)unformatString:(NSString *)formattedString preserveCursor:(NSInteger *)cursor {
  return nil;
}

@end
