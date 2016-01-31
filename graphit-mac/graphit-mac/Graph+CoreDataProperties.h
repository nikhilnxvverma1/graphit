//
//  Graph+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Graph.h"

NS_ASSUME_NONNULL_BEGIN

@interface Graph (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *scale;
@property (nullable, nonatomic, retain) NSSet<DataPoint *> *dataPoints;
@property (nullable, nonatomic, retain) Axis *xAxis;
@property (nullable, nonatomic, retain) Axis *yAxis;

@end

@interface Graph (CoreDataGeneratedAccessors)

- (void)addDataPointsObject:(DataPoint *)value;
- (void)removeDataPointsObject:(DataPoint *)value;
- (void)addDataPoints:(NSSet<DataPoint *> *)values;
- (void)removeDataPoints:(NSSet<DataPoint *> *)values;

@end

NS_ASSUME_NONNULL_END
