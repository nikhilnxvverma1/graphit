//
//  PieChartDiagramView.h
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PieChart.h"
@interface PieChartDiagramView : NSView<NSTableViewDelegate,NSTableViewDataSource>

@property (strong,nonatomic ) PieChart *model;
@property (weak,nonatomic) NSTextField *emptyLabel;
@property (weak,nonatomic) NSTableView *legendTable;
@property (weak,nonatomic) NSTableColumn *legendColor;
@end
