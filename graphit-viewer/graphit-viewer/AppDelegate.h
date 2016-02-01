//
//  AppDelegate.h
//  graphit-viewer
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
- (IBAction)refresh:(id)sender;

@property (strong,nonatomic) NSMutableArray *pieCharts;
@property (strong,nonatomic) ViewController *viewController;
@property (strong) NSMetadataQuery *query;
@end

