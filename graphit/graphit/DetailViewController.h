//
//  DetailViewController.h
//  graphit
//
//  Created by Nikhil Verma on 28/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;

- (IBAction)dismiss:(UIStoryboardSegue*)unwindSegue;
- (IBAction)submit:(UIStoryboardSegue*)unwindSegue;
@end

