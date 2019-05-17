//
//  TYDeviceFunctionDefine.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//TODO: wmy to delete

#ifndef TYDeviceFunctionDefine_h
#define TYDeviceFunctionDefine_h

#define TYScreenAdaptor(length) (length * [UIScreen mainScreen].bounds.size.width / 375.0)

#define TP_SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

//#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define IOS7  (TP_SYSTEM_VERSION >= 7.0)
#define IOS8  (TP_SYSTEM_VERSION >= 8.0)
#define IOS9  (TP_SYSTEM_VERSION >= 9.0)
#define IOS10 (TP_SYSTEM_VERSION >= 10.0)

//是否是IPhoneX的设备
#define IPhoneX ([[UIScreen mainScreen] bounds].size.height >= 812)

// Color
#define HEXCOLORA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HEXCOLOR(rgbValue) HEXCOLORA(rgbValue, 1.0)

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r,g,b) RGBACOLOR(r,g,b,1)

// Screen
#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)
#define APP_STATUS_FRAME    [UIApplication sharedApplication].statusBarFrame

#define APP_TOP_BAR_HEIGHT    (IPhoneX ? 88 : (IOS7 ? 64 : 44))
#define APP_STATUS_BAR_HEIGHT (IPhoneX ? 44: (IOS7 ? 20 : 0))
#define APP_TOOL_BAR_HEIGHT   49
#define APP_TAB_BAR_HEIGHT    (IPhoneX ? (49 + 34): 49)
#define APP_CONTENT_WIDTH     (APP_SCREEN_BOUNDS.size.width)
#define APP_CONTENT_HEIGHT    (APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT - APP_TAB_BAR_HEIGHT)
#define APP_VISIBLE_HEIGHT    (APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT)




#ifndef TYLazyProperty
#define TYLazyProperty(cls,var) -(cls *)var{if (_##var == nil) {_##var = [cls new];}return _##var;}
#endif

#ifndef TYLazyPropertyWithInit
#define TYLazyPropertyWithInit(cls,var,code) -(cls *)var{if (_##var == nil) {_##var = [cls new];{code}}return _##var;}
#endif



#endif /* TYDeviceFunctionDefine_h */
