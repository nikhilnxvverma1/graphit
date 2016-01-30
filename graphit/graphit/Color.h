//
//  Color.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Color : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property int r;
@property int g;
@property int b;


@end

NS_ASSUME_NONNULL_END

#import "Color+CoreDataProperties.h"
