//
//  NSDictionary+ChildAddition.h
//  ChildBaseIOS
//
//  Created by mingyan on 2018/3/15.
//  Copyright © 2019年 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PWAddition)
- (NSString *)pw_stringForKey:(NSString *)key;
- (NSInteger)pw_integerForKey:(NSString *)key;                 //返回对象integerValue，默认为0
+ (NSDictionary *)pw_dictionaryWithJsonString:(NSString *)jsonString;

- (NSArray *)pw_arrayForKey:(NSString *)key;                           //默认为nil
- (NSDictionary *)pw_dictionaryForKey:(NSString *)key;                 //默认为nil

// add by yitang
- (id)pw_valueForKey:(NSString *)key withClass:(Class)aClass;  //指定key和class的value，默认为nil
- (int)pw_intForKey:(NSString *)key;                           //返回对象intValue，默认为0
- (float)pw_floatForKey:(NSString *)key;                       //返回对象floatValue，默认为0.0
- (double)pw_doubleForKey:(NSString *)key;                     //返回对象doubleValue，默认为0.0
- (BOOL)pw_boolForKey:(NSString *)key;                         //返回对象boolValue，默认为NO
- (NSString *)pw_safeStringForKey:(NSString *)key;             //返回非nil字符串，默认为@""
- (NSString *)pw_intStringForKey:(NSString *)key;              //返回内容为整型值的字符串，默认为@"0"
- (NSURL *)pw_urlForKey:(NSString *)key;
- (NSDate *)pw_dateForKey:(NSString *)key;                     //返回日期，默认为nil(可处理NSDate对象、秒数、“yyyy-MM-dd HH:mm:ss”格式字符串)
- (NSDate *)pw_dateForMSKey:(NSString *)key;                   //返回日期，默认为nil(可处理NSDate对象、毫秒数、“yyyy-MM-dd HH:mm:ss”格式字符串)
- (NSArray *)pw_arrayForKey:(NSString *)key;                           //默认为nil
- (NSMutableArray *)pw_mutableArrayForKey:(NSString *)key;             //默认为nil
- (NSDictionary *)pw_dictionaryForKey:(NSString *)key;                 //默认为nil
- (NSMutableDictionary *)pw_mutableDictionaryForKey:(NSString *)key;   //默认为nil
- (NSString *)pw_jsonString;                                           //将字典转换为json格式的字符串
- (void)pw_serialzeWithJsonString:(NSMutableString *)jsonString;       //将字典进行json转换时使用


@end

@interface NSMutableDictionary (PWSafeAccess)
-(void)pw_setObject:(id)anObject forKey:(id)aKey;//安全地设值，做了object以及key是否为nil的判断
-(void)pw_setValue:(id)value forKey:(NSString*)key;//安全地设值，做了key是否为NSString的判断
@end

