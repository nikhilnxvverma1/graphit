//
//  DetailViewController.m
//  graphit
//
//  Created by Nikhil Verma on 28/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "DetailViewController.h"
#import "PieValueTableViewCell.h"
#import "AppDelegate.h"
#import "AddPieValueViewController.h"
#import "PieValue.h"
#import "Legend.h"

@interface DetailViewController ()
@property PieChartDocument *document;
@end

@implementation DetailViewController
@synthesize document;

#pragma mark - Managing the detail item

- (void)setDetailItem:(PieChart*)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
        
        //set the document
        [self setPieChartDocument];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.header.text =[self.detailItem valueForKey:@"title"];
    }
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.pieChartView.pieValueDescription=self.detailDescriptionLabel;
    self.legendTable.delegate=self;
    self.legendTable.dataSource=self;

//    self.header.delegate=self;
    [self.header addTarget:self
                    action:@selector(dismissKeyboard:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [self stringFromModel:self.detailItem];
    [self.pieChartView setModel:self.detailItem];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)configurePieValueScreen:(AddPieValueViewController*)addPie editExitingEntry:(BOOL)edit{
    //get a list of colors
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Color" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *allColors = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        //TODO filter out colors that are already used up
        addPie.colors=allColors;
        addPie.editEntry=edit;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addPieValue"]) {
        [self configurePieValueScreen:(AddPieValueViewController*)segue.destinationViewController editExitingEntry:NO];
        
    }
}

#pragma mark - Callback for add pie value

-(void)dismissKeyboard:(UITextField*)textfield{
    [textfield resignFirstResponder];
}

- (IBAction)didEditHeader:(UITextField *)sender {

    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [self.detailItem setValue:sender.text forKey:@"title"];
    [delegate saveContext];
    //we will modify the document and save it to iCloud
    [self updateDocument];
}

-(void)backFromPieValue:(UIStoryboardSegue*)segue{
    if ([[segue identifier] isEqualToString:@"submit"]) {
        AddPieValueViewController* entry=(AddPieValueViewController*)segue.sourceViewController;
        NSString *name=entry.name.text;
        NSNumber *value=[NSNumber numberWithDouble:[entry.value.text doubleValue]];
        Color *color=entry.selectedColor;
        
        AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        NSManagedObject *legend;
        NSManagedObject *pieValue;
        
        if(entry.editEntry){
            pieValue=entry.entryToUpdate;
            legend=entry.entryToUpdate.legend;
        }else{
            legend = [NSEntityDescription insertNewObjectForEntityForName:@"Legend" inManagedObjectContext:delegate.managedObjectContext];
            pieValue = [NSEntityDescription insertNewObjectForEntityForName:@"PieValue" inManagedObjectContext:delegate.managedObjectContext];
        }
        
        
        [legend setValue:name forKey:@"name"];
        [legend setValue:color forKey:@"legendColor"];
        
        [pieValue setValue:value forKey:@"value"];
        [pieValue setValue:[NSDate date] forKey:@"timestamp"];
        [pieValue setValue:legend forKey:@"legend"];
        [pieValue setValue:self.detailItem forKey:@"pieChart"];
        
        [delegate saveContext];
        //we will modify the document and save it to iCloud
        [self updateDocument];
    }
    [self.pieChartView setNeedsDisplay];
}

- (IBAction)selectAllText:(UITextField *)sender {
    //we are providing the clear button
//    [sender selectAll:self];
}

#pragma mark - Legend table management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cell selected at path %@",indexPath);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"LegendCell";
    PieValueTableViewCell *cell = (PieValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[PieValueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(PieValueTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    PieValue *object = (PieValue*)[self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = [[object valueForKey:@"legend.name"] description];
    cell.textLabel.text = object.legend.name;
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), YES, 0.0);
//    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"white_square.png"];
    cell.imageView.image=[cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    Color *color=object.legend.legendColor;
    cell.imageView.tintColor=[UIColor colorWithRed:[color.red floatValue] green:[color.green floatValue] blue:[color.blue floatValue] alpha:[color.alpha floatValue]];

    cell.rightUtilityButtons=[self editingOptions];
    cell.delegate=self;

}

#pragma mark - Slider buttons

-(NSArray *) editingOptions{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons addObject:[self createSideButton:[UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0] title:@"Edit"]];
    
    [rightUtilityButtons addObject:[self createSideButton:[UIColor colorWithRed:1.0f green:.231f blue:0.188f alpha:1.0] title:@"Delete"]];
    
    return rightUtilityButtons;
}

-(UIButton*)createSideButton:(UIColor*)color title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    return button;
}

