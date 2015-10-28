//
//  TextHelper.m
//  Stox
//
//  Created by Matan Cohen on 6/3/14.
//  Copyright (c) 2014 Stox. All rights reserved.
//

#import "TextHelper.h"
#define NLS(string) NSLocalizedString(string, @"")
#define kFontIconsWithSize(x) [UIFont fontWithName:@"Stokeet" size:(x)]
@import UIKit;


@implementation TextHelper
+(NSAttributedString *)setAttrebutedStringWithIcon: (id)iconValue
                                       andIconSize: (int)iconSize
                                     andTextString: (NSString *)text
                                       andTextFont: (id)fontValue
                                          andColor: (id)color
                                            onSide: (NSString *)sideString {
    
    NSString *side = [sideString lowercaseString];
    if ([side isEqualToString:@"left"]) {
        
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:
                                             [NSString stringWithFormat:@"%@ %@",
                                              iconValue,
                                              NLS(text)
                                              ]];
        [string addAttribute:NSFontAttributeName
                       value:kFontIconsWithSize(iconSize)
                       range:NSMakeRange(0, 1)];
        
        [string addAttribute:NSFontAttributeName
                       value:fontValue
                       range:NSMakeRange(1, string.length-1)];
        
        [string addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, string.length)];
        return string;

        
        
    }else if ([side isEqualToString:@"right"]) {

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:
                                             [NSString stringWithFormat:@"%@ %@",
                                              NLS(text),
                                              iconValue
                                              ]];
        
        [string addAttribute:NSFontAttributeName
                       value:kFontIconsWithSize(iconSize)
                       range:NSMakeRange(string.length - 1,1)];
        
        [string addAttribute:NSFontAttributeName
                       value:fontValue
                       range:NSMakeRange(0, string.length - 1)];
        
        [string addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, string.length)];
        
        return string;

    
    } else {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:
                                             [NSString stringWithFormat:@"%@",
                                              iconValue
                                              ]];
        [string addAttribute:NSFontAttributeName
                       value:kFontIconsWithSize(iconSize)
                       range:NSMakeRange(0, 1)];
        [string addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, string.length)];
        return string;

    }
    
    
}


+(NSString *)addCommasToString: (NSString *)string {
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
    NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:[string integerValue]]];

    return formatted;
}


@end
