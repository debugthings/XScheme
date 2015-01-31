//
//  XSSchemeManager.m
//  XScheme
//
//  Created by Vladimir Shemet on 10.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSSchemeManager.h"

NSString * const XSRemovedConnectionNotification  = @"XSRemovedConnectionNotification";

@interface XSSchemeManager()

@property (readonly) NSMutableDictionary *schemeObjectsDictionary;
@property (readonly) NSMutableArray *schemeObjectsArray;
@property (nonatomic, strong) NSMutableArray *keysArray;

@end

@implementation XSSchemeManager

@synthesize schemeObjectsDictionary = _schemeObjectsDictionary;
@synthesize schemeObjectsArray = _schemeObjectsArray;

+ (instancetype)sharedManager {
    static XSSchemeManager *schemeManager = nil;
    static dispatch_once_t once_token;
    
    dispatch_once(&once_token, ^{
        schemeManager = [[XSSchemeManager alloc] init];
    });
    
    return schemeManager;
}

- (BOOL)addNewSchemeObject:(XSObjectView *)newObjectView {
    NSString *currentKey = [XSUtility keyForObjectType:newObjectView.type];
    NSMutableArray *array = [self.schemeObjectsDictionary valueForKey:currentKey];
    
    if (!array)
        array = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (newObjectView.type == kXSObjectTypeExit && [array count] > 0)
        return NO;
    
    [array addObject:newObjectView];
    
    [self.schemeObjectsDictionary setObject:array forKey:currentKey];
    [self.schemeObjectsArray addObject:newObjectView];
    
    return YES;
}

- (BOOL)removeSchemeObject:(XSObjectView *)objectView {
    NSString *currentKey = [XSUtility keyForObjectType:objectView.type];
    NSMutableArray *array = [self.schemeObjectsDictionary valueForKey:currentKey];
    
    if (!array)
        return NO;
    
    [array removeObject:objectView];
    [self.schemeObjectsDictionary setObject:array forKey:currentKey];
    [self.schemeObjectsArray removeObject:objectView];
    
    return YES;
}

- (NSInteger)countOfObjectsWithType:(XSObjectType)type {
    NSArray *objectsArray = [self.schemeObjectsDictionary valueForKey:[XSUtility keyForObjectType:type]];
    return [objectsArray count];
}

- (XSObjectView *)objectWithType:(XSObjectType)type atIndex:(NSInteger)index {
    NSArray *objectsArray = [self.schemeObjectsDictionary valueForKey:[XSUtility keyForObjectType:type]];
    
    if ([objectsArray count] > index)
        return [objectsArray objectAtIndex:index];
    
    return nil;
}

- (XSObjectView *)objectAtPoint:(NSPoint)point {
    for (int i = 0; i < [self.schemeObjectsArray count]; i++) {
        XSObjectView *currentObject = [self.schemeObjectsArray objectAtIndex:i];
        if (NSPointInRect(point, currentObject.frame))
            return currentObject;
    }
    
    return nil;
}

- (void)removeConnectionBetweenFirstObject:(XSObjectView *)firstObject andSecondObject:(XSObjectView *)secondObject {
    if([firstObject.inputConnections containsObject:secondObject])
        [firstObject removeInputConnectionObject:secondObject];
    
    if ([firstObject.outputConnections containsObject:secondObject])
        [firstObject removeOutputConnectionObject:secondObject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:XSRemovedConnectionNotification
                                                        object:nil
                                                      userInfo:@{@"firstObject"  : firstObject,
                                                                 @"secondObject" : secondObject}];
}

- (void)analisys {
    NSArray *variantsInputData = [self formattingInputData];
    NSArray *entersArray = [self.schemeObjectsDictionary objectForKey:[XSUtility keyForObjectType:kXSObjectTypeEnter]];
    NSArray *delayArray = [self.schemeObjectsDictionary objectForKey:[XSUtility keyForObjectType:kXSObjectTypeDelay]];
    
    NSMutableArray *dataForTable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int g = 0; g < [variantsInputData count]; g++) {
        NSArray *inputData = [variantsInputData objectAtIndex:g];
        
        NSInteger j = 0;
    
        for (int i = 0; i < [entersArray count]; i++) {
            XSEnterObject *enter = [entersArray objectAtIndex:i];
            [enter setOutputValue:[inputData objectAtIndex:j++]];
        }
    
        for (int i = 0; i < [delayArray count]; i++) {
            XSDelayObject *delay = [delayArray objectAtIndex:i];
            [delay setOutputValue:[inputData objectAtIndex:j++]];
        }
        
        [dataForTable addObject:[self formattingDataForTable]];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [appDelegate showTableViewWithData:dataForTable];
}

