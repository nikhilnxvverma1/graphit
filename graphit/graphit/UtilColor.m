//
//  UtilColor.m
//  graphit
//
//  Created by Nikhil Verma on 30/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "UtilColor.h"
@import CoreGraphics;

@implementation UtilColor
@synthesize r;
@synthesize g;
@synthesize b;
@synthesize a;

-(id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    if(self=[super init]){
        self.r=red;
        self.g=green;
        self.b=blue;
        self.a=1;//default
    }
    return self;
}
@end
