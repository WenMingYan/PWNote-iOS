//
//  NSArray+ChildAddition.h
//  ChildBaseIOS
//
//  Created by mingyan on 2018/5/17.
//  Copyright © 2019年 明妍. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSArray (PWAddition)

- (id)pw_firstObject;
- (id)pw_randomObject;
- (NSArray *)pw_reverse;
- (BOOL)pw_hasIndex:(NSInteger)index;
- (id)pw_objectAtSafeIndex:(NSUInteger)index;

- (void)pw_addObservers:(NSArray *)observers forKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)pw_removeObservers:(NSArray *)observers forKeyPaths:(NSArray *)keyPaths;
@end

@interface NSArray (JsonStringExtention)

- (NSString *)pw_JsonString;   //将数组转化为json类型的字符串，只支持数组中元素是字典类型的数据
- (void)pw_serialzeWithJsonString:(NSMutableString *)jsonString;   // 将数组进行json转换时使用

@end

@interface NSArray (PWSafeAccess)

- (id)pw_objectAtIndex:(NSUInteger)index;//安全地取值，做了数组越界的判断
- (void)pw_addObject:(id)anObject;//安全地增加元素，做了是否为nil的判断
- (void)pw_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)pw_removeObjectAtIndex:(NSUInteger)index;
- (void)pw_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

