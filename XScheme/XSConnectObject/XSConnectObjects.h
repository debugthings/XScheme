//
//  XSConnectObject.h
//  XScheme
//
//  Created by Vladimir Shemet on 17.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface XSConnectObjects : NSObject

+ (void)connectingLineBetweenObject:(id)firstObject andObject:(id)secondObject;
+ (NSArray *)bezierPathsArray;

@end
