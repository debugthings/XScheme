//
//  XSConjunctionObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSConjunctionObject.h"

@implementation XSConjunctionObject

- (instancetype)initListObject {
    self = [super initListObjectWithType:kXSObjectTypeConjunction
                                   title:@"Конъюнкция"
                                   image:[NSImage imageNamed:@"conjunction-icon"]
                             borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initSchemeObject {
    self = [super initSchemeObjectWithType:kXSObjectTypeConjunction
                                     image:[NSImage imageNamed:@"conjunction-icon"]
                               borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

@end
