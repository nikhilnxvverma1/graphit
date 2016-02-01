//
//  ViewController.m
//  graphit-viewer
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "ViewController.h"
#import "PieChart.h"
#import "AppDelegate.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSLog(@"view got loaded");
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    appDelegate.viewController=self;
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.pieChartView.emptyLabel=self.emptyLabel;
    self.pieChartView.legendTable=self.legendTable;
    self.pieChartView.legendColor=self.legendColor;
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    NSLog(@"count of objects %lu",(unsigned long)appDelegate.pieCharts.count);
    return appDelegate.pieCharts.count;
//    return 6;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    
    // Retrieve to get the @"MyView" from the pool or,
    // if no version is available in the pool, load the Interface Builder version
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"TableCell" owner:self];
    
    // Set the stringValue of the cell's text field to the nameArray value at row
    result.textField.stringValue = ((PieChart*)[appDelegate.pieCharts objectAtIndex:row]).title;
    NSLog(@"Making cell");
//    result.textField.stringValue=@"Pie Chart";
    // Return the result
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification{
//    NSLog(@"Selection changed to %ld",[self.tableView selectedRow]);
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    NSInteger row=[self.tableView selectedRow];
    if(row<appDelegate.pieCharts.count){
        PieChart *model=[appDelegate.pieCharts objectAtIndex:row];
        [self.pieChartView setModel:model];
    }

}



@end
