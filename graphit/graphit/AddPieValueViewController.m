//
//  AddPieValueViewController.m
//  graphit
//
//  Created by Nikhil Verma on 29/01/16.
//  Copyright © 2016 Nikhil Verma. All rights reserved.
//

#import "AddPieValueViewController.h"

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
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects:flexibleSpace, doneButton, nil]];
//    [keyboardToolbar addSubview:segmentedControl];
    [self.name setInputAccessoryView:keyboardToolbar];
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

@end
