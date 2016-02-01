//
//  PieChartDiagramView.m
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "PieChartDiagramView.h"
#define TO_RAD(angle) ( ( angle ) / 180.0 * M_PI )
#define TO_DEG( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

@implementation PieChartDiagramView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGContextRef ctx= [[NSGraphicsContext currentContext] graphicsPort];
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    CGFloat radius=bounds.size.height/3;
    //    CGContextSaveGState(ctx);
    
    //if ther are no pie values
    if(self.model==nil||self.model.pieValues==nil||self.model.pieValues.count==0){
        NSLog(@"No pie values exist");
        self.emptyLabel.alphaValue=1;
        CGContextSetLineWidth(ctx,5);
        CGContextSetRGBStrokeColor(ctx,0.8,0.8,0.8,1);
        CGContextSetRGBFillColor(ctx,1.00,0.86,0.01,0);
        CGContextAddArc(ctx,center.x,center.y,radius,0.0,M_PI*2,YES);
        //    CGContextStrokePath(ctx);//only one happens at a time,so use drawPath instead
        CGContextDrawPath(ctx, kCGPathFill);
        //    CGContextFillPath(ctx);
    }else{
        self.emptyLabel.alphaValue=0;
        //find the sum first
        float sum=0;
        for(PieValue *pieValue in self.model.pieValues){
            sum+=[pieValue.value floatValue];
        }
        //draw the pie chart
        float angleStart=0;
        for(PieValue *pieValue in self.model.pieValues){
            float angleValue=([pieValue.value floatValue]/sum)*360;
            NSColor *uiColor=[NSColor colorWithRed:pieValue.r green:pieValue.g blue:pieValue.b alpha:pieValue.a];
            
            CGContextSetFillColorWithColor(ctx, uiColor.CGColor);
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, center.x, center.y);
            float radStart=TO_RAD(angleStart);
            float radEnd=TO_RAD(angleStart+angleValue);
            CGContextAddArc(ctx, center.x, center.y, radius, radStart,radEnd, 0);
            CGContextClosePath(ctx);
            CGContextFillPath(ctx);
            
            angleStart+=angleValue;
            
        }
        
    }
}

-(void)setModel:(PieChart *)model{
    if(_model!=model){
        _model=model;
        [self setNeedsDisplay:YES];
        [self.legendTable reloadData];
    }
}

-(void)setLegendTable:(NSTableView *)legendTable{
    if(_legendTable!=legendTable){
        _legendTable=legendTable;
        _legendTable.dataSource=self;
        _legendTable.delegate=self;
    }
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSLog(@"pie values : %lu",(unsigned long)self.model.pieValues.count);
    return self.model.pieValues.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    // Retrieve to get the @"MyView" from the pool or,
    // if no version is available in the pool, load the Interface Builder version

    NSTableCellView *result;
    PieValue *pieValue=(PieValue *)[self.model.pieValues objectAtIndex:row];
    if(tableColumn==self.legendColor){
        result = [tableView makeViewWithIdentifier:@"LegendColorCell" owner:self];
        result.textField.backgroundColor=[NSColor colorWithRed:pieValue.r green:pieValue.g blue:pieValue.b alpha:pieValue.a];
        result.textField.stringValue=@"";
        [result.textField setDrawsBackground:YES];
    }else{
        result = [tableView makeViewWithIdentifier:@"LegendNameCell" owner:self];

        // Set the stringValue of the cell's text field to the nameArray value at row
        result.textField.stringValue = pieValue.name;
    }
    // Return the result
    return result;
}

@end