// click event on left utility button
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    
}

// click event on right utility button
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
    //important: index refers to index of the button on the left side from the slider drawer
    NSIndexPath *indexPath=[self.legendTable indexPathForCell:cell];
    PieValue *object = (PieValue*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    if(index==0) {

        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        AddPieValueViewController * editPieValue = (AddPieValueViewController*)[storyboard instantiateViewControllerWithIdentifier:@"PieValueEntry"];

        [self configurePieValueScreen:editPieValue editExitingEntry:YES];
        [self presentViewController:editPieValue animated:YES completion:nil];
        
        //views are nil untill we call presentViewController
        editPieValue.entryToUpdate=object;
        editPieValue.editEntry=YES;
        editPieValue.name.text=object.legend.name;
        editPieValue.value.text=[object.value stringValue];
        editPieValue.selectedColor=object.legend.legendColor;
        [editPieValue.done setEnabled:[editPieValue validInput]];
    }else{
        AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        [delegate.managedObjectContext deleteObject:object];
        [self.pieChartView setNeedsDisplay];
        //we will modify the document and save it to iCloud
        [self updateDocument];
    }
}

// utility button open/close event
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state{
    
}

// prevent multiple cells from showing utilty buttons simultaneously
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    return YES;
}

// prevent cell(s) from displaying left/right utility buttons
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state{
    return YES;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PieValue" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"PieValues"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.legendTable beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.legendTable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.legendTable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.legendTable;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.legendTable insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.legendTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.legendTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.legendTable insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.legendTable endUpdates];
}

#pragma mark - iCloud documents

-(void)setPieChartDocument{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd_hhmmss"];
    
    NSString *fileName = [NSString stringWithFormat:@"PieChart_%@",
                          [formatter stringFromDate:self.detailItem.timeStamp]];
    
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    if (ubiq) {
        
        self.query = [[NSMetadataQuery alloc] init];
        [self.query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
        NSString *predicateFormat=[NSString stringWithFormat:@"%%K like '%@'",fileName];
        NSLog(@"Predicate format is %@",predicateFormat);
        NSPredicate *pred = [NSPredicate predicateWithFormat: predicateFormat, NSMetadataItemFSNameKey];
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
    
    [self setDocumentDataFromQuery:query];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSMetadataQueryDidFinishGatheringNotification
                                                  object:query];
    
    self.query = nil;
    
}

- (void)setDocumentDataFromQuery:(NSMetadataQuery *)query {
    
    //    [self.notes removeAllObjects];
    
    for (NSMetadataItem *item in [query results]) {
        
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        self.document= [[PieChartDocument alloc] initWithFileURL:url];
        NSLog(@"File from iCloud which set the document: %@",url);
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

-(NSString*)stringFromModel:(PieChart*) model{
    NSMutableString *string=[[NSMutableString alloc] initWithCapacity:500];
    [string appendString:[NSString stringWithFormat:@"%@\n",model.title]];
    [string appendString:[NSString stringWithFormat:@"\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\n",@"r",@"g",@"b",@"a",@"name",@"value"]];
    
    for(PieValue *pieValue in model.pieValues){
        [string appendString:[NSString stringWithFormat:@"\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\n",pieValue.legend.legendColor.red,pieValue.legend.legendColor.green,pieValue.legend.legendColor.blue,pieValue.legend.legendColor.alpha,pieValue.legend.name,pieValue.value]];
    }
    NSLog(@"%@",string);
    return string;
}

-(void)updateDocument{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.document.noteContent = [self stringFromModel:self.detailItem];
//        [self.document updateChangeCount:UIDocumentChangeDone];
////        [doc updateChangeCount:UIDocumentChangeDone];
//    });

    self.document.noteContent = [self stringFromModel:self.detailItem];
    [self.document updateChangeCount:UIDocumentChangeDone];
}

@end
