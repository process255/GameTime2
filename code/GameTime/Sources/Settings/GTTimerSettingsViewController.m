//
//  GTTimerSettingsViewController.m
//  GameTime
//
//  Created by Sean Dougherty on 1/17/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimerSettingsViewController.h"
#import "InfColorPicker.h"
#import "GTPreferences.h"
#import "GTTimer.h"
#import "GTPlayerColor.h"


@interface GTTimerSettingsViewController ()<InfColorPickerControllerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *timerNameTextField;

@end


@implementation GTTimerSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.timer.name;
    self.timerNameTextField.text = self.timer.name;
    self.timerNameTextField.delegate = self;
    [self.timerNameTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textFieldDidChange:(NSNotification *)note
{
    self.timer.name = self.timerNameTextField.text;
    self.title = self.timer.name;
}


#pragma mark - UITextFieldDelegate

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    self.timer.name = textField.text;
//    self.title = textField.text;
//}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
//    self.timer.name = [textField.text stringByAppendingString:string];
//    self.title = self.timer.name;
    return YES;
}

@end
