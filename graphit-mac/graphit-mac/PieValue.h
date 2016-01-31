//
//  PieValue.h
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PieValue : NSObject
@property CGFloat r;
@property CGFloat g;
@property CGFloat b;
@property CGFloat a;
@property (strong) NSString *name;
@property (strong) NSNumber *value;
@end
