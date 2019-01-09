//
//  NSDictionary+ChildAddition.m
//  ChildBaseIOS
//
//  Created by mingyan on 2018/3/15.
//  Copyright © 2019年 明妍. All rights reserved.
//

#import "NSDictionary+PWAddition.h"
#import "NSArray+PWAddition.h"

@implementation NSDictionary (PWAddition)

//打印utf-8
- (NSString *)description
{
    // 1.定义一个可变的字符串, 保存拼接结果
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"{\n"];
    // 2.迭代字典中所有的key/value, 将这些值拼接到字符串中
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [strM appendString:@"}"];
    
    // 删除最后一个逗号
    if (self.allKeys.count > 0) {
        NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
        [strM deleteCharactersInRange:range];
    }
    
    // 3.返回拼接好的字符串
    return strM;
}

- (NSArray *)pw_arrayForKey:(NSString *)key
{
    return [self ykchild_valueForKey:key withClass:[NSArray class]];
}
- (id)ykchild_valueForKey:(NSString *)key withClass:(Class)aClass
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:aClass] ? value : nil;
}
- (NSDictionary *)pw_dictionaryForKey:(NSString *)key
{
    return [self ykchild_valueForKey:key withClass:[NSDictionary class]];
}
- (NSInteger)pw_integerForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return 0;
}

- (NSString *)pw_stringForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    } else {
        return nil;
    }
}


+ (NSDictionary *)pw_dictionaryWithJsonString:(NSString *)jsonString
{
    NSDictionary *dic;
    if ([jsonString isKindOfClass:[NSString class]]) {
        if (jsonString.length > 0) {
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            if ([jsonData isKindOfClass:[NSData class]]) {
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:&error];
                if (!error) {//转换成功
                    dic = dictionary;
                }
            }
        }
    }
    return dic;
}



- (id)pw_valueForKey:(NSString *)key withClass:(Class)aClass
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:aClass] ? value : nil;
}

- (int)pw_intForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    return 0;
}

- (float)pw_floatForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(floatValue)]) {
        return [value floatValue];
    }
    return 0.0;
}

- (double)pw_doubleForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    return 0.0;
}

- (BOOL)pw_boolForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return NO;
}

/*非nil字符串*/
- (NSString *)pw_safeStringForKey:(NSString *)key
{
    NSString *stringValue = [self pw_stringForKey:key];
    return stringValue ? stringValue : @"";
}

/*内容为整型值的字符串*/
- (NSString *)pw_intStringForKey:(NSString *)key
{
    return [NSString stringWithFormat:@"%d", [self pw_intForKey:key]];
}

- (NSURL *)pw_urlForKey:(NSString *)key
{
    return [NSURL URLWithString:[self pw_stringForKey:key]];
}

/*日期(可处理NSDate对象、秒数或毫秒数、“yyyy-MM-dd HH:mm:ss”格式字符串)*/
- (NSDate *)pw_dateForKey:(NSString *)key isMS:(BOOL)isMS
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDate class]]) {
        return value;
    }
    
    //判断日期格式
    if ([value isKindOfClass:[NSString class]]) {
        NSDate *date = [[NSDateFormatter new] dateFromString:value];
        if (date) {//非规范日期格式直接进行间隔转换
            return date;
        }
    }
    
    //转换时间间隔
    if ([value respondsToSelector:@selector(doubleValue)]) {
        double doubleValue = [value doubleValue];
        doubleValue = isMS ? doubleValue / 1000.0 : doubleValue;
        return [NSDate dateWithTimeIntervalSince1970:doubleValue];
    }
    return nil;
}

- (NSDate *)pw_dateForKey:(NSString *)key
{
    return [self pw_dateForKey:key isMS:NO];
}

- (NSDate *)pw_dateForMSKey:(NSString *)key
{
    return [self pw_dateForKey:key isMS:YES];
}

- (NSMutableArray *)pw_mutableArrayForKey:(NSString *)key
{
    NSArray *array = [self pw_arrayForKey:key];
    return array ? [NSMutableArray arrayWithArray:array] : nil;
}

- (NSMutableDictionary *)pw_mutableDictionaryForKey:(NSString *)key
{
    NSDictionary *dictionary = [self pw_dictionaryForKey:key];
    return dictionary ? [NSMutableDictionary dictionaryWithDictionary:dictionary] : nil;
}

- (NSString *)pw_jsonString
{
    if (!self || ![self isKindOfClass:[NSDictionary class]] || [self count] == 0) {
        return @"";
    }
    
    NSMutableString *jsonString = [NSMutableString string];
    [self pw_serialzeWithJsonString:jsonString];
    if ([jsonString length]) {
        [jsonString deleteCharactersInRange:NSMakeRange([jsonString length] - 1, 1)];
    }
    
    return jsonString;
}

- (void)pw_serialzeWithJsonString:(NSMutableString *)jsonString
{
    [jsonString appendString:@"{"];
    NSArray *allKeys = [self allKeys];
    for (NSString *key in allKeys) {
        id value = self[key];
        if (value) {
            if ([value isKindOfClass:[NSArray class]]) {
                [jsonString appendFormat:@"\"%@\":", key];
#ifndef EXTENSION
                
                [(NSArray *)value pw_serialzeWithJsonString:jsonString];
#endif
                
            }
            else if ([value isKindOfClass:[NSDictionary class]]) {
                [jsonString appendFormat:@"\"%@\":", key];
                [value pw_serialzeWithJsonString:jsonString];
            }
            else {
                [jsonString appendFormat:@"\"%@\":\"%@\",", key, [value description]];
            }
        }
    }
    [jsonString deleteCharactersInRange:NSMakeRange([jsonString length] - 1, 1)];
    [jsonString appendString:@"}"];
    [jsonString appendString:@","];
}


@end

@implementation NSMutableDictionary (PWSafeAccess)

-(void)pw_setObject:(id)anObject forKey:(id)aKey
{
    if(!aKey) return;
    if(!anObject) return;
    [self setObject:anObject forKey:aKey];
}

-(void)pw_setValue:(id)value forKey:(NSString*)key
{
    if(![key isKindOfClass:[NSString class]]) return;
    [self setValue:value forKey:key];
}

@end
