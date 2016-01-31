//
//  PieChart.m
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "PieChart.h"

@implementation PieChart

-(id)init{
    if(self=[super init]){
        self.pieValues=[NSMutableArray array];
    }
    return self;
}

-(void)addPieValue:(PieValue*)pieValue{
    [self.pieValues addObject:pieValue];
}

@end
