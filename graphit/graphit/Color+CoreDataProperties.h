//
//  Color+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Color.h"

NS_ASSUME_NONNULL_BEGIN

@interface Color (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *alpha;
@property (nullable, nonatomic, retain) NSNumber *blue;
@property (nullable, nonatomic, retain) NSNumber *green;
@property (nullable, nonatomic, retain) NSNumber *red;

@end

NS_ASSUME_NONNULL_END
