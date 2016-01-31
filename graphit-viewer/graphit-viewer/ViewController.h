//
//  ViewController.h
//  graphit-viewer
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PieChartDiagramView.h"

@interface ViewController : NSViewController<NSTableViewDataSource,NSTableViewDelegate>
@property (weak) IBOutlet NSTableView *tableView;

@property (weak) IBOutlet PieChartDiagramView *pieChartView;


@end

