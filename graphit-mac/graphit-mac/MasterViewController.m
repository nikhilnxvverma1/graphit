//
//  MasterViewController.m
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "MasterViewController.h"
#import "AppDelegate.h"
#import "PieChart.h"
#import "PieValue.h"

@interface MasterViewController ()
@property NSMutableArray *documents;
@end

@implementation MasterViewController
@synthesize documents;

//
//-(void)viewWillAppear{
//    //load test data
//    [self loadTestData];
//}
//
//-(void)loadTestData{
//    //create 3 pi charts
//    PieChart *pieChart=[[PieChart alloc] init];
//    pieChart.title=@"Sports";
//    PieValue *p11=[[PieValue alloc] init];
//    p11.r=0.2;
//    p11.g=0.4;
//    p11.b=0.6;
//    p11.a=1;
//    p11.name=@"Football";
//    p11.value=@63;
//    [pieChart addPieValue:p11];
//    
//    PieValue *p12=[[PieValue alloc] init];
//    p12.r=0.6;
//    p12.g=0.2;
//    p12.b=0.8;
//    p12.a=1;
//    p12.name=@"Cricket";
//    p12.value=@33;
//    [pieChart addPieValue:p12];
//    
//    PieValue *p13=[[PieValue alloc] init];
//    p13.r=1.0;
//    p13.g=0.7;
//    p13.b=0.3;
//    p13.a=1;
//    p13.name=@"Volleyball";
//    p13.value=@13;
//    [pieChart addPieValue:p13];
//    
//    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
//    [appDelegate.pieCharts addObject:pieChart];
//    
//}
//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.documents=[NSMutableArray arrayWithObjects:@"first",@"second",@"third", nil];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    NSLog(@"count of objects %lu",(unsigned long)appDelegate.pieCharts.count);
    return appDelegate.pieCharts.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    
    // Retrieve to get the @"MyView" from the pool or,
    // if no version is available in the pool, load the Interface Builder version
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"TableCell" owner:self];
    
    // Set the stringValue of the cell's text field to the nameArray value at row
    result.textField.stringValue = [appDelegate.pieCharts objectAtIndex:row];
    
    // Return the result
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification{
    NSLog(@"Selection changed to %ld",[self.tableView selectedRow]);
}


@end
