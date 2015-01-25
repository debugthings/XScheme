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
#import "XSEditorView+ConnectObjects.h"

@interface XSEditorView()

@property (readonly) XSObjectDetailsView *objectDetailsView;
@property (readonly) XSAccessoryConnectingView *accessoryConnectingView;
@property (nonatomic) XSDataType currentDataType;   // Input/Output data for connecting objects

@end

@implementation XSEditorView

@synthesize objectDetailsView = _objectDetailsView;
@synthesize accessoryConnectingView = _accessoryConnectingView;
@synthesize linesArray = _linesArray;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame Color:[NSColor workplaceBackgrountColor]];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(selectObject:)
                                                     name:XSSchemeObjectSelectNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moveObject:)
                                                     name:XSSchemeObjectDraggingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showObjectDetails:)
                                                     name:XSSchemeObjectRightClickNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(connectingDragBegin:)
                                                     name:XSConnectingDragBeginNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(connectingDragging:)
                                                     name:XSConnectingDraggingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(connectingDragEnd:)
                                                     name:XSConnectingDragEndNotification
                                                   object:nil];
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

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [NSBezierPath setDefaultLineWidth:1.0];
    [[NSColor lightGrayColorCustom] set];
    
    for (int i = 0; i < [self.linesArray count]; i++) {
        NSBezierPath *bezierPath = [[self.linesArray objectAtIndex:i] valueForKey:@"bezierPath"];
        [bezierPath stroke];
    }
}

- (void)removeSelectedSchemeObject {
    [self.objectDetailsView removeFromSuperview];
    [self removeLinesWithObject:self.selectedObject];
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
    [self addSubview:self.accessoryConnectingView positioned:NSWindowAbove relativeTo:nil];
    [self setWantsLayer:YES];
    [[XSConnectObjects sharedObject] drawLineInView:self.accessoryConnectingView
                                       atBeginPoint:[[notification.userInfo valueForKey:@"locationInWindow"] pointValue]];
    
    self.currentDataType = [[notification.userInfo valueForKey:@"dataType"] integerValue];
}

- (void)connectingDragging:(NSNotification *)notification {
    [[XSConnectObjects sharedObject] redrawLineInView:self.accessoryConnectingView
                                              atPoint:[[notification.userInfo valueForKey:@"locationInWindow"] pointValue]];
    
    NSPoint point = [self convertPoint:[[notification.userInfo valueForKey:@"locationInWindow"] pointValue] fromView:nil];

    self.hoverObject = [[XSSchemeManager sharedManager] objectAtPoint:point];
}

- (void)connectingDragEnd:(NSNotification *)notification {
    if (self.hoverObject) {
        if (self.currentDataType == XSDataTypeInput) {
            [self.selectedObject addInputConnectionObject:self.hoverObject];
            [self drawLineBetweenSelectedAndHoverObjects];
        } else if (self.currentDataType == XSDataTypeOutput) {
            [self.selectedObject addOutputConnectionObject:self.hoverObject];
            [self drawLineBetweenSelectedAndHoverObjects];
        }
    }
    
    [self.objectDetailsView reloadData];
    
    self.hoverObject = nil;
    [[XSConnectObjects sharedObject] removeLineInView:self.accessoryConnectingView];
    [self.accessoryConnectingView removeFromSuperview];
    self.currentDataType = 0;
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
    
    [self correctLinesWithObject:self.selectedObject];
}

- (void)selectObject:(NSNotification *)notification {
    if (![self.selectedObject isEqual:notification.object]) {
        
        if (self.selectedObject)
            [self.selectedObject setHighlightState:NO];
        
        self.selectedObject = notification.object;
    }
}

- (void)showObjectDetails:(NSNotification *)notification {
    self.objectDetailsView.targetObject = notification.object;
    self.selectedObject = self.objectDetailsView.targetObject;
    
    NSPoint objectDetailsViewOrigin = [[notification.userInfo valueForKey:@"locationInWindow"] pointValue];
    objectDetailsViewOrigin.x -= 5;
    objectDetailsViewOrigin.y -= self.objectDetailsView.frame.size.height - 5;
    
    if (objectDetailsViewOrigin.x + self.objectDetailsView.frame.size.width > self.frame.size.width)
        objectDetailsViewOrigin.x = self.frame.size.width - self.objectDetailsView.frame.size.width - 10;
    
    
    [self.objectDetailsView setFrameOrigin:objectDetailsViewOrigin];
    
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

#pragma mark - Setter

- (void)setSelectedObject:(XSObjectView *)selectedObject {
    
    if (![_selectedObject isEqualTo:selectedObject])
        [self.objectDetailsView removeFromSuperview];
    
    if (_selectedObject)
        [_selectedObject setHighlightState:NO];
    
    _selectedObject = selectedObject;
    
    
    [_selectedObject setHighlightState:YES];
}

- (void)setHoverObject:(XSObjectView *)hoverObject {
    _hoverObject.layer.borderWidth = 0;
    
    XSObjectType allowedObjects = -1;
    
    if (self.currentDataType == XSDataTypeInput) {
        allowedObjects = [self.selectedObject allowedInputTypes];
    } else if (self.currentDataType == XSDataTypeOutput) {
        allowedObjects = [self.selectedObject allowedOutputTypes];
    }
    
    if (hoverObject.type & allowedObjects) {
        _hoverObject = hoverObject;
    
        _hoverObject.layer.borderColor = [NSColor blueColor].CGColor;
        _hoverObject.layer.borderWidth = 2.0f;
        _hoverObject.layer.cornerRadius = 5.0f;
    } else if (!hoverObject)
        _hoverObject = nil;
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

- (NSMutableArray *)linesArray {
    if (!_linesArray) {
        _linesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _linesArray;
}


@end
