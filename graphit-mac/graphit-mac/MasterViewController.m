//
//  MasterViewController.m
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()
@property NSMutableArray *documents;
@end

@implementation MasterViewController
@synthesize documents;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.documents=[NSMutableArray arrayWithObjects:@"first",@"second",@"third", nil];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return documents.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    // Retrieve to get the @"MyView" from the pool or,
    // if no version is available in the pool, load the Interface Builder version
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"TableCell" owner:self];
    
    // Set the stringValue of the cell's text field to the nameArray value at row
    result.textField.stringValue = [self.documents objectAtIndex:row];
    
    // Return the result
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification{
    NSLog(@"Selection changed to %ld",[self.tableView selectedRow]);
}


@end
