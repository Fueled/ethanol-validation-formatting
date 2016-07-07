//
//  CreditCardTests.m
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

#import "NSString+CreditCard.h"

@interface CreditCardTests : XCTestCase

@end

@implementation CreditCardTests

#define GENERATE_CREDIT_CARD_NUMBER_TEST(testName, cardNumber, type) \
  - (void)test ## testName ## CreditCardNumber { \
    XCTAssertEqual((cardNumber).eth_creditCardType, type); \
  }

GENERATE_CREDIT_CARD_NUMBER_TEST(Unknown, @"3530111333300000", ETHCreditCardTypeUnknown)
GENERATE_CREDIT_CARD_NUMBER_TEST(Visa, @"4111111111111111", ETHCreditCardTypeVisa)
GENERATE_CREDIT_CARD_NUMBER_TEST(Mastercard, @"5555555555554444", ETHCreditCardTypeMastercard)
GENERATE_CREDIT_CARD_NUMBER_TEST(Amex, @"371449635398431", ETHCreditCardTypeAmex)
GENERATE_CREDIT_CARD_NUMBER_TEST(Discover, @"6011111111111117", ETHCreditCardTypeDiscover)
GENERATE_CREDIT_CARD_NUMBER_TEST(NotA, @"abc", ETHCreditCardTypeNotACreditCard)

@end
