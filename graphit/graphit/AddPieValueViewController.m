//
//  AddPieValueViewController.m
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "AddPieValueViewController.h"
#import "ColorCollectionViewCell.h"

@interface AddPieValueViewController ()
@property (strong,nonatomic) UITextField *activeField;

//At any time , we will have only one instance of next and previous buttons registered.
//We track and keep reference of next and previous bar buttons so that they could be
//enabled/disabled at relevant events
@property (strong,nonatomic) UIBarButtonItem *prevButton;
@property (strong,nonatomic) UIBarButtonItem *nextButton;
@end

@implementation AddPieValueViewController
@synthesize activeField;
@synthesize nextButton;
@synthesize prevButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.colorPicker.delegate=self;
    self.colorPicker.dataSource=self;
    self.colorPicker.allowsSelection=YES;
    self.colorPicker.allowsMultipleSelection=NO;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"submit"]) {
        NSLog(@"submitting entry");
    }else if ([[segue identifier] isEqualToString:@"dismiss"]) {
        NSLog(@"dismissing entry");
    }
}

#pragma mark - Text handling

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    // Now add the view as an input accessory view to the selected textfield.
    [textField setInputAccessoryView:[self createAccessoryView]];
    
    // Set the active field. We' ll need that if we want to move properly
    // between our textfields.
    activeField = textField;
    if(activeField==self.name){
        [self.prevButton setEnabled:NO];
        [self.nextButton setEnabled:YES];
    }else{
        [self.prevButton setEnabled:YES];
        [self.nextButton setEnabled:NO];
    }
}


-(UIView*)createAccessoryView{
    UIToolbar *accessoryView=[[UIToolbar alloc] init];
    prevButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:101 target:nil action:@selector(goToPreviousField)]; // 101 is the < character
    nextButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:102 target:nil action:@selector(goToNextField)]; // 102 is the > character
    UIBarButtonItem *dismissKeyboard   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
    UIBarButtonItem *flexSpace   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [accessoryView setItems:[NSArray arrayWithObjects:prevButton,nextButton,flexSpace,dismissKeyboard,nil]];
    [accessoryView sizeToFit];
    return accessoryView;
}

-(void)dismissKeyboard{
    [activeField resignFirstResponder];
}

-(void)goToPreviousField{
    if(activeField==self.name){
        return;
    }else{
        [self.name becomeFirstResponder];
    }
}

-(void)goToNextField{
    if(activeField==self.value){
        return;
    }else{
        [self.value becomeFirstResponder];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)validInput{
    return [self.name hasText]&&[self.value hasText];
}

- (IBAction)nameDidGetEdited:(UITextField *)sender {
    [self.done setEnabled:[self validInput]];
}

- (IBAction)valueDidGetEdited:(UITextField *)sender {
    [self.done setEnabled:[self validInput]];
}

#pragma mark - Color picker

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"ColorCell";
    ColorCollectionViewCell *cell = (ColorCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:MyIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ColorCollectionViewCell alloc] init];
    }
    cell.r=0.5;
    cell.g=0.3;
    cell.b=0.8;
//    cell.delegate=self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ColorCollectionViewCell *cell=(ColorCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:153/255.0 alpha:1];
//
//    NSLog(@"Cell did get selected %@",indexPath);
//    [cell setNeedsDisplay];
//    cell.manualSelection=YES;
    cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:153/255.0 alpha:1];
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    ColorCollectionViewCell *cell=(ColorCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];

//    [cell setNeedsDisplay];
//    cell.manualSelection=NO;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
        ColorCollectionViewCell *cell=(ColorCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setNeedsDisplay];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
        ColorCollectionViewCell *cell=(ColorCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        [cell setNeedsDisplay];
}

@end
