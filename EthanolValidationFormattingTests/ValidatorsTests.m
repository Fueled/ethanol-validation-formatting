//
//  ValidatorsTests.m
//  EthanolValidationFormatting
//
//  Created by Stephane Copin on 8/18/15.
//  Copyright © 2015 Stephane Copin. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ETHNonemptyValidator.h"
#import "ETHUSAStateValidator.h"
#import "ETHSelectorValidator.h"
#import "ETHBlockValidator.h"
#import "NSString+EthanolValidation.h"

@interface ValidatorsTests : XCTestCase

@end

@implementation ValidatorsTests

- (void)testBaseValidatorAlwaysFails {
  XCTAssertFalse([[ETHValidator validator] validateObject:nil error:nil], @"This test must return NO");
}

- (void)testNilNonemptyValidator {
  NSError * error;
  XCTAssertTrue(![[ETHNonemptyValidator validator] validateObject:nil error:&error] && error != nil, @"ETHNonemptyValidator validating nil should return NO and set an error");
}

- (void)testEmptyNonemptyValidator {
  NSString * object = @"";
  NSError * error;
  XCTAssertTrue(![[ETHNonemptyValidator validator] validateObject:object error:&error] && error != nil, @"ETHNonemptyValidator validating '%@' should return NO and set an error", object);
}

- (void)testNonemptyValidator {
  NSString * object = @"This is definitely not empty";
  NSError * error;
  XCTAssertTrue([[ETHNonemptyValidator validator] validateObject:object error:&error] && error == nil, @"ETHNonemptyValidator validating '%@' should return YES and not set an error", object);
}

- (void)testNoThrowNonObjectNonemptyValidator {
  NSObject * object = [[NSObject alloc] init];
  XCTAssertNoThrow([[ETHNonemptyValidator validator] validateObject:object error:nil], @"ETHNonemptyValidator validating an object of type different from NSString should not throw");
}

- (void)testNonStringNonemptyValidator {
  NSObject * object = [[NSObject alloc] init];
  NSError * error;
  XCTAssertTrue([[ETHNonemptyValidator validator] validateObject:object error:&error] && error == nil, @"ETHNonemptyValidator validating an object of type different from NSString should return YES and not set an error");
}

- (void)testUSAStateValidator {
  NSString * object = @"NY";
  NSError * error;
  XCTAssertTrue([[ETHUSAStateValidator validator] validateObject:object error:&error] && error == nil, @"ETHUSAStateValidator validating '%@' should return YES and not set an error", object);
}

- (void)testNonUSAStateValidator {
  NSString * object = nil;
  NSError * error;
  XCTAssertFalse([[ETHUSAStateValidator validator] validateObject:object error:&error] && error != nil, @"ETHUSAStateValidator validating nil should return NO and set an error");
}

- (void)testInvalidUSAStateValidator {
  NSString * object = @"DEFINITELY NOT A STATE";
  NSError * error;
  XCTAssertFalse([[ETHUSAStateValidator validator] validateObject:object error:&error] && error != nil, @"ETHUSAStateValidator validating '%@' should return NO and set an error", object);
}

- (void)testNonStringUSAStateValidator {
  NSObject * object = [[NSObject alloc] init];
  NSError * error;
  XCTAssertFalse([[ETHUSAStateValidator validator] validateObject:object error:&error] && error != nil, @"ETHUSAStateValidator validating '%@' should return NO and set an error", object);
}

- (void)testSelectorValidator {
  NSObject * object = @"test";
  NSError * error;
  XCTAssertTrue([[ETHSelectorValidator validatorWithSelector:@selector(isEqualToString:) target:@"test" error:@"Shouldn't be set"] validateObject:object error:&error], @"This test should return YES");
}

- (void)testErrorSelectorValidator {
  NSObject * object = @"test";
  NSError * error;
  NSString * errorMessage = @"";
  XCTAssertTrue(![[ETHSelectorValidator validatorWithSelector:@selector(isEqualToString:) target:@"test2" error:errorMessage] validateObject:object error:&error] && error != nil && [[error localizedDescription] isEqualToString:errorMessage], @"This test should return YES");
}

- (void)testNoThrowSelectorValidator {
  NSError * error;
  XCTAssertNoThrow([[ETHSelectorValidator validatorWithSelector:@selector(eth_isValidEmail) error:@"Shoulnd't be set"] validateObject:@"asd" error:&error], @"This test must not throw because the selector eth_isValidEmail is part of the Ethanol category on NSString");
}

- (void)testThrowSelectorValidator {
  NSError * error;
  XCTAssertThrows([[ETHSelectorValidator validatorWithSelector:NSSelectorFromString(@"abc") error:@"Can't be set"] validateObject:@"asd" error:&error], @"This test must throw because the selector abc doesn't exist");
}

- (void)testBlockValidatorError {
  NSString * objectToValidate = @"validate me";
  NSError * error;
  NSString * errorMessageToCheck = @"error message";
  XCTAssertFalse([[ETHBlockValidator validatorWithBlock:^BOOL(id object, NSString **errorMessage) {
    if([object isEqualToString:objectToValidate]) {
      *errorMessage = errorMessageToCheck;
      return NO;
    }
    return YES;
  }] validateObject:objectToValidate error:&error] && [[error localizedDescription] isEqualToString:errorMessageToCheck], @"This test must return YES");
}

- (void)testBlockValidatorNoError {
  NSString * objectToValidate = @"validate me";
  NSError * error;
  NSString * errorMessageToCheck = @"error message";
  XCTAssertTrue([[ETHBlockValidator validatorWithBlock:^BOOL(id object, NSString **errorMessage) {
    if(![object isEqualToString:objectToValidate]) {
      *errorMessage = errorMessageToCheck;
      return NO;
    }
    return YES;
  }] validateObject:objectToValidate error:&error], @"This test must return YES");
}

@end
