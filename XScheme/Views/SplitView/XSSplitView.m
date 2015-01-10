//
//  SplitView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSSplitView.h"
#import "XSEditorView.h"
#import "XSUtilityView.h"

@interface XSSplitView() <NSSplitViewDelegate>

@property (readonly) XSEditorView *schemeEditorView;
@property (readonly) XSUtilityView *listObjectsView;
@property (nonatomic, strong) XSObjectView *draggedObject;

@end

@implementation XSSplitView

@synthesize schemeEditorView = _schemeEditorView;
@synthesize listObjectsView = _listObjectsView;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.dividerStyle = NSSplitViewDividerStyleThick;
        [self setVertical:YES];
        
        [self addSubview:self.schemeEditorView];
        [self addSubview:self.listObjectsView];
        [self adjustSubviews];
        [self setPosition:100 ofDividerAtIndex:0];
        self.delegate = self;
        
        [self setPosition:([[NSScreen mainScreen] frame].size.width - 200) ofDividerAtIndex:0];
        self.autoresizingMask = NSViewHeightSizable;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(listObjectBeginDrag:)
                                                     name:XSListObjectBeginDragNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(listObjectEndDrag:)
                                                     name:XSListObjectEndDragNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(listObjectDragging:)
                                                     name:XSListObjectDraggingNotification
                                                   object:nil];
    }
    return self;
}

- (void)drawDividerInRect:(NSRect)rect {
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:29.0f/255.0f
                                                                                               green:29.0f/255.0f
                                                                                                blue:29.0f/255.0f
                                                                                               alpha:1.0f]
                                                         endingColor:[NSColor colorWithCalibratedRed:32.0f/255.0f
                                                                                               green:32.0f/255.0f
                                                                                                blue:32.0f/255.0f
                                                                                               alpha:1.0f]];
    [gradient drawInRect:rect angle:180];
}

#pragma mark - Dragging Notifications

- (void)listObjectBeginDrag:(NSNotification *)notification {
    XSObjectView *objectView = notification.object;
    
    self.draggedObject = [[XSObjectView alloc] initSchemeObjectWithType:objectView.type
                                                                  image:objectView.image
                                                            borderColor:objectView.borderColor];
    
    self.draggedObject.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self.draggedObject setFrame:CGRectMake([XSUtility mousePosition].x - kSchemeObjectWidth / 2, [XSUtility mousePosition].y - kSchemeObjectHeight / 2, kSchemeObjectWidth, kSchemeObjectHeight)];
    
    [self.window.contentView addSubview:self.draggedObject];
}

- (void)listObjectDragging:(NSNotification *)notification {
    NSPoint locationInWindow = [[notification.userInfo valueForKey:@"locationInWindow"] pointValue];
    
    locationInWindow.x -= kSchemeObjectWidth / 2;
    locationInWindow.y -= kSchemeObjectHeight / 2;
    
    [self.draggedObject setFrameOrigin:locationInWindow];
}

- (void)listObjectEndDrag:(NSNotification *)notification {
    XSObjectView *newObjectView = [XSObjectView duplicateSchemeObject:self.draggedObject];
    [newObjectView setFrame:self.draggedObject.frame];
    newObjectView.translatesAutoresizingMaskIntoConstraints = YES;
    [self.draggedObject removeFromSuperview];
    [self.schemeEditorView addNewSchemeObject:newObjectView];
//    [self.draggedObject removeFromSuperview];
//    [self.schemeView addNewSchemeObject:self.draggedObject];
}

#pragma mark NSSplitViewDelegate

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition
         ofSubviewAt:(NSInteger)dividerIndex {
    return [[NSScreen mainScreen] frame].size.width - 200;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition
         ofSubviewAt:(NSInteger)dividerIndex {
    return [[NSScreen mainScreen] frame].size.width - 200;
}

#pragma mark - UI ELements 

- (XSEditorView *)schemeEditorView {
    if (!_schemeEditorView) {
        _schemeEditorView = [[XSEditorView alloc] initWithFrame:CGRectMake([[self.window contentView] bounds].origin.x,
                                                                           [[self.window contentView] bounds].origin.y,
                                                                           1500,
                                                                           [[self.window contentView] bounds].size.height)];
    }
    
    return _schemeEditorView;
}

- (XSUtilityView *)listObjectsView {
    if (!_listObjectsView) {
        _listObjectsView = [[XSUtilityView alloc] initWithFrame:CGRectMake(self.schemeEditorView.bounds.size.width,
                                                                           [[self.window contentView] bounds].origin.y,
                                                                           [[self.window contentView] bounds].size.width - 400,
                                                                           [[self.window contentView] bounds].size.height)];
    }
    
    return _listObjectsView;
}

@end
