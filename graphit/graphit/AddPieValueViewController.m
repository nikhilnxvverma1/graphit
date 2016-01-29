//
//  AddPieValueViewController.m
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "AddPieValueViewController.h"

@interface AddPieValueViewController ()

@end

@implementation AddPieValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"submit"]) {
        NSLog(@"submitting entry");
    }else if ([[segue identifier] isEqualToString:@"dismiss"]) {
        NSLog(@"dismissing entry");
    }
}


//- (IBAction)dismiss:(UIStoryboardSegue*)unwindSegue{
//    NSLog(@"dimissing");
//}
//- (IBAction)submit:(UIStoryboardSegue*)unwindSegue{
//    NSLog(@"submittin");
//}

@end
