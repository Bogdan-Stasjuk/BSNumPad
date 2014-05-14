//
//  SBTestViewController.m
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/13/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "SBTestViewController.h"

#import "SBNumPadViewController.h"


@interface SBTestViewController ()

//@property(nonatomic, strong) UIPopoverController *popover;
@property(nonatomic, strong) SBNumPadViewController *numPadViewController;

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
    self.numPadViewController = [[SBNumPadViewController alloc] initWithTextField:textField];
//    [self showPopoverFromView:textField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --Other

- (UITextField *)setupTextField
{
    CGRect textFieldFrame = CGRectMake(10.f, [[self class] screenHeight] / 2.f, [[self class] screenWidth] / 2.f, 25.f);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.inputView = [UIView new];

    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor redColor]CGColor];
    textField.layer.borderWidth= 1.0f;
    
    [self.view addSubview:textField];
    
    return textField;
}

//- (void)showPopoverFromView:(UIView *)view
//{
//    UIViewController *contentController = [UIViewController new];
//    self.popover = [[UIPopoverController alloc] initWithContentViewController:contentController];
//
//    CGRect popoverFrame = CGRectMake(0.f, 0.f, 100.f, 100.f);
//    [self.popover presentPopoverFromRect:popoverFrame inView:view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//}

@end