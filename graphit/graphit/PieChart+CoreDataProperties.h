//
//  PieChart+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PieChart.h"

NS_ASSUME_NONNULL_BEGIN

@interface PieChart (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *angle;
@property (nullable, nonatomic, retain) NSSet<PieValue *> *pieValues;

@end

@interface PieChart (CoreDataGeneratedAccessors)

- (void)addPieValuesObject:(PieValue *)value;
- (void)removePieValuesObject:(PieValue *)value;
- (void)addPieValues:(NSSet<PieValue *> *)values;
- (void)removePieValues:(NSSet<PieValue *> *)values;

@end

NS_ASSUME_NONNULL_END
