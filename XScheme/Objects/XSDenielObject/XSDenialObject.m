//
//  XSDenialObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSDenialObject.h"

@implementation XSDenialObject

- (instancetype)initListObject {
    self = [super initListObjectWithType:kXSObjectTypeDenial
                                   title:@"Отрицание"
                                   image:[NSImage imageNamed:@"denial-icon"]
                             borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initSchemeObject {
    self = [super initSchemeObjectWithType:kXSObjectTypeDenial
                                     image:[NSImage imageNamed:@"denial-icon"]
                               borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

@end
