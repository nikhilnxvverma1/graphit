//
//  AddPieValueViewController.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPieValueViewController : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *value;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UICollectionView *colorPicker;

- (IBAction)nameDidGetEdited:(UITextField *)sender;

- (IBAction)valueDidGetEdited:(UITextField *)sender;

@end
