//
//  FormattersTests.m
//  EthanolValidationFormattingTests
//
//  Created by Stephane Copin on 7/1/15.
//  Copyright (c) 2015 Fueled Digital Media, LLC.
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

#import <XCTest/XCTest.h>

#import "ETHCreditCardExpirationDateFormatter.h"
#import "ETHCreditCardNumberFormatter.h"

#define GENERATE_FORMATTER_TESTS_METHOD(name, stringMacro, expected, originalCursor, expectedCursor, offsetMacro, formatterClass, methodName, methodCall, config) \
- (void)name ## methodName { \
  NSString * string = stringMacro; \
  NSInteger offset = offsetMacro; \
  (void)offset; \
  NSInteger cursor = originalCursor; \
  formatterClass * formatter = [[formatterClass alloc] init]; \
  config; \
  NSString * result = methodCall; \
  XCTAssertTrue([result isEqualToString:expected], stringMacro @" should " @#methodName @" as " expected @" (Got %@)", result); \
  XCTAssertTrue((cursor == expectedCursor), @"When " #methodName ", from " stringMacro @" to " expected @", cursor with change in characters of (long)%d should change from %d to %d (Got %ld)", offsetMacro, originalCursor, expectedCursor, (long)cursor); \
}

#define GENERATE_FORMATTER_TESTS(name, stringMacro, expected, originalCursor, offsetMacro, expectedCursor, expectedUnformatted, formatterClass, config) \
  GENERATE_FORMATTER_TESTS_METHOD(name, stringMacro, expected, originalCursor, expectedCursor, offsetMacro, formatterClass, Format, ({ [formatter formatObject:string preserveCursor:&cursor changeInCharacterOffset:offset]; }), config) \
  GENERATE_FORMATTER_TESTS_METHOD(name, expected, stringMacro, originalCursor, expectedUnformatted, 0, formatterClass, Unformat, ({ [formatter unformatString:string preserveCursor:&cursor]; }), config)

@interface TestFormatter : ETHFormatter

@end

@implementation TestFormatter

@end

@interface FormattersTests : XCTestCase

@end

@implementation FormattersTests

- (void)testCantAllocBaseFormatter {
  XCTAssertThrows([ETHFormatter formatter]);
}

- (void)testFormatterFormat1ObjectMethod {
  TestFormatter * formatter = [[TestFormatter alloc] init];
  
  XCTAssertEqualObjects([formatter formatObject:@"abc"], nil);
}

- (void)testFormatterUnformatObjectMethod {
  TestFormatter * formatter = [[TestFormatter alloc] init];
  
  XCTAssertEqualObjects([formatter unformatString:@"abc"], nil);
}

- (void)testCreditCardNumberFormatterNilIfGivenNil {
  ETHCreditCardNumberFormatter * formatter = [[ETHCreditCardNumberFormatter alloc] init];
  
  XCTAssertNil([formatter formatObject:nil]);
}

- (void)testCreditCardNumberFormatterNotACreditCard {
  ETHCreditCardNumberFormatter * formatter = [[ETHCreditCardNumberFormatter alloc] init];
  NSString * notACreditCardNumber = @"421245612a3124978";
  XCTAssertEqualObjects([formatter formatObject:notACreditCardNumber], notACreditCardNumber);
}

- (void)testCreditCardNumberFormatter4DigitsAmexCreditCard {
  ETHCreditCardNumberFormatter * formatter = [[ETHCreditCardNumberFormatter alloc] init];
  XCTAssertEqualObjects([formatter formatObject:@"3714"], @"3714");
}

- (void)testCreditCardNumberFormatter10DigitsAmexCreditCard {
  ETHCreditCardNumberFormatter * formatter = [[ETHCreditCardNumberFormatter alloc] init];
  XCTAssertEqualObjects([formatter formatObject:@"3714496353"], @"3714 496353");
}

GENERATE_FORMATTER_TESTS(testCreditCardNumberDefaultFormatter, @"4916401926533", @"4916 4019 2653 3",  5,  0, 6,  4, ETHCreditCardNumberFormatter, )
GENERATE_FORMATTER_TESTS(testCreditCardNumberAmexFormatter,  @"371449635398431",   @"3714 496353 98431", 13, -6, 8, 11, ETHCreditCardNumberFormatter, )

GENERATE_FORMATTER_TESTS(testCreditCardExpirationDateDefaultNumberFormatter, @"122016", @"12/2016", 4, -3, 1,  3, ETHCreditCardExpirationDateFormatter, )
GENERATE_FORMATTER_TESTS(testCreditCardExpirationDateDefaultNumberFormatterCursorBeforeSlash, @"122016", @"12/2016", 1, 2, 4,  1, ETHCreditCardExpirationDateFormatter, )

- (void)testCreditCardExpirationDateNumberFormatterNilIfGivenNil {
  ETHCreditCardExpirationDateFormatter * formatter = [[ETHCreditCardExpirationDateFormatter alloc] init];
  
  XCTAssertNil([formatter formatObject:nil]);
}

- (void)testNonDestructiveCreditCardNumberUnformat {
  NSString * testString = @"definitely not a credit card number";
  XCTAssertEqualObjects([[ETHCreditCardNumberFormatter formatter] unformatString:testString], testString);
}

- (void)testNonDestructiveCreditCardExpiratinDateUnformat {
  NSString * testString = @"definitely not a credit card expiration/date";
  XCTAssertEqualObjects([[ETHCreditCardExpirationDateFormatter formatter] unformatString:testString], testString);
}

@end
