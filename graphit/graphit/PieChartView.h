//
//  PieChartView.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChart.h"

@interface PieChartView : UIView
@property (weak, nonatomic) UILabel *pieValueDescription;
@property (weak, nonatomic) PieChart *model;
@end
