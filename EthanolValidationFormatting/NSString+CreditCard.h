//
//  NSString+CreditCard.h
//  Ethanol
//
//  Created by Thibault Gauche on 1/7/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
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
