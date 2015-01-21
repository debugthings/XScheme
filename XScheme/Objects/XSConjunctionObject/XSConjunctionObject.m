//
//  XSConjunctionObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSConjunctionObject.h"

@implementation XSConjunctionObject

- (instancetype)init {
    self = [super initObjectWithType:kXSObjectTypeConjunction
                               title:@"Конъюнкция"
                               image:[NSImage imageNamed:@"conjunction-icon"]
                         borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (NSInteger)inputsNumber {
    return 2;
}

- (NSInteger)outputsNumber {
    return 1;
}

@end
