//
//  NSStringValidationTests.m
//  EthanolValidationFormatting
//
//  Created by Stephane Copin on 8/18/15.
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

#import "NSString+EthanolValidation.h"

@interface NSStringValidationTests : XCTestCase

@end

@implementation NSStringValidationTests

#define GENERATE_VALID_TEST(testName, string, propertyName) \
  - (void)testValid ## testName { \
    XCTAssertTrue(string.propertyName); \
  }

#define GENERATE_INVALID_TEST(testName, string, propertyName) \
  - (void)testInvalid ## testName { \
    XCTAssertFalse(string.propertyName); \
  }

#define GENERATE_TESTS(testName, validString, invalidString, propertyName) \
  GENERATE_VALID_TEST(testName, validString, propertyName) \
  GENERATE_INVALID_TEST(testName, invalidString, propertyName)

GENERATE_TESTS(Alphabetic, @"abc", @"abc123", eth_isAlphabetic)
GENERATE_TESTS(Numeric, @"123", @"123abc", eth_isNumeric)
GENERATE_INVALID_TEST(EmptyString, @"", eth_isNumeric)
GENERATE_TESTS(Email, @"stephane@fueled.com", @"abc", eth_isValidEmail)
GENERATE_TESTS(AlphaNumeric, @"abc123", @"abc123-^@$", eth_isAlphanumeric)
GENERATE_TESTS(URL, @"https://fueled.com", @"https//////////fueled.com", eth_isValidURL)
GENERATE_TESTS(Password, @"foobar", @"1234", eth_isValidPassword)
GENERATE_TESTS(CardExpirationDate, @"12/30", @"13/30", eth_isValidCreditCardExpirationDate)
GENERATE_VALID_TEST(CardExpirationDateThisYear,
                    ([NSString stringWithFormat:@"12/%d", (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]] year]]),
                    eth_isValidCreditCardExpirationDate)
GENERATE_VALID_TEST(CardExpirationDateMonthZeroPadding,
                    ([NSString stringWithFormat:@"000000012/%d", (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]] year]]),
                    eth_isValidCreditCardExpirationDate)
GENERATE_INVALID_TEST(CardExpirationDateTooShort, @"1/2", eth_isValidCreditCardExpirationDate)
GENERATE_INVALID_TEST(CardExpirationDateInvalidYear, @"12/20a2", eth_isValidCreditCardExpirationDate)
GENERATE_INVALID_TEST(CardExpirationDateInvalidMonth, @"1a/2012", eth_isValidCreditCardExpirationDate)
GENERATE_INVALID_TEST(CardExpirationDateEmptyMonth, @"/2012", eth_isValidCreditCardExpirationDate)
GENERATE_INVALID_TEST(CardExpirationDateEmptyYear, @"000000012/", eth_isValidCreditCardExpirationDate)
GENERATE_INVALID_TEST(CardExpirationDateNoSlash, @"122150", eth_isValidCreditCardExpirationDate)
GENERATE_TESTS(CreditCardNumber, @"4111 1111 1111 1111", @"1111 1111 1111 1111", eth_isValidCreditCardNumber)
GENERATE_INVALID_TEST(CreditCardNumberTooShort, @"41     1  11", eth_isValidCreditCardNumber)
GENERATE_INVALID_TEST(CreditCardNumberWithLetters, @"4111 11a11 11b11 11", eth_isValidCreditCardNumber)
GENERATE_TESTS(CardVerificationCode, @"4321", @"123d", eth_isValidCardVerificationCode)
GENERATE_INVALID_TEST(CardVerificationTooShort, @"12", eth_isValidCardVerificationCode)
GENERATE_TESTS(USAState, @"NY", @"ZY", eth_isValidUSAState)

@end
