//
//  XSDelayObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSDelayObject.h"

@implementation XSDelayObject

- (instancetype)initListObject {
    self = [super initListObjectWithType:kXSObjectTypeDelay
                                    title:@"Задержка"
                                    image:[NSImage imageNamed:@"delay-icon"]
                              borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initSchemeObject {
    self = [super initSchemeObjectWithType:kXSObjectTypeDelay
                               image:[NSImage imageNamed:@"delay-icon"]
                         borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (NSInteger)inputsNumber {
    return 1;
}

- (NSInteger)outputsNumber {
    return 1;
}

@end
