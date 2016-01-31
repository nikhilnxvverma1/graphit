//
//  PieChartView.m
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "PieChartView.h"
#define FADE_OUT @"fadeOut"
#import "PieValue.h"
#import "Legend.h"
#import "Color.h"
#define TO_RAD(angle) ( ( angle ) / 180.0 * M_PI )
#define TO_DEG( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

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
//    CGContextSaveGState(ctx);
    
    //if ther are no pie values
    if(self.model==nil||self.model.pieValues==nil||self.model.pieValues.count==0){
        CGContextSetLineWidth(ctx,5);
        CGContextSetRGBStrokeColor(ctx,0.8,0.8,0.8,1);
        CGContextSetRGBFillColor(ctx,1.00,0.86,0.01,0);
        CGContextAddArc(ctx,center.x,center.y,radius,0.0,M_PI*2,YES);
        //    CGContextStrokePath(ctx);//only one happens at a time,so use drawPath instead
        CGContextDrawPath(ctx, kCGPathFill);
        //    CGContextFillPath(ctx);
    }else{
        
        //find the sum first
        float sum=0;
        for(PieValue *pieValue in self.model.pieValues){
            sum+=[pieValue.value floatValue];
        }
        
        NSArray *sortDescriptors = @[
                                     [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]
                                     ];
        
        NSArray *sortedPieValues = [self.model.pieValues sortedArrayUsingDescriptors:sortDescriptors];
//        NSLog(@"%@", sortedPieValues);
        //draw the pie chart
        float angleStart=0;
        for(PieValue *pieValue in sortedPieValues){
            float angleValue=([pieValue.value floatValue]/sum)*360;
            NSLog(@"angle is %f,%f",angleStart,angleValue);
            Color *color=pieValue.legend.legendColor;
            UIColor *uiColor=[UIColor colorWithRed:[color.red floatValue] green:[color.green floatValue] blue:[color.blue floatValue] alpha:[color.alpha floatValue]];
            
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
        [self setNeedsDisplay];
    }
}

#pragma mark - Touch event handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Began(PieChart)");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    [self showValueForTouch:location];
    [pieValueDescription setAlpha:1];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Moved(PieChart)");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    [self showValueForTouch:location];
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

-(void)showValueForTouch:(CGPoint)point{
    //center and radius
    CGRect bounds = [self bounds];
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
//    CGFloat radius=bounds.size.height/3;
    
    float vectorAngle=[self angleOfVector:center :point];
    
    //find the sum first
    float sum=0;
    for(PieValue *pieValue in self.model.pieValues){
        sum+=[pieValue.value floatValue];
    }
    
    NSArray *sortDescriptors = @[
                                 [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]
                                 ];
    
    NSArray *sortedPieValues = [self.model.pieValues sortedArrayUsingDescriptors:sortDescriptors];
    PieValue *touchedPie=nil;
    float angleStart=0;
    for(PieValue *pieValue in sortedPieValues){
        float angleValue=([pieValue.value floatValue]/sum)*360;
        NSLog(@"angle is %f,%f",angleStart,angleValue);
        
        if(vectorAngle>=angleStart&&vectorAngle<=(angleStart+angleValue)){
            touchedPie=pieValue;
            break;
        }
        angleStart+=angleValue;
    }
    self.pieValueDescription.text=[NSString stringWithFormat:@"%@: %@",touchedPie.legend.name,touchedPie.value];
    Color *color=touchedPie.legend.legendColor;
    self.pieValueDescription.textColor=[UIColor colorWithRed:[color.red floatValue] green:[color.green floatValue] blue:[color.blue floatValue] alpha:[color.alpha floatValue]];
    
}

-(int)angleOfVector:(CGPoint)origin :(CGPoint) towards{
    int inDegrees=0;
    if (towards.x - origin.x == 0) {
        inDegrees = 90;
        if(towards.y<origin.y){
            inDegrees+=180;
        }
    }else{
        double slope=(double)(towards.y-origin.y)/(towards.x-origin.x);
        inDegrees=TO_DEG(atan(slope));
        //angle is between +90 and -90
        if(towards.y>origin.y){
            if(towards.x>origin.x){//first quadrant
                //do nothing
            }else{//second quadrant
                inDegrees+=180;
            }
        }else{
            if(towards.x<origin.x){//third quadrant
                inDegrees+=180;
            }else{//fourth quadrant
                inDegrees+=360;
            }
        }
    }
    return inDegrees;
}


@end
