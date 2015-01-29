//
//  XSEditorView+ConnectObjects.h
//  XScheme
//
//  Created by Vladimir Shemet on 24.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSEditorView.h"

@interface XSEditorView (ConnectObjects)

- (void)drawLineBetweenObjectsWithFirstObjectOutputDataState:(BOOL)isOutputData;
- (NSDictionary *)correctLine:(NSDictionary *)lineDictionary;
- (NSArray *)linesWithObject:(XSObjectView *)objextView;

- (void)correctLinesWithObject:(XSObjectView *)objectView;
- (void)removeLinesWithObject:(XSObjectView *)objectView;

@end
