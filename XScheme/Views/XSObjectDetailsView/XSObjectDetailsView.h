//
//  XSObjectDetailsView.h
//  XScheme
//
//  Created by Vladimir Shemet on 17.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSView.h"

@interface XSObjectDetailsView : XSView

@property (nonatomic, weak) XSObjectView *targetObject;

- (void)reloadData;

@end
