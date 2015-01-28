//
//  XSDataCell.m
//  XScheme
//
//  Created by Vladimir Shemet on 27.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSDataCell.h"

static NSInteger const kHeightForCell = 17;

@interface XSDataCell()

@property (readonly) XSLabel *titleLabel;
@property (readonly) NSButton *cancelButton;

@end

@implementation XSDataCell

@synthesize titleLabel = _titleLabel;
@synthesize cancelButton = _cancelButton;

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(2, 2, 196, kHeightForCell)
                          Color:[NSColor colorWithRed:57.0f/255.0f green:57.0f/255.0f blue:57.0f/255.0f alpha:0.8f]];
    
    if (self) {
        [self addSubview:self.cancelButton];
        [self addSubview:self.titleLabel];
        
        [self setWantsLayer:YES];
        self.layer.cornerRadius = 7.5f;
        
        [self.titleLabel setStringValue:@"X1"];
    }
    
    return self;
}

#pragma mark - UI Elements

- (XSLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[XSLabel alloc] initWithFrame:CGRectMake(kHeightForCell, 1, 170, kHeightForCell - 2)];
        _titleLabel.backgroundColor = nil;
        _titleLabel.textColor = [NSColor whiteColor];
        _titleLabel.font = [NSFont systemFontOfSize:12.0f];
        [_titleLabel setAlignment:NSCenterTextAlignment];
    }
    
    return _titleLabel;
}

- (NSButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [NSButton new];
        [_cancelButton setFrame:CGRectMake(1, 1, 15, 15)];
        [_cancelButton setImage:[NSImage imageNamed:NSImageNameStopProgressFreestandingTemplate]];
        [_cancelButton setBordered:NO];
        [_cancelButton setTransparent:NO];
        [_cancelButton setButtonType:NSMomentaryChangeButton];
    }
    
    return _cancelButton;
}

@end
