//
//  NSString+CreditCard.h
//  Ethanol
//
//  Created by Thibault Gauche on 1/7/15.
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

#import <Foundation/Foundation.h>

/**
 *  Define the types of credit card that the property below can detect
 */
typedef NS_ENUM(NSInteger, ETHCreditCardType) {
  /**
   *  An unknown credit card type (Any sequence of number between 6 and 19 characters that doesn't fit the others)
   */
  ETHCreditCardTypeUnknown,
  /**
   *  American Express
   */
  ETHCreditCardTypeAmex,
  /**
   *  Visa
   */
  ETHCreditCardTypeVisa,
  /**
   *  Master Card
   */
  ETHCreditCardTypeMastercard,
  /**
   *  Discover
   */
  ETHCreditCardTypeDiscover,
  /**
   *  Anything that is not a sequence of number, or that is lesser than 6 characters/greater than 19 characters
   */
  ETHCreditCardTypeNotACreditCard
};

@interface NSString (CreditCard)

@property (nonatomic, assign, readonly) ETHCreditCardType eth_creditCardType;

@end
