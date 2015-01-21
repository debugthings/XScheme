//
//  XSSchemeManager.h
//  XScheme
//
//  Created by Vladimir Shemet on 10.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSSchemeManager : NSObject

+ (instancetype)sharedManager;

/* addNewSchemeObject: return boolean value. If return YES - object was added to scheme. If return NO - object was not added to scheme (Already have same object etc.) */

- (BOOL)addNewSchemeObject:(XSObjectView *)newObjectView;

/* removeSchemeObject: return boolean value. If return YES - object was removed from scheme. If return NO - object was not removed from scheme (Not exist object) */

- (BOOL)removeSchemeObject:(XSObjectView *)objectView;

/* countOfObjectsWithType: return number of objects with same type. For example, 2 objects with type kXSObjectTypeConjunction */

- (NSInteger)countOfObjectsWithType:(XSObjectType)type;

/* objectWithType:atIndex: return XSObjectView with specified type at specified index. If object with specified type and index does not exist then return nil */

- (XSObjectView *)objectWithType:(XSObjectType)type atIndex:(NSInteger)index;

@end