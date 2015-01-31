//
//  XSEditorView+ConnectObjects.m
//  XScheme
//
//  Created by Vladimir Shemet on 24.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSEditorView+ConnectObjects.h"

@implementation XSEditorView (ConnectObjects)

- (void)drawLineBetweenObjectsWithActiveDataType:(XSDataType)dataType {
    NSView *firstView = (NSView *)self.selectedObject;
    NSView *secondView = (NSView *)self.hoverObject;
    
    NSBezierPath *bezierPath = [self configureBezierPathWithFirstView:firstView secondView:secondView activeDataType:dataType];
    
    NSDictionary *dictionary = @{@"firstObject"             : self.selectedObject,
                                 @"secondObject"            : self.hoverObject,
                                 @"bezierPath"              : bezierPath,
                                 @"dataTypeForFirstObject"  : @(dataType)};
    
    [self.linesArray addObject:dictionary];
    
    [self setNeedsDisplay:YES];
}

- (NSArray *)linesWithObject:(XSObjectView *)objextView {
    NSMutableArray *lines = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [self.linesArray count]; i++) {
        NSDictionary *line = [self.linesArray objectAtIndex:i];
        
        if ([line valueForKey:@"firstObject"] == objextView || [line valueForKey:@"secondObject"] == objextView)
            [lines addObject:line];
    }
    
    return lines;
}

- (NSDictionary *)correctLine:(NSDictionary *)lineDictionary {
    XSObjectView *firstObject = [lineDictionary valueForKey:@"firstObject"];
    XSObjectView *secondObject = [lineDictionary valueForKey:@"secondObject"];
    XSDataType dataType = [[lineDictionary valueForKey:@"dataTypeForFirstObject"] integerValue];
    NSBezierPath *bezierPath = [self configureBezierPathWithFirstView:firstObject secondView:secondObject activeDataType:dataType];
    
    return @{@"firstObject"             : firstObject,
             @"secondObject"            : secondObject,
             @"bezierPath"              : bezierPath,
             @"dataTypeForFirstObject"  : @(dataType)};
}

- (NSBezierPath *)configureBezierPathWithFirstView:(NSView *)firstView secondView:(NSView *)secondView activeDataType:(XSDataType)dataType {
//    XSDataType topViewDataType = XSDataTypeNone;
//    NSView *topView = [self topViewWithArray:@[firstView, secondView]];
//    NSView *bottomView = nil;
//    
//    if (topView == firstView) {
//        bottomView = secondView;
//        topViewDataType = dataType;
//    } else {
//        bottomView = firstView;
//        topViewDataType = (dataType == XSDataTypeInput) ? XSDataTypeOutput : XSDataTypeInput;
//    }
//    
//    
//    NSBezierPath *bezierPath = [NSBezierPath bezierPath];
//    CGPoint startPoint = CGPointMake(topView.frame.origin.x + topView.frame.size.width / 2,
//                                     topView.frame.origin.y + topView.frame.size.height / 2);
//    CGPoint endPoint = CGPointMake(bottomView.frame.origin.x + bottomView.frame.size.width / 2,
//                                   bottomView.frame.origin.y + bottomView.frame.size.height / 2);
//
//    [bezierPath moveToPoint:startPoint];
//    
//    if (topViewDataType == XSDataTypeInput) {
//        CGPoint nextPoint = CGPointMake(startPoint.x, startPoint.y + topView.frame.size.height / 2 + 20);
//        [bezierPath lineToPoint:nextPoint];
//        nextPoint = CGPointMake((endPoint.x + startPoint.x) / 2, nextPoint.y);
//        [bezierPath lineToPoint:nextPoint];
//    
//        nextPoint = CGPointMake(nextPoint.x, endPoint.y + (secondView.frame.size.height / 2 + 20));
//        [bezierPath lineToPoint:nextPoint];
//    
//        nextPoint = CGPointMake(endPoint.x, nextPoint.y);
//        [bezierPath lineToPoint:nextPoint];
//    } else {
//        CGPoint nextPoint = CGPointMake(startPoint.x, startPoint.y - (topView.frame.size.height / 2 + 20));
//        [bezierPath lineToPoint:nextPoint];
//        
//        nextPoint = CGPointMake(endPoint.x, nextPoint.y);
//        [bezierPath lineToPoint:nextPoint];
//    }
//    
//    [bezierPath lineToPoint:endPoint];
//    
//    return bezierPath;
    NSBezierPath *bezierPath = [NSBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(firstView.frame.origin.x + firstView.frame.size.width / 2,
                                     firstView.frame.origin.y + firstView.frame.size.height / 2);
    CGPoint endPoint = CGPointMake(secondView.frame.origin.x + secondView.frame.size.width / 2,
                                   secondView.frame.origin.y + secondView.frame.size.height / 2);
    
    if (startPoint.y <= endPoint.y)
        startPoint = CGPointMake(firstView.frame.origin.x + firstView.frame.size.width / 2,
                                 firstView.frame.origin.y + firstView.frame.size.height / 2);
    
    [bezierPath moveToPoint:startPoint];
    [bezierPath lineToPoint:CGPointMake(startPoint.x, endPoint.y + firstView.frame.size.height / 2 + 10)];
    [bezierPath lineToPoint:CGPointMake(endPoint.x, endPoint.y + firstView.frame.size.height / 2 + 10)];
    [bezierPath lineToPoint:endPoint];
    
    return bezierPath;
}

- (id)topViewWithArray:(NSArray *)array {
    NSView *firstView = [array firstObject];
    NSView *lastView = [array lastObject];
    
    if (firstView.frame.origin.y > lastView.frame.origin.y)
        return firstView;
    
    return lastView;
}

- (void)correctLinesWithObject:(XSObjectView *)objectView {
    NSArray *lines = [self linesWithObject:objectView];
    
    for (int i = 0; i < [lines count]; i++) {
        NSDictionary *currentLine = [lines objectAtIndex:i];
        [self.linesArray removeObject:currentLine];
        currentLine = [self correctLine:currentLine];
        [self.linesArray addObject:currentLine];
    }
    
    [self setNeedsDisplay:YES];
}

- (void)removeLinesWithObject:(XSObjectView *)objectView {
    NSArray *lines = [self linesWithObject:objectView];
    [self.linesArray removeObjectsInArray:lines];
    [self setNeedsDisplay:YES];
}

- (NSDictionary *)lineBetweenFirstObject:(XSObjectView *)firstObject andSecondObject:(XSObjectView *)secondObject {
    NSArray *lines = [self linesWithObject:firstObject];
    
    for (int i = 0; i < [lines count]; i++) {
        NSDictionary *line = [lines objectAtIndex:i];
        
        if ([line valueForKey:@"firstObject"] == secondObject || [line valueForKey:@"secondObject"] == secondObject)
            return line;
    }
    
    return nil;
}

#pragma mark - Removed connection

- (void)removedConnection:(NSNotification *)notification {
    XSObjectView *firstObject = [notification.userInfo valueForKey:@"firstObject"];
    XSObjectView *secondObject = [notification.userInfo valueForKey:@"secondObject"];
    
    NSDictionary *line = [self lineBetweenFirstObject:firstObject andSecondObject:secondObject];
    
    if (line) {
        [self.linesArray removeObject:line];
        [self setNeedsDisplay:YES];
    }
}

@end
