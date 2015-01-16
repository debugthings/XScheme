//
//  XSDisjunctionObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSDisjunctionObject.h"

@implementation XSDisjunctionObject

- (instancetype)initListObject {
    self = [super initListObjectWithType:kXSObjectTypeDisjunction
                                   title:@"Дизъюнкция"
                                   image:[NSImage imageNamed:@"disjunction-icon"]
                             borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initSchemeObject {
    self = [super initSchemeObjectWithType:kXSObjectTypeDisjunction
                                     image:[NSImage imageNamed:@"disjunction-icon"]
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
