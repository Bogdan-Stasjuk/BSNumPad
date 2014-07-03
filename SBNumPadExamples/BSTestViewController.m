//
//  SBTestViewController.m
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/13/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "BSTestViewController.h"

#import "BSNumPadPopoverConotroller.h"


@interface BSTestViewController () <BSNumPadPopoverConotrollerDelegate, UITextFieldDelegate>

@property(nonatomic, strong) BSNumPadPopoverConotroller *numPadPopoverConotroller;

@end


@implementation BSTestViewController

#pragma mark - Private methods

#pragma mark -Static


+ (CGFloat)screenWidth
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    return orientation == UIDeviceOrientationPortrait ? [[UIScreen mainScreen] bounds].size.width
    : [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenHeight
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    return orientation == UIDeviceOrientationPortrait ? [[UIScreen mainScreen] bounds].size.height
    : [[UIScreen mainScreen] bounds].size.width;
}

#pragma mark -Nonstatic

#pragma mark --UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UITextField *textField = [self setupTextField];

    /*
     * Variant 1
     */
//    self.numPadPopoverConotroller = [[BSNumPadPopoverConotroller alloc] initWithTextField:textField andTextFieldFormat:BSTextFieldFormatDate];
//    self.numPadPopoverConotroller.padDelegate = self;
//    self.numPadPopoverConotroller.padPosition = BSPopoverPositionBottom;

    
    /*
     * Variant 2
     */
    textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.numPadPopoverConotroller = [[BSNumPadPopoverConotroller alloc] initWithTextField:textField andTextFieldFormat:BSTextFieldFormatFloat andNextKey:YES];
    self.numPadPopoverConotroller.padDelegate = self;
    self.numPadPopoverConotroller.padPosition = BSPopoverPositionBottom;
    
    return YES;
}

#pragma mark --SBNumPadPopoverConotrollerDelegate

- (void)popoverWillAppear
{
//    [[[UIAlertView alloc] initWithTitle:@"Info" message:@"Popover will appear" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (BOOL)isValidTextFieldText:(NSString *)text onNextKeyPress:(BOOL)nextPressed
{
    return YES;
}

- (void)popoverDidDisappearOnNextPress:(BOOL)nextPressed
{
//    [[[UIAlertView alloc] initWithTitle:@"Info" message:@"Popover did disappear" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

#pragma mark --Other

- (UITextField *)setupTextField
{
    CGFloat textFieldWidth = 200.f;
    CGFloat textFieldHeight = 30.f;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width - textFieldWidth) / 2,
                                                                           (self.view.frame.size.height - textFieldHeight) / 2,
                                                                           textFieldWidth,
                                                                           textFieldHeight)];
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textField];
    
    return textField;
}

@end