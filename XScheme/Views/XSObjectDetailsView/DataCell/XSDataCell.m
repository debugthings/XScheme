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

@property (nonatomic) NSTrackingArea *trackingArea;
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
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.stringValue = title;
}

-(void)updateTrackingAreas {
    if(self.trackingArea != nil) {
        [self removeTrackingArea:self.trackingArea];
    }
    
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                options:opts
                                                  owner:self
                                               userInfo:nil];
    [self addTrackingArea:self.trackingArea];
}

- (void)cancelButtonAction:(NSButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPressedAtDataCell:)])
        [self.delegate cancelPressedAtDataCell:self];
}

#pragma mark - Mouse responds

- (void)mouseEntered:(NSEvent *)theEvent {
    [self setWantsLayer:YES];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [NSColor whiteColor].CGColor;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(highlightDataCell:)])
        [self.delegate highlightDataCell:self];
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.layer.borderWidth = 0.0f;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(unhighlightDataCell:)])
        [self.delegate unhighlightDataCell:self];
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
        
        [_cancelButton setTarget:self];
        [_cancelButton setAction:@selector(cancelButtonAction:)];
    }
    
    return _cancelButton;
}

@end
