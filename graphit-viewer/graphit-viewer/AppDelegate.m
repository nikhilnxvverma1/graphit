//
//  AppDelegate.m
//  graphit-viewer
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "AppDelegate.h"
#import "PieChart.h"
#import "PieChartDocument.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.pieCharts=[NSMutableArray array];
//    [self loadTestData];
//    NSLog(@"Done loading data");
    [self loadDocuments];
    [self.viewController.tableView reloadData];
}


-(void)loadTestData{
    //create 3 pi charts
    PieChart *pieChart=[[PieChart alloc] init];
    pieChart.title=@"Sports";
    PieValue *p11=[[PieValue alloc] init];
    p11.r=0.2;
    p11.g=0.4;
    p11.b=0.6;
    p11.a=1;
    p11.name=@"Football";
    p11.value=@63;
    [pieChart addPieValue:p11];
    
    PieValue *p12=[[PieValue alloc] init];
    p12.r=0.6;
    p12.g=0.2;
    p12.b=0.8;
    p12.a=1;
    p12.name=@"Cricket";
    p12.value=@33;
    [pieChart addPieValue:p12];
    
    PieValue *p13=[[PieValue alloc] init];
    p13.r=1.0;
    p13.g=0.7;
    p13.b=0.3;
    p13.a=1;
    p13.name=@"Volleyball";
    p13.value=@13;
    [pieChart addPieValue:p13];
    
    [self.pieCharts addObject:pieChart];
    
}



- (void)loadDocuments {
    
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    if (ubiq) {
        
        self.query = [[NSMetadataQuery alloc] init];
        [self.query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
        NSPredicate *pred = [NSPredicate predicateWithFormat: @"%K like 'PieChart_*'", NSMetadataItemFSNameKey];
        [self.query setPredicate:pred];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(queryDidFinishGathering:)
                                                     name:NSMetadataQueryDidFinishGatheringNotification
                                                   object:self.query];
        
        [self.query startQuery];
        
    } else {
        
        NSLog(@"No iCloud access");
        
    }
    
}

- (void)queryDidFinishGathering:(NSNotification *)notification {
    
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    [query stopQuery];
    
    [self loadData:query];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSMetadataQueryDidFinishGatheringNotification
                                                  object:query];
    
    self.query = nil;
    
}

- (void)loadData:(NSMetadataQuery *)query {
    
    //    [self.notes removeAllObjects];
    
    for (NSMetadataItem *item in [query results]) {
        
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        NSLog(@"File from iCloud: %@",url);
        
        NSError *error=nil;
        PieChartDocument *doc =[[PieChartDocument alloc] initWithContentsOfURL:url ofType:@"txt" error:&error];
        if(error){
            NSLog(@"Document's data stored albeit with %@",error);
        }
//        [self.documents addObject:doc];
        
        
        //        PieChartDocument *doc = [[PieChartDocument alloc] initWithFileURL:url];
        //        NSLog(@"File from iCloud: %@",[doc fileURL]);
        //        [doc openWithCompletionHandler:^(BOOL success) {
        //            if (success) {
        //
        //                //                [self.notes addObject:doc];
        //                //                [self.tableView reloadData];
        //
        //                NSLog(@"Documents read from iCloud");
        //            } else {
        //                NSLog(@"failed to open from iCloud");
        //            }
        //            
        //        }];
        //        
    }
    [self.viewController.tableView reloadData];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
