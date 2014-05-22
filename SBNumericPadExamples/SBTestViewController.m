//
//  SBTestViewController.m
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/13/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "SBTestViewController.h"

#import "SBNumPadPopoverConotroller.h"


@interface SBTestViewController () <SBNumPadPopoverConotrollerDelegate>

@property(nonatomic, strong) SBNumPadPopoverConotroller *numPadPopoverConotroller;

@end


@implementation SBTestViewController

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
    self.numPadPopoverConotroller = [[SBNumPadPopoverConotroller alloc] initWithTextField:textField];
    self.numPadPopoverConotroller.padPosition = SBNumPadPositionBottom;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --SBNumPadPopoverConotrollerDelegate

- (BOOL)isValidTextFieldText:(NSString *)text
{
    return YES;
}

#pragma mark --Other

- (UITextField *)setupTextField
{
    CGRect textFieldFrame = CGRectMake([[self class] screenWidth] / 2.f - 50.f, [[self class] screenHeight] / 2.f, 100.f, 25.f);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];

    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor redColor]CGColor];
    textField.layer.borderWidth= 1.0f;
    
    [self.view addSubview:textField];
    
    return textField;
}

@end