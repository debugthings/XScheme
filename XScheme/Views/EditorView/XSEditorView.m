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
#import "XSAccessoryConnectingView.h"

@interface XSEditorView()

@property (nonatomic, weak) XSObjectView *selectedObject;
@property (readonly) XSObjectDetailsView *objectDetailsView;
@property (readonly) XSAccessoryConnectingView *accessoryConnectingView;

@end

@implementation XSEditorView

@synthesize objectDetailsView = _objectDetailsView;
@synthesize accessoryConnectingView = _accessoryConnectingView;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame Color:[NSColor workplaceBackgrountColor]];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectObject:)        name:XSSchemeObjectSelectNotification       object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveObject:)          name:XSSchemeObjectDraggingNotification     object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showObjectDetails:)   name:XSSchemeObjectRightClickNotification   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectingDragBegin:) name:XSConnectingDragBeginNotification  object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectingDragging:)  name:XSConnectingDraggingNotification   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectingDragEnd:)   name:XSConnectingDragEndNotification    object:nil];
    }
    
    return self;
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

- (void)removeSelectedSchemeObject {
    [self.objectDetailsView removeFromSuperview];
    [[XSSchemeManager sharedManager] removeSchemeObject:self.selectedObject];
    [self.selectedObject removeFromSuperview];
}

- (void)showIndexForFirstObjectWithType:(XSObjectType)type {
    XSObjectView *firstObjectView = [[XSSchemeManager sharedManager] objectWithType:type atIndex:0];
    
    if (firstObjectView)
        [firstObjectView showIndex];
}

#pragma mark - Connecting drag notification

- (void)connectingDragBegin:(NSNotification *)notification {
    [self addSubview:self.accessoryConnectingView];
    [self layout];
    [[XSConnectObjects sharedObject] drawLineInView:self.accessoryConnectingView atBeginPoint:[[notification.userInfo valueForKey:@"locationInWindow"] pointValue]];
}

- (void)connectingDragging:(NSNotification *)notification {
    [[XSConnectObjects sharedObject] redrawLineInView:self.accessoryConnectingView atPoint:[[notification.userInfo valueForKey:@"locationInWindow"] pointValue]];
}

- (void)connectingDragEnd:(NSNotification *)notification {
    [[XSConnectObjects sharedObject] removeLineInView:self.accessoryConnectingView];
    [self.accessoryConnectingView removeFromSuperview];
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

#pragma mark - Key responde

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)keyUp:(NSEvent *)theEvent {
    if (theEvent.keyCode == 51)             //"DELETE" key
        [self removeSelectedSchemeObject];
}

#pragma mark - UI Elements

- (XSObjectDetailsView *)objectDetailsView {
    if (!_objectDetailsView) {
        _objectDetailsView = [[XSObjectDetailsView alloc] init];
    }
    
    return _objectDetailsView;
}

- (XSAccessoryConnectingView *)accessoryConnectingView {
    if (!_accessoryConnectingView) {
        _accessoryConnectingView = [[XSAccessoryConnectingView alloc] initWithFrame:self.frame];
    }
    
    return _accessoryConnectingView;
}


@end
