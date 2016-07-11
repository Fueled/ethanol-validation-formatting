//
//  ETHFormatter.h
//  Ethanol
//
//  Created by Stéphane Copin on 2/14/14.
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

/**
 *  Provide an interface for formatting objects.
 *  When subclassing, override either
 *  - (NSString *)formatObject:(id)object preserveCursor:(NSInteger *)cursor changeInCharacterOffset:(NSInteger)characterOffset;
 *  Please note that you should NOT call super in any methods. This could lead to unexpected issues.
 */
@interface ETHFormatter : NSObject

/**
 *  Create a new instance of ETHFormatter or one of its subclass.
 *
 *  @return A new instance of ETHFormatter or one of its subclass.
 */
+ (instancetype)formatter;

/**
 *  Format the given object to a NSString * representation.
 *  The default implementation simply calls formatObject:preserveCursor:deleting: with a temporary cursor.
 *
 *  @param object The object to format to a NSString.
 *
 *  @return The formatted object as a NSString.
 */
- (NSString *)formatObject:(id)object;

/**
 *  Format the given object to a NSString * representation, while preserving cursor position if cursor is not NULL.
 *  This method, if a cursor is given, will move the cursor adequately compared
 *
 *  @param object          The object to format to a NSString.
 *  @param cursor          A pointer to a NSInteger containing the current cursor position. This parameter must not be NULL.
 *  @param characterOffset A NSInteger specifying the number of character added/deleted that resulted in the formatter being called.
 *                         This number should be >0 for added characters, and <0 for deleted characters.
 *
 *  @return The formatted object as a NSString.
 */
- (NSString *)formatObject:(id)object preserveCursor:(NSInteger *)cursor changeInCharacterOffset:(NSInteger)characterOffset;

/**
 *  Remove the format and gives you the original object from the formatted string.
 *  The default implementation simply calls unformatString:preserveCursor: with a temporary cursor.
 *
 *  @param formattedString The format string to get the original object from.
 *
 *  @return The original object resulting from the unformatted string.
 */
- (id)unformatString:(NSString *)formattedString;
/**
 *  Remove the format and gives you the original object from the formatted string.
 *
 *  @param formattedString The format string to get the original object from.
 *  @param cursor          A pointer to a NSInteger containing the cursor cursor position. This parameter must not be NULL.
 *
 *  @return The original object resulting from the unformatted string.
 */
- (id)unformatString:(NSString *)formattedString preserveCursor:(NSInteger *)cursor;

@end
