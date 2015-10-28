//
//  TextHelper.h
//  Stox
//
//  Created by Matan Cohen on 6/3/14.

//

#import <Foundation/Foundation.h>
#define kIconArrowWideBottom @"G"
#define kIconArrowWideTop @"K"
#define kIconArrowDown       @"M"
#define kIconArrowUp       @"E"
#define kIconCamera          @"?"
#define kIconCancel          @"W"
#define kIconOk              @"7"
#define kEditPic             @"~"
#define kIconTag             @"["
#define kIconArrowLeft      @"d"
#define kIconArrowSlimRight      @"I"
#define kIconWarning         @"Q"
#define kIconMarketClosed         @"{"
#define kIconDoller          @"1"
#define kIconPie             @"2"
#define kIconFile            @"3"
#define kIconGraph           @"4"
#define kIconNotifications      @"f"
#define kIconWatch              @"g"
#define kIconSearch              @"&"
#define kIconEye                 @";"
#define kIconLike                 @"'"
#define kIconDislike                 @"="
@interface TextHelper : NSObject

+ (NSAttributedString *)setAttrebutedStringWithIcon:(id)iconValue andIconSize:(int)iconSize andTextString:(NSString *)text andTextFont:(id)fontValue andColor:(id)color onSide:(NSString *)sideString;

+(NSString *)addCommasToString: (NSString *)string;

@end
