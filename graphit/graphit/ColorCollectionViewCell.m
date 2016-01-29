//
//  ColorCollectionViewCell.m
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@implementation ColorCollectionViewCell

-(void)drawRect:(CGRect)rect{
    // Drawing code
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    CGFloat radius=bounds.size.height/3;
    CGContextSaveGState(ctx);
    
    CGContextSetLineWidth(ctx,5);
    CGContextSetRGBStrokeColor(ctx,0.8,0.8,0.8,1);
    CGContextSetRGBFillColor(ctx,1.00,0.86,0.01,1);
    CGContextAddArc(ctx,center.x,center.y,radius,0.0,M_PI*2,YES);
    //    CGContextStrokePath(ctx);//only one happens at a time,so use drawPath instead
    CGContextDrawPath(ctx, kCGPathFill);
    //    CGContextFillPath(ctx);
}

@end
