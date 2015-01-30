//
//  XSObjectDetailsDataSectionView.m
//  XScheme
//
//  Created by Vladimir Shemet on 19.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSObjectDetailsDataSectionView.h"
#import "XSNewConnectionButton.h"
#import "XSDataCell.h"

static NSInteger const kHeightForCell = 17;
static NSInteger const kHeightForNewConnectionButton = 40;
static NSInteger const kIndentBetweenCells = 2;

@interface XSObjectDetailsDataSectionView() <XSDataCellDelegate>

@property (readonly) XSLabel *titleLabel;
@property (readonly) XSNewConnectionButton *newConnectionButton;
@property (nonatomic) NSArray *dataArray;

@property (nonatomic, readonly) NSMutableArray *cells;

@end

@implementation XSObjectDetailsDataSectionView

@synthesize titleLabel = _titleLabel;
@synthesize newConnectionButton = _newConnectionButton;
@synthesize cells = _cells;

- (CGFloat)height {
    CGFloat height = kHeightForCell + [self numberOfRows] * kHeightForCell + ([self numberOfRows] + 1) * kIndentBetweenCells;
    
    if ([self isAllowNewConnection])
        height += kHeightForNewConnectionButton;
    
    return height;
}

- (NSInteger)numberOfRows {
    return [self.dataArray count];
}

- (void)dataForSection {
    if (self.delegate && [self.delegate respondsToSelector:@selector(objectForSectionView:)]) {
        self.dataArray = [self.delegate objectForSectionView:self];
    }
}

- (void)configureSectionView {
    [self setFrameSize:CGSizeMake(200, [self height])];
    [self.titleLabel setFrame:CGRectMake(0, self.frame.size.height - kHeightForCell, self.frame.size.width, kHeightForCell)];
    [self addSubview:self.titleLabel];
    
    for (int i = 0; i < [self numberOfRows]; i++) {
        XSObjectView *currentObject = self.dataArray[i];
        XSDataCell *cell = [[XSDataCell alloc] init];
        cell.delegate = self;
        [cell setTitle:currentObject.title];
        [cell setFrameOrigin:CGPointMake(2, self.frame.size.height - kHeightForCell - ((i + 1) * (kIndentBetweenCells + kHeightForCell)))];
        [self addSubview:cell];
        [self.cells addObject:cell];
    }
    
    if ([self isAllowNewConnection]) {
        [self.newConnectionButton setFrame:CGRectMake(0, self.frame.size.height - kHeightForCell - [self.dataArray count] * (kIndentBetweenCells + kHeightForCell) - kIndentBetweenCells - kHeightForNewConnectionButton, self.frame.size.width, kHeightForNewConnectionButton)];
        [self addSubview:self.newConnectionButton];
    }
}

- (BOOL)isAllowNewConnection {
    if (self.delegate && [self.delegate respondsToSelector:@selector(isAllowNewConnectionForSectionView:)])
        return [self.delegate isAllowNewConnectionForSectionView:self];
    
    return YES;
}

#pragma mark - XSDataCellDelegate

- (void)highlightDataCell:(XSDataCell *)cell {
    NSInteger index = [self.cells indexOfObject:cell];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionView:highlightCellAtIndex:)] && index != NSNotFound)
        [self.delegate sectionView:self highlightCellAtIndex:index];
}

- (void)unhighlightDataCell:(XSDataCell *)cell {
    NSInteger index = [self.cells indexOfObject:cell];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionView:unhighlightCellAtIndex:)] && index != NSNotFound)
        [self.delegate sectionView:self unhighlightCellAtIndex:index];
}

- (void)cancelPressedAtDataCell:(XSDataCell *)cell {
    NSInteger index = [self.cells indexOfObject:cell];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionView:pressedCancelAtIndex:)] && index != NSNotFound)
        [self.delegate sectionView:self pressedCancelAtIndex:index];
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.titleLabel setStringValue:_title];
}

- (void)setDataType:(XSDataType)dataType {
    _dataType = dataType;
    
    self.newConnectionButton.dataType = _dataType;
}

- (void)setDelegate:(id<XSDataSectionDelegate>)delegate {
    _delegate = delegate;
    
    [self dataForSection];
    [self configureSectionView];
}

- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _cells;
}

#pragma mark - UI Elements

- (XSLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[XSLabel alloc] init];
        _titleLabel.backgroundColor = [NSColor colorWithRed:41.0f/255.0f green:42.0f/255.0f blue:43.0f/255.0f alpha:0.8f];
        _titleLabel.textColor = [NSColor whiteColor];
        _titleLabel.font = [NSFont systemFontOfSize:12.0f];
    }
    
    return _titleLabel;
}

- (XSNewConnectionButton *)newConnectionButton {
    if (!_newConnectionButton) {
        _newConnectionButton = [[XSNewConnectionButton alloc] init];
        _newConnectionButton.title = @"New connection";
    }
    
    return _newConnectionButton;
}

@end