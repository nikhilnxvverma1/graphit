//
//  PieChartDocument.h
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PieChart.h"
@interface PieChartDocument : NSDocument
@property (strong) NSString *noteContent;
@property (strong) PieChart *pieChart;
@end
