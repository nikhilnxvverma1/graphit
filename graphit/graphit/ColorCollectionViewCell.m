//
//  ColorCollectionViewCell.m
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@implementation ColorCollectionViewCell
@synthesize utilColor;

-(void)initView{
    utilColor=[[UtilColor alloc] initWithRed:0.0 green:1 blue:1];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

-(id)init{
    if(self=[super init]){
        [self initView];
    }
    return self;
}

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
//    CGContextSetRGBStrokeColor(ctx,0.8,0.8,0.8,1);
    CGContextSetRGBFillColor(ctx,utilColor.r,utilColor.g,utilColor.b,1);
    CGContextAddArc(ctx,center.x,center.y,radius,0.0,M_PI*2,YES);
    //    CGContextStrokePath(ctx);//only one happens at a time,so use drawPath instead
//    CGContextDrawPath(ctx, kCGPathFill);
        CGContextFillPath(ctx);
}

-(void)prepareForReuse{
    self.backgroundColor=[UIColor clearColor];
}


-(void)setColorModel:(Color *)colorModel{
    _colorModel=colorModel;
    [self setRed:colorModel.red green:colorModel.green blue:colorModel.blue];
}

-(void)setRed:(NSNumber*)red green:(NSNumber*)green blue:(NSNumber*)blue{
    utilColor.r=[red floatValue];
    utilColor.g=[green floatValue];
    utilColor.b=[blue floatValue];
}

@end
