//
//  UIColor+TYHex.h
//  TYUIKit
//
//  Created by TuyaInc on 2018/12/17.
//

#import <UIKit/UIKit.h>

/**
 @param hex             like 0x00FF00, 0x#FF00FF00
 */
extern UIColor * TY_HexColor(uint32_t hex);

/**
 Available After TuyaSmart 3.9.0+
 @param hex           like 0x00FF00
 @param alpha         alpha ∈ [0, 1]
 */
extern UIColor * TY_HexAlphaColor(uint32_t hex, CGFloat alpha);


@interface UIColor (TYHex)

/**
 @param hex           like 0x00FF00, 0xFF00FF00
 */
+ (UIColor *)ty_colorWithHex:(uint32_t)hex;
/**
 @param hex           like 0x00FF00
 @param alpha         alpha ∈ [0, 1]
 */
+ (UIColor *)ty_colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

/**
 @param hexString     like "#00FF00", "#FF00FF00"
 @return return nil if hexString is illegal
 */
+ (UIColor *)ty_colorWithStringHex:(NSString *)hexString;
/**
 @param hexString     like "#00FF00"
 @param alpha         alpha ∈ [0, 1]
 @return if hexString is nil or @"" will return nil
 */
+ (UIColor *)ty_colorWithStringHex:(NSString *)hexString alpha:(CGFloat)alpha;

@end