- (NSDictionary *)formattingDataForTable {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    self.keysArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *enters = [self.schemeObjectsDictionary objectForKey:[XSUtility keyForObjectType:kXSObjectTypeEnter]];
    NSArray *delays = [self.schemeObjectsDictionary objectForKey:[XSUtility keyForObjectType:kXSObjectTypeDelay]];
    
    for (int i = 0; i < [enters count]; i++) {
        XSEnterObject *enter = [enters objectAtIndex:i];
        [data setValue:enter.outputValue forKey:enter.key];
        [self.keysArray addObject:enter.key];
    }
    
    for (int i = 0; i < [delays count]; i++) {
        XSDelayObject *delay = [delays objectAtIndex:i];
        [data setValue:delay.outputValue forKey:delay.key];
        [self.keysArray addObject:delay.key];
    }
    
    XSExitObject *exitObject = [[self.schemeObjectsDictionary objectForKey:[XSUtility keyForObjectType:kXSObjectTypeExit]] firstObject];
    [data setValue:exitObject.outputValue forKey:exitObject.key];
    [self.keysArray addObject:exitObject.key];
    
    for (int i = 0; i < [delays count]; i++) {
        XSDelayObject *delay = [delays objectAtIndex:i];
        [data setValue:delay.inputValue forKey:[delay specialKey]];
        [self.keysArray addObject:[delay specialKey]];
    }
    
    return data;
}

- (NSArray *)formattingInputData {
    NSInteger columnNumber = [[self.schemeObjectsDictionary objectForKey:[XSUtility keyForObjectType:kXSObjectTypeEnter]] count] + [[self.schemeObjectsDictionary objectForKey:[XSUtility keyForObjectType:kXSObjectTypeDelay]] count];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *variantArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger i = 0; i < pow(2, columnNumber); i++) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:variantArray];
        
        NSInteger tempValue = 0;
        
        for (NSInteger j = columnNumber - 1; j >= 0; j--) {
            if ([tempArray count] < columnNumber) {
                [tempArray addObject:@(0)];
            } else {
                NSNumber *number = [tempArray objectAtIndex:j];
                
                if (j == columnNumber - 1) {
                    if ([number boolValue]) {
                        number = [NSNumber numberWithInteger:0];
                        [tempArray replaceObjectAtIndex:j withObject:number];
                        tempValue++;
                    } else {
                        number = [NSNumber numberWithInteger:1];
                        [tempArray replaceObjectAtIndex:j withObject:number];
                        
                        tempValue = 0;
                    }
                } else if (tempValue > 0) {
                    if ([number boolValue]) {
                        number = [NSNumber numberWithInteger:0];
                        [tempArray replaceObjectAtIndex:j withObject:number];
                        tempValue++;
                    } else {
                        number = [NSNumber numberWithInteger:1];
                        [tempArray replaceObjectAtIndex:j withObject:number];
                        
                        tempValue = 0;
                    }
                }
            }
        }
        
        variantArray = tempArray;
        [resultArray addObject:variantArray];
    }
    
    
    return resultArray;
}

- (void)logArray:(NSArray *)array {
    for (int i = 0; i < [array count]; i++) {
        XSObjectView *object = [array objectAtIndex:i];
        NSLog(@"%@: %@", [XSUtility keyForObjectType:object.type], [object outputValue]);
    }
}

- (NSArray *)keys {
    return self.keysArray;
}

#pragma mark - Manager data

- (NSMutableDictionary *)schemeObjectsDictionary {
    if (!_schemeObjectsDictionary) {
        _schemeObjectsDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    return _schemeObjectsDictionary;
}

- (NSMutableArray *)schemeObjectsArray {
    if (!_schemeObjectsArray) {
        _schemeObjectsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _schemeObjectsArray;
}

@end
