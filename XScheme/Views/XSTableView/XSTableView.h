//
//  XSTableView.h
//  XScheme
//
//  Created by Vladimir Shemet on 30.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSView.h"

@interface XSTableView : XSView <NSTableViewDataSource, NSTableViewDelegate>

@property (assign) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

- (IBAction)addAction:(id)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)firstTableAction:(id)sender;
- (IBAction)secondTableAction:(id)sender;
- (IBAction)thirdTableAction:(id)sender;

- (void)analisysState:(BOOL)state;

@end
