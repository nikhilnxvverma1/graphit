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

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(PieChart*)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.header.text =[self.detailItem valueForKey:@"title"];
    }
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addPieValue"]) {
            NSLog(@"Came here to add entry");
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
}

-(void)backFromPieValue:(UIStoryboardSegue*)segue{
    if ([[segue identifier] isEqualToString:@"submit"]) {
        AddPieValueViewController* entry=(AddPieValueViewController*)segue.destinationViewController;
        NSString *name=entry.name.text;
        NSNumber *value=[NSNumber numberWithDouble:[entry.value.text doubleValue]];
        Color *color=entry.selectedColor;
        
        AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        NSManagedObject *legend = [NSEntityDescription insertNewObjectForEntityForName:@"Legend" inManagedObjectContext:delegate.managedObjectContext];
        NSManagedObject *pieValue = [NSEntityDescription insertNewObjectForEntityForName:@"PieValue" inManagedObjectContext:delegate.managedObjectContext];
        
        
        [legend setValue:name forKey:@"name"];
        [legend setValue:color forKey:@"legendColor"];
        
        [pieValue setValue:value forKey:@"value"];
        [pieValue setValue:[NSDate date] forKey:@"timestamp"];
        [pieValue setValue:legend forKey:@"legend"];
        [pieValue setValue:self.detailItem forKey:@"pieChart"];
        
        [delegate saveContext];
    }
    
}

#pragma mark - Legend table management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//TODO add button in second section?
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return 4;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cell selected at path %@",indexPath);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"LegendCell";
    PieValueTableViewCell *cell = (PieValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[PieValueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = @"Color";
    cell.rightUtilityButtons=[self editingOptions];
    cell.delegate=self;
    return cell;
}

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
    if(index==0) {
        NSLog(@"Handle edit");
    }else{
        NSLog(@"Handle delete");
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

@end
