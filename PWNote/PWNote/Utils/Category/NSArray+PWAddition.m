//
//  NSArray+ChildAddition.m
//  ChildBaseIOS
//
//  Created by mingyan on 2018/5/17.
//  Copyright © 2019年 明妍. All rights reserved.
//

#import "NSArray+PWAddition.h"
#import "NSDictionary+PWAddition.h"

@implementation NSArray (PWAddition)

- (id)pw_firstObject {
    if ([self count] > 0) {
        return [self objectAtIndex:0];
    }
    else {
        return nil;
    }
}

- (id)pw_randomObject {
    if ([self count] > 0) {
        return [self objectAtIndex:arc4random()%[self count]];
    }
    else {
        return nil;
    }
    
}

- (NSArray *)pw_reverse {
    NSInteger count = self.count;
    NSMutableArray * array = [NSMutableArray arrayWithArray:self];
    for(int i=0 ;i<count/2; ++i) {
        [array exchangeObjectAtIndex:i withObjectAtIndex:count-1-i];
    }
    return [NSArray arrayWithArray:array];
}

- (BOOL)pw_hasIndex:(NSInteger)index {
    if(self.count > index)
        return YES;
    else
        return NO;
}

- (id)pw_objectAtSafeIndex:(NSUInteger)index {
    if (self.count > 0 && self.count > index) {
        return [self objectAtIndex:index];
    }
    else {
        return nil;
    }
}

- (void)pw_addObservers:(NSArray *)observers forKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context {
    id object;
    NSEnumerator *enumerator = self.objectEnumerator;
    while (object = [enumerator nextObject]) {
        for (id observe in observers) {
            for (NSString *keyPath in keyPaths) {
                [object addObserver:observe
                         forKeyPath:keyPath
                            options:options
                            context:context];
            }
        }
    }
}

- (void)pw_removeObservers:(NSArray *)observers forKeyPaths:(NSArray *)keyPaths {
    id object;
    NSEnumerator *enumerator = self.objectEnumerator;
    while (object = [enumerator nextObject]) {
        for (id observe in observers) {
            for (NSString *keyPath in keyPaths) {
                [object removeObserver:observe
                            forKeyPath:keyPath];
            }
        }
    }
}

@end

@implementation NSArray (JsonStringExtention)

- (NSString *)pw_JsonString {
    if (!self || ![self isKindOfClass:[NSArray class]] || [self count] == 0) {
        return @"";
    }
    
    NSMutableString *jsonString = [NSMutableString string];
    [self pw_serialzeWithJsonString:jsonString];
    
    if ([jsonString length]) {
        [jsonString deleteCharactersInRange:NSMakeRange([jsonString length] - 1, 1)];
    }
    return jsonString;
}

- (void)pw_serialzeWithJsonString:(NSMutableString *)string {
    [string appendString:@"["];
    for (id object in self) {
        if (object) {
            if ([object isKindOfClass:[NSDictionary class]]){
                [(NSDictionary *)object pw_serialzeWithJsonString:string];
            }
            else if([object isKindOfClass:[NSArray class]]) {
                [self pw_serialzeWithJsonString:string];
            }
            else {
                [string appendFormat:@"\"%@\",", object];
            }
        }
    }
    [string deleteCharactersInRange:NSMakeRange([string length] - 1, 1)];
    [string appendString:@"]"];
    [string appendString:@","];
}
@end

@implementation NSArray (PWSafeAccess)

- (id)pw_objectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end

@implementation NSMutableArray (YKSafeAccess)

-(void)pw_addObject:(id)anObject
{
    if (!anObject) return;
    [self addObject:anObject];
}

- (void)pw_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) return;
    if (index >=self.count) return;
    [self insertObject:anObject atIndex:index];
}

- (void)pw_removeObjectAtIndex:(NSUInteger)index
{
    if (index >=self.count) return;
    [self removeObjectAtIndex:index];
}

- (void)pw_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject) return;
    if (index >=self.count) return;
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end
