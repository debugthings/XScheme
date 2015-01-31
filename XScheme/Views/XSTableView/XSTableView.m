//
//  XSTableView.m
//  XScheme
//
//  Created by Vladimir Shemet on 30.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSTableView.h"

@interface XSTableView()

@property (assign) IBOutlet NSButton *addButton;
@property (assign) IBOutlet NSButton *removeButton;
@property (assign) IBOutlet NSButton *firstTableButton;
@property (assign) IBOutlet NSButton *secondTableButton;
@property (assign) IBOutlet NSButton *thirdTableButton;

@end

@implementation XSTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self removeAllColumns];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    XSLabel *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    
    NSDictionary *currentObject = [self.dataArray objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    
    if (result == nil) {
        result = [[XSLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        result.backgroundColor = nil;
        result.identifier = @"MyView";
    }
    
    result.stringValue = [currentObject valueForKey:identifier];
    
    return result;
}

- (void)removeAllColumns {
    while([[self.tableView tableColumns] count] > 0) {
        [self.tableView removeTableColumn:[[self.tableView tableColumns] lastObject]];
    }
}

- (void)setupColumns {
    [self removeAllColumns];
    
    NSArray *keysArray = [[XSSchemeManager sharedManager] keys];
    
    for (NSInteger i = 0; i < [keysArray count]; i++) {
        NSTableColumn *tableColumn = [[NSTableColumn alloc] init];
        
        NSString *columnIdentifier = [keysArray objectAtIndex:i];
        NSString *columnHeader     = [keysArray objectAtIndex:i];
        
        [[tableColumn headerCell] setStringValue: columnHeader];
        tableColumn.identifier = columnIdentifier;
        
        [self.tableView addTableColumn:tableColumn];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.dataArray count];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self setupColumns];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)addAction:(id)sender {
    
}

- (IBAction)removeAction:(id)sender {
    
}

- (IBAction)firstTableAction:(id)sender {
    
}

- (IBAction)secondTableAction:(id)sender {
    
}

- (IBAction)thirdTableAction:(id)sender {
    
}

#pragma mark - Change table state

- (void)analisysState:(BOOL)state {
    if (state) {
        [self.addButton setHidden:YES];
        [self.removeButton setHidden:YES];
        
        [self.firstTableButton setHidden:NO];
        [self.secondTableButton setHidden:NO];
        [self.thirdTableButton setHidden:NO];
    } else {
        [self.addButton setHidden:NO];
        [self.removeButton setHidden:NO];
        
        [self.firstTableButton setHidden:YES];
        [self.secondTableButton setHidden:YES];
        [self.thirdTableButton setHidden:YES];
    }
}

@end
