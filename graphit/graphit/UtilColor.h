//
//  UtilColor.h
//  graphit
//
//  Created by Nikhil Verma on 30/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@interface UtilColor : NSObject
@property CGFloat r;
@property CGFloat g;
@property CGFloat b;
@property CGFloat a;
-(id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
@end
