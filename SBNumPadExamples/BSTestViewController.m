//
//  SBTestViewController.m
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/13/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "BSTestViewController.h"

#import "BSNumPadPopoverConotroller.h"


@interface BSTestViewController () <BSNumPadPopoverConotrollerDelegate>

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
    self.numPadPopoverConotroller = [[BSNumPadPopoverConotroller alloc] initWithTextField:textField];
    self.numPadPopoverConotroller.padDelegate = self;
    self.numPadPopoverConotroller.padPosition = BSNumPadPositionBottom;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --SBNumPadPopoverConotrollerDelegate

- (void)popoverWillAppear
{
    [[[UIAlertView alloc] initWithTitle:@"Info" message:@"Popover will appear" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (BOOL)isValidTextFieldText:(NSString *)text
{
    return YES;
}

- (void)popoverDidDisappear
{
    [[[UIAlertView alloc] initWithTitle:@"Info" message:@"Popover did disappear" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
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