//
//  CreditCardTests.m
//  EthanolValidationFormatting
//
//  Created by Stephane Copin on 8/18/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+CreditCard.h"

@interface CreditCardTests : XCTestCase

@end

@implementation CreditCardTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

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
