//
//  PieValue+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 30/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PieValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface PieValue (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSNumber *value;
@property (nullable, nonatomic, retain) Legend *legend;
@property (nullable, nonatomic, retain) PieChart *pieChart;

@end

NS_ASSUME_NONNULL_END
