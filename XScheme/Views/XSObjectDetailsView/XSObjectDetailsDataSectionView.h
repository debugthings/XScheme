//
//  XSObjectDetailsDataSectionView.h
//  XScheme
//
//  Created by Vladimir Shemet on 19.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSView.h"

@class XSObjectDetailsDataSectionView;

@protocol XSDataSectionDelegate <NSObject>

- (NSArray *)objectForSectionView:(XSObjectDetailsDataSectionView *)sectionView;

@end

@interface XSObjectDetailsDataSectionView : XSView

@property (nonatomic, strong) NSString *title;
@property (nonatomic) XSDataType dataType;
@property (nonatomic, weak) id<XSDataSectionDelegate> delegate;

- (CGFloat)height;

@end
