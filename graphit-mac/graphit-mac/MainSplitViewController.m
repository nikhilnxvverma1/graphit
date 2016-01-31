//
//  MainSplitViewController.m
//  graphit-mac
//
//  Created by Nikhil Verma on 31/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "MainSplitViewController.h"
#import "PieChartDocument.h"

@interface MainSplitViewController ()

@end

@implementation MainSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSLog(@"Came here to split view controller");
    
    //load documents
    [self loadDocuments];
    
}


- (void)loadDocuments {
    
    self.documents=[NSMutableArray array];
    
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
            NSLog(@"Error in obtaing iCloud document %@",error);
        }
        [self.documents addObject:doc];

        
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
    
}

@end
