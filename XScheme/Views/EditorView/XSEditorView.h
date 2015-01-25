//
//  EditorView.h
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XSEditorView : XSView

@property (nonatomic, weak) XSObjectView *selectedObject;
@property (nonatomic, weak) XSObjectView *hoverObject;
@property (readonly) NSMutableArray *linesArray;

- (void)addNewSchemeObject:(XSObjectView *)newObjectView;

@end