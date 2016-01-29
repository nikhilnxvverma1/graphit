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

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;
@property (weak, nonatomic) IBOutlet UITableView *legendTable;
-(IBAction)backFromPieValue:(UIStoryboardSegue*)segue;
@end

