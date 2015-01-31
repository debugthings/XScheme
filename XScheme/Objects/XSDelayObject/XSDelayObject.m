//
//  XSDelayObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSDelayObject.h"

@interface XSDelayObject()

@property (readonly) NSNumber *objectInputValue;

@end

@implementation XSDelayObject

- (instancetype)init {
    self = [super initObjectWithType:kXSObjectTypeDelay
                               title:@"Задержка"
                               image:[NSImage imageNamed:@"delay-icon"]
                         borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (void)setInputValue:(NSNumber *)value {
    _objectInputValue = value;
}

- (NSNumber *)inputValue {
    if ([self.inputConnections count] == 1) {
        [self setInputValue:[[self.inputConnections firstObject] outputValue]];
        return _objectInputValue;
    }
    
    return nil;
}

- (NSInteger)inputsNumber {
    return 1;
}

- (NSInteger)outputsNumber {
    return 1;
}

- (XSObjectType)allowedInputTypes {
    return kXSObjectTypeConjunction | kXSObjectTypeDisjunction | kXSObjectTypeDenial;
}

- (XSObjectType)allowedOutputTypes {
    return kXSObjectTypeConjunction | kXSObjectTypeDisjunction | kXSObjectTypeDelay | kXSObjectTypeDenial | kXSObjectTypeExit;
}

- (NSString *)key {
    return [NSString stringWithFormat:@"Z\"%ld", (long)self.index];
}

- (NSString *)specialKey {
    return [NSString stringWithFormat:@"Z%ld", (long)self.index];
}

@end