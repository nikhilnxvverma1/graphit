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
    
    PieChart *pieChart=[[PieChart alloc] init];
    pieChart.title=@"Sports";
    PieValue *p11=[[PieValue alloc] init];
    p11.r=0.1;
    p11.g=0.4;
    p11.b=0.2;
    p11.a=1;
    p11.name=@"Football";
    p11.value=@13;
    [pieChart addPieValue:p11];
    
    PieValue *p12=[[PieValue alloc] init];
    p12.r=0.9;
    p12.g=0.3;
    p12.b=0.8;
    p12.a=1;
    p12.name=@"Cricket";
    p12.value=@53;
    [pieChart addPieValue:p12];
    
    PieValue *p13=[[PieValue alloc] init];
    p13.r=1.0;
    p13.g=1.0;
    p13.b=0.3;
    p13.a=1;
    p13.name=@"Volleyball";
    p13.value=@23;
    [pieChart addPieValue:p13];
    
    [self.pieChartView setModel:pieChart];
    
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
    NSLog(@"Selection changed to %ld",[self.tableView selectedRow]);
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    PieChart *model=[appDelegate.pieCharts objectAtIndex:[self.tableView selectedRow]];
    [self.pieChartView setModel:model];
}



@end
