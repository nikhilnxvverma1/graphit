//
//  PieChartView.m
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "PieChartView.h"
#define FADE_OUT @"fadeOut"

@implementation PieChartView
@synthesize pieValueDescription;

-(void)initView{
    
}

- (id)initWithCoder:(NSCoder *)aCoder{
    if(self = [super initWithCoder:aCoder]){
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        [self initView];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
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

#pragma mark - Touch event handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Began(PieChart)");
    [pieValueDescription setAlpha:1];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Moved(PieChart)");
}
- (void)fadeOutPieValueDescription {
    CABasicAnimation *fadeOut=[CABasicAnimation animation];
    fadeOut.keyPath=@"opacity";
    fadeOut.fromValue=@1;
    fadeOut.toValue=@0;
    fadeOut.duration=0.5;
    
    [pieValueDescription.layer addAnimation:fadeOut forKey:FADE_OUT];
    pieValueDescription.alpha=0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Ended(PieChart)");
    [self fadeOutPieValueDescription];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Cancelled(PieChart)");
    [self fadeOutPieValueDescription];
}

@end
