//
//  MainSplitViewController.h
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainSplitViewController : NSSplitViewController
@property (strong) NSMetadataQuery *query;
@property (strong) NSMutableArray *documents;
@end
