//
//  BarGraph+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BarGraph.h"

NS_ASSUME_NONNULL_BEGIN

@interface BarGraph (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *scale;
@property (nullable, nonatomic, retain) NSSet<BarCollection *> *barCollections;
@property (nullable, nonatomic, retain) Axis *yAxis;

@end

@interface BarGraph (CoreDataGeneratedAccessors)

- (void)addBarCollectionsObject:(BarCollection *)value;
- (void)removeBarCollectionsObject:(BarCollection *)value;
- (void)addBarCollections:(NSSet<BarCollection *> *)values;
- (void)removeBarCollections:(NSSet<BarCollection *> *)values;

@end

NS_ASSUME_NONNULL_END
