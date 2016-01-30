//
//  BarCollection+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BarCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface BarCollection (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *label;
@property (nullable, nonatomic, retain) NSNumber *rank;
@property (nullable, nonatomic, retain) BarGraph *barGraph;
@property (nullable, nonatomic, retain) NSSet<BarValue *> *barValues;

@end

@interface BarCollection (CoreDataGeneratedAccessors)

- (void)addBarValuesObject:(BarValue *)value;
- (void)removeBarValuesObject:(BarValue *)value;
- (void)addBarValues:(NSSet<BarValue *> *)values;
- (void)removeBarValues:(NSSet<BarValue *> *)values;

@end

NS_ASSUME_NONNULL_END
