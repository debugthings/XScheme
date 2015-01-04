//
//  XSExitObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSExitObject.h"

@implementation XSExitObject

- (instancetype)initListObject {
    self = [super initListObjectWithType:kXSObjectTypeExit
                                   title:@"Выход"
                                   image:[NSImage imageNamed:@"exit-icon"]
                             borderColor:[NSColor exitObjectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initSchemeObject {
    self = [super initSchemeObjectWithType:kXSObjectTypeExit
                                     image:[NSImage imageNamed:@"exit-icon"]
                               borderColor:[NSColor exitObjectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

@end
