//
//  DetailViewController.h
//  graphit
//
//  Created by Nikhil Verma on 28/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"
#import "SWTableViewCell.h"
#import "PieChart.h"

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate,UITextFieldDelegate,NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) PieChart *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;
@property (weak, nonatomic) IBOutlet UITableView *legendTable;
@property (weak, nonatomic) IBOutlet UITextField *header;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
- (IBAction)didEditHeader:(UITextField *)sender;
-(IBAction)backFromPieValue:(UIStoryboardSegue*)segue;
@end

