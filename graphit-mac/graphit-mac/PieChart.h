//
//  PieChart.h
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PieValue.h"
@interface PieChart : NSObject
@property (strong) NSString *title;
@property (strong) NSMutableArray *pieValues;
-(void)addPieValue:(PieValue*)pieValue;
@end
