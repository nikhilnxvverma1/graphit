//
//  Axis+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Axis.h"

NS_ASSUME_NONNULL_BEGIN

@interface Axis (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *referenceValue;

@end

NS_ASSUME_NONNULL_END
