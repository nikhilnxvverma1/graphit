//
//  BarValue+CoreDataProperties.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BarValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface BarValue (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *rank;
@property (nullable, nonatomic, retain) NSNumber *value;
@property (nullable, nonatomic, retain) BarCollection *barCollection;
@property (nullable, nonatomic, retain) Legend *legend;

@end

NS_ASSUME_NONNULL_END
