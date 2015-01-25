//
//  XSExitObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSExitObject.h"

@implementation XSExitObject

- (instancetype)init {
    self = [super initObjectWithType:kXSObjectTypeExit
                               title:@"Выход"
                               image:[NSImage imageNamed:@"exit-icon"]
                         borderColor:[NSColor exitObjectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (NSInteger)inputsNumber {
    return 1;
}

- (NSInteger)outputsNumber {
    return 0;
}

- (XSObjectType)allowedInputTypes {
    return kXSObjectTypeEnter | kXSObjectTypeConjunction | kXSObjectTypeDisjunction | kXSObjectTypeDelay | kXSObjectTypeDenial;
}

- (XSObjectType)allowedOutputTypes {
    return kXSObjectTypeNone;
}

@end
