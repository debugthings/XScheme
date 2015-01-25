//
//  XSEditorView+ConnectObjects.m
//  XScheme
//
//  Created by Vladimir Shemet on 24.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSEditorView+ConnectObjects.h"

@implementation XSEditorView (ConnectObjects)

- (void)drawLineBetweenSelectedAndHoverObjects {
    NSView *firstView = (NSView *)self.selectedObject;
    NSView *secondView = (NSView *)self.hoverObject;
    
    NSBezierPath *bezierPath = [self configureBezierPathWithFirstView:firstView secondView:secondView];
    
    NSDictionary *dictionary = @{@"firstObject"     : self.selectedObject,
                                 @"secondObject"    : self.hoverObject,
                                 @"bezierPath"      : bezierPath};
    
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
    NSBezierPath *bezierPath = [self configureBezierPathWithFirstView:firstObject secondView:secondObject];
    
    return @{@"firstObject"     : firstObject,
             @"secondObject"    : secondObject,
             @"bezierPath"      : bezierPath};
}

- (NSBezierPath *)configureBezierPathWithFirstView:(NSView *)firstView secondView:(NSView *)secondView {
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

@end
