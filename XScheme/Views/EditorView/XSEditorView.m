//
//  EditorView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSEditorView.h"
#import "XSConnectObjects.h"

@interface XSEditorView()

@property (nonatomic, weak) XSObjectView *selectedObject;

@end

@implementation XSEditorView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame Color:[NSColor workplaceBackgrountColor]];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectObject:) name:XSSchemeObjectSelectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveObject:) name:XSSchemeObjectDraggingNotification object:nil];
    }
    
    return self;
}

- (void)selectObject:(NSNotification *)notification {
    if (![self.selectedObject isEqual:notification.object]) {
        
        if (self.selectedObject)
            [self.selectedObject setHighlightState:NO];
        
        self.selectedObject = notification.object;
        [self.selectedObject setHighlightState:YES];
    }
}

- (void)moveObject:(NSNotification *)notification {
    XSObjectView *movableObject = notification.object;
    
    if (![self.selectedObject isEqual:movableObject]) {
        self.selectedObject = movableObject;
        [self.selectedObject setHighlightState:YES];
    }
    
    NSPoint originPoint = [[notification.userInfo valueForKey:@"locationInWindow"] pointValue];
    originPoint.x -= kSchemeObjectHeight / 2;
    originPoint.y -= kSchemeObjectHeight / 2;
    [movableObject setFrameOrigin:originPoint];
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

@end
