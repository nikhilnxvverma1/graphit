//
//  AddPieValueViewController.h
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"
#import "PieValue.h"
@interface AddPieValueViewController : UIViewController<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *value;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UICollectionView *colorPicker;
@property (weak, nonatomic) IBOutlet UIView *legendBox;
@property (strong,nonatomic) Color *selectedColor;
@property (strong,nonatomic) NSArray *colors;
@property BOOL editEntry;
//only keep a reference to the entry that we need to update.N.A if this is a new entry
@property (strong,nonatomic) PieValue *entryToUpdate;
- (IBAction)nameDidGetEdited:(UITextField *)sender;

- (IBAction)valueDidGetEdited:(UITextField *)sender;
-(BOOL)validInput;
@end
