//
//  XSDataCell.h
//  XScheme
//
//  Created by Vladimir Shemet on 27.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSView.h"

@class XSDataCell;

@protocol XSDataCellDelegate <NSObject>

- (void)highlightDataCell:(XSDataCell *)cell;
- (void)unhighlightDataCell:(XSDataCell *)cell;
- (void)cancelPressedAtDataCell:(XSDataCell *)cell;

@end

@interface XSDataCell : XSView

@property (nonatomic, weak) id<XSDataCellDelegate> delegate;

- (void)setTitle:(NSString *)title;

@end
