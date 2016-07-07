//
//  ETHUSAStateValidator.m
//  Ethanol
//
//  Created by Stephane Copin on 3/6/14.
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

#import "ETHUSAStateValidator.h"

@implementation ETHUSAStateValidator

- (BOOL)validateObject:(id)object error:(NSError **)error {
  if(![super validateObject:object error:error]) {
    return NO;
  }
  
  if([[[self class] USAStatesList] containsObject:object]) {
    return YES;
  }
  
  if(error != nil) {
    *error = [NSError errorWithDomain:@"com.Ethanol.ValidationFormatting"
                                 code:ETHValidatorErrorCode
                             userInfo:nil];
  }
  
  return NO;
}

+ (NSArray *)USAStatesList {
  static NSArray * USAStatesList;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // From wikipedia, http://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations
    USAStatesList = @[@"AK", @"AL", @"AR", @"AS", @"AZ", @"CA", @"CO", @"CT", @"DC", @"DE", @"FL", @"FM", @"GA", @"GU", @"HI", @"IA", @"ID", @"IL", @"IN", @"KS", @"KY", @"LA", @"MA", @"MD", @"ME", @"MH", @"MI", @"MN", @"MO", @"MP", @"MS", @"MT", @"NC", @"ND", @"NE", @"NH", @"NJ", @"NM", @"NV", @"NY", @"OH", @"OK", @"OR", @"PA", @"PR", @"PW", @"RI", @"SC", @"SD", @"TN", @"TX", @"UM", @"UT", @"VA", @"VI", @"VT", @"WA", @"WI", @"WV", @"WY"];
  });
  
  return USAStatesList;
}

@end
