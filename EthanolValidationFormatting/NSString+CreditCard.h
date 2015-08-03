//
//  NSString+CreditCard.h
//  Ethanol
//
//  Created by Thibault Gauche on 1/7/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ETHCreditCardType) {
  ETHCreditCardTypeAmex,
  ETHCreditCardTypeVisa,
  ETHCreditCardTypeMastercard,
  ETHCreditCardTypeDiscover,
  ETHCreditCardTypeUnknown
};

@interface NSString (CreditCard)

@property (nonatomic, assign, readonly) ETHCreditCardType eth_creditCardType;

@end