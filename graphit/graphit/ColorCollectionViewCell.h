//
//  ColorCollectionViewCell.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"
@interface ColorCollectionViewCell : UICollectionViewCell
//These rgb values are between 0 to 1
@property (nonatomic) CGFloat r;
@property (nonatomic) CGFloat g;
@property (nonatomic) CGFloat b;

@end
