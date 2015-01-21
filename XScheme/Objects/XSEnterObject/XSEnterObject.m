//
//  XSEnterObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSEnterObject.h"

@implementation XSEnterObject

- (instancetype)init {
    self = [super initObjectWithType:kXSObjectTypeEnter
                               title:@"Вход"
                               image:[NSImage imageNamed:@"enter-icon"]
                         borderColor:[NSColor enterObjectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (NSInteger)inputsNumber {
    return 0;
}

- (NSInteger)outputsNumber {
    return -1;
}

@end
