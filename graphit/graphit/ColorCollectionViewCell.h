//
//  ColorCollectionViewCell.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"
#import "UtilColor.h"
@interface ColorCollectionViewCell : UICollectionViewCell
@property (nonatomic) UtilColor* utilColor;
//The color model should not be changed internally by this class
@property (strong,nonatomic) Color *colorModel;

@end
