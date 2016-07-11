//
//  NSString+EthanolValidation.h
//  Ethanol
//
//  Created by Stephane Copin on 3/21/14.
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

#import <Foundation/Foundation.h>

@interface NSString (EthanolValidation)

/**
 Returns YES if the string match the specified regex, otherwise returns NO.
 @param regex The regex to match the string with
 @return A BOOL describing whether or not the string match the specified regex.
 */
- (BOOL)eth_matchRegex:(NSString *)regex;
/**
 Returns YES if the string is not empty, otherwise returns NO.
 @return A BOOL describing whether or not the string is not empty.
 */
@property (nonatomic, assign, readonly) BOOL eth_isNonempty;
/**
 Returns YES if the string is made up of alphabetic characters (a-z, A-Z), otherwise NO.
 @return A BOOL describing whether or not the string is alphabetic.
 */
@property (nonatomic, assign, readonly) BOOL eth_isAlphabetic;
/**
 Returns YES if the string is made up of number characters (0-9), otherwise NO.
 @return A BOOL describing whether or not the string is numeric.
 */
@property (nonatomic, assign, readonly) BOOL eth_isNumeric;
/**
 Returns YES if the string is made up of alphanumeric characters (a-z, A-Z, 0-9), otherwise NO.
 @return A BOOL describing whether or not the string is alphanumeric.
 */
@property (nonatomic, assign, readonly) BOOL eth_isAlphanumeric;
/**
 Returns YES if the string is a valid email address, otherwise NO.
 @return A BOOL describing whether or not the string is a valid email address.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidEmail;
/**
 Returns YES if the string is a valid URL, otherwise NO.
 @return A BOOL describing whether or not the string is a valid URL.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidURL;
/**
 Returns YES if the string is a valid password (6 or more characters), otherwise NO.
 @return A BOOL describing whether or not the string is a valid password.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidPassword;
/**
 *  Returns YES if the expiration date is valid. The given date string is tested against the current date, and returns NO if it's in the past.
 *  The method expect the format MM/yy or MM/yyyy.
 *  @return A BOOL describing whether or not the string is a valid expiration date.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidCreditCardExpirationDate;
/**
 *  Returns YES if the string is a valid credit card number.
 *  @discussion Uses luhn algorithm to validate the credit card number.
 *  @example The credit card number 4111 1111 1111 1111 can be used for test purpose.
 *  @return A BOOL describing whether or not the string is a valid credit card number.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidCreditCardNumber;
/**
 *  Returns YES if the string is a valid card verification code (Between 3 and 4 digits).
 *  @return A BOOL describing whether or not the string is a valid card verification code.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidCardVerificationCode;
/**
 *  Returns YES if the string is a valid USA state.
 *  @return A BOOL describing whether or not the string is a valid USA state.
 */
@property (nonatomic, assign, readonly) BOOL eth_isValidUSAState;

@end
