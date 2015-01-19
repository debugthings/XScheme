//
//  EditorView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSEditorView.h"
#import "XSConnectObjects.h"
#import "XSObjectDetailsView.h"

@interface XSEditorView()

@property (nonatomic, weak) XSObjectView *selectedObject;
@property (readonly) XSObjectDetailsView *objectDetailsView;

@end

@implementation XSEditorView

@synthesize objectDetailsView = _objectDetailsView;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame Color:[NSColor workplaceBackgrountColor]];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectObject:) name:XSSchemeObjectSelectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveObject:) name:XSSchemeObjectDraggingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showObjectDetails:) name:XSSchemeObjectRightClickNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectingDragBegin:) name:XSConnectingDragBeginNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectingDragging:) name:XSConnectingDraggingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectingDragEnd:) name:XSConnectingDragEndNotification object:nil];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSBezierPath *line = [[XSConnectObjects sharedObject] currentBezierPath];
    [[NSColor blueColor] set];
    [line stroke];
}

- (void)addNewSchemeObject:(XSObjectView *)newObjectView {
    if ([[XSSchemeManager sharedManager] addNewSchemeObject:newObjectView]) {
        newObjectView.index = [[XSSchemeManager sharedManager] countOfObjectsWithType:newObjectView.type];
        
        if (newObjectView.index > 1) {
            [newObjectView showIndex];
            
            if (newObjectView.index == 2)
                [self showIndexForFirstObjectWithType:newObjectView.type];
        }
        
        
        
        
        [self addSubview:newObjectView];
    }
}

- (void)showIndexForFirstObjectWithType:(XSObjectType)type {
    XSObjectView *firstObjectView = [[XSSchemeManager sharedManager] objectWithType:type atIndex:0];
    
    if (firstObjectView)
        [firstObjectView showIndex];
}

#pragma mark - Connecting drag notification

- (void)connectingDragBegin:(NSNotification *)notification {
    [[XSConnectObjects sharedObject] drawLineInView:self atBeginPoint:[[notification.userInfo valueForKey:@"locationInWindow"] pointValue]];
}

- (void)connectingDragging:(NSNotification *)notification {
    [[XSConnectObjects sharedObject] redrawLineInView:self atPoint:[[notification.userInfo valueForKey:@"locationInWindow"] pointValue]];
}

- (void)connectingDragEnd:(NSNotification *)notification {
    [[XSConnectObjects sharedObject] removeLineInView:self];
}

#pragma mark - Mouse responde

- (void)mouseDown:(NSEvent *)theEvent {
    if (self.selectedObject) {
        [self.selectedObject setHighlightState:NO];
        self.selectedObject = nil;
    }
    
    [self.objectDetailsView removeFromSuperview];
}

- (void)moveObject:(NSNotification *)notification {
    [self.objectDetailsView removeFromSuperview];
    
    XSObjectView *movableObject = notification.object;
    
    if (![self.selectedObject isEqual:movableObject]) {
        self.selectedObject = movableObject;
        [self.selectedObject setHighlightState:YES];
    }
    
    NSPoint originPoint = [[notification.userInfo valueForKey:@"locationInWindow"] pointValue];
    originPoint.x -= (kSchemeObjectHeight / 2 > 0) ? kSchemeObjectHeight / 2 : 0;
    originPoint.y -= (kSchemeObjectHeight / 2 > 0) ? kSchemeObjectHeight / 2 : 0;
    [movableObject setFrameOrigin:originPoint];
}

- (void)selectObject:(NSNotification *)notification {
    if (![self.selectedObject isEqual:notification.object]) {
        
        if (self.selectedObject)
            [self.selectedObject setHighlightState:NO];
        
        self.selectedObject = notification.object;
        [self.selectedObject setHighlightState:YES];
    }
}

- (void)showObjectDetails:(NSNotification *)notification {
    NSPoint objectDetailsViewOrigin = [[notification.userInfo valueForKey:@"locationInWindow"] pointValue];
    objectDetailsViewOrigin.x -= 5;
    objectDetailsViewOrigin.y -= self.objectDetailsView.frame.size.height - 5;
    
    if (objectDetailsViewOrigin.x + self.objectDetailsView.frame.size.width > self.frame.size.width)
        objectDetailsViewOrigin.x = self.frame.size.width - self.objectDetailsView.frame.size.width - 10;
    
    [self.objectDetailsView setFrameOrigin:objectDetailsViewOrigin];
    self.objectDetailsView.targetObject = notification.object;
    
    if (![self.subviews containsObject:self.objectDetailsView])
        [self addSubview:self.objectDetailsView];
}

#pragma mark - UI Elements

- (XSObjectDetailsView *)objectDetailsView {
    if (!_objectDetailsView) {
        _objectDetailsView = [[XSObjectDetailsView alloc] init];
    }
    
    return _objectDetailsView;
}


@end
