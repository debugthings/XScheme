//
//  XSSchemeManager.m
//  XScheme
//
//  Created by Vladimir Shemet on 10.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSSchemeManager.h"

@interface XSSchemeManager()

@property (readonly) NSMutableDictionary *schemeObjectsDictionary;
@property (readonly) NSMutableArray *schemeObjectsArray;

@end

@implementation XSSchemeManager

@synthesize schemeObjectsDictionary = _schemeObjectsDictionary;
@synthesize schemeObjectsArray = _schemeObjectsArray;

+ (instancetype)sharedManager {
    static XSSchemeManager *schemeManager = nil;
    static dispatch_once_t once_token;
    
    dispatch_once(&once_token, ^{
        schemeManager = [[XSSchemeManager alloc] init];
    });
    
    return schemeManager;
}

- (BOOL)addNewSchemeObject:(XSObjectView *)newObjectView {
    NSString *currentKey = [XSUtility keyForObjectType:newObjectView.type];
    NSMutableArray *array = [self.schemeObjectsDictionary valueForKey:currentKey];
    
    if (!array)
        array = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (newObjectView.type == kXSObjectTypeExit && [array count] > 0)
        return NO;
    
    [array addObject:newObjectView];
    
    [self.schemeObjectsDictionary setObject:array forKey:currentKey];
    [self.schemeObjectsArray addObject:newObjectView];
    
    return YES;
}

- (BOOL)removeSchemeObject:(XSObjectView *)objectView {
    NSString *currentKey = [XSUtility keyForObjectType:objectView.type];
    NSMutableArray *array = [self.schemeObjectsDictionary valueForKey:currentKey];
    
    if (!array)
        return NO;
    
    [array removeObject:objectView];
    [self.schemeObjectsDictionary setObject:array forKey:currentKey];
    [self.schemeObjectsArray removeObject:objectView];
    
    return YES;
}

- (NSInteger)countOfObjectsWithType:(XSObjectType)type {
    NSArray *objectsArray = [self.schemeObjectsDictionary valueForKey:[XSUtility keyForObjectType:type]];
    return [objectsArray count];
}

- (XSObjectView *)objectWithType:(XSObjectType)type atIndex:(NSInteger)index {
    NSArray *objectsArray = [self.schemeObjectsDictionary valueForKey:[XSUtility keyForObjectType:type]];
    
    if ([objectsArray count] > index)
        return [objectsArray objectAtIndex:index];
    
    return nil;
}

- (XSObjectView *)objectAtPoint:(NSPoint)point {
    for (int i = 0; i < [self.schemeObjectsArray count]; i++) {
        XSObjectView *currentObject = [self.schemeObjectsArray objectAtIndex:i];
        if (NSPointInRect(point, currentObject.frame))
            return currentObject;
    }
    
    return nil;
}

#pragma mark - Manager data

- (NSMutableDictionary *)schemeObjectsDictionary {
    if (!_schemeObjectsDictionary) {
        _schemeObjectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    return _schemeObjectsDictionary;
}

- (NSMutableArray *)schemeObjectsArray {
    if (!_schemeObjectsArray) {
        _schemeObjectsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _schemeObjectsArray;
}

@end
