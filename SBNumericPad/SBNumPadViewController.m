//
//  SBNumPadViewController.m
//  SBNumericPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "SBNumPadViewController.h"


@interface SBNumPadViewController () <UITextFieldDelegate>

@property(nonatomic, strong) UIPopoverController *popover;
@property(nonatomic, weak)      UITextField         *textField;

@end


@implementation SBNumPadViewController

#pragma mark - Public methods

- (id)initWithTextField:(UITextField *)textField
{
    self = [super init];
    if (self) {
        self.textField = textField;
        self.textField.delegate = self;
    }
    return self;
}


#pragma mark - Private methods

#pragma mark -UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50.f, 40.f, 40.f, 50.f)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"normal" forState:UIControlStateNormal];
    [btn setTitle:@"pressed" forState:UIControlStateSelected];
    [btn setTitle:@"pressed" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showPopoverFromView:textField];
}

#pragma mark -Actions

- (void)btnPressed
{
    self.textField.text = [self.textField.text stringByAppendingString:@"+"];
}

#pragma mark -Other

- (void)showPopoverFromView:(UIView *)view
{
    self.popover = [[UIPopoverController alloc] initWithContentViewController:self];
    
    CGRect popoverFrame = CGRectMake(view.bounds.size.width - 100.f, view.bounds.size.height / 2 - 50.f, 100.f, 100.f /*420.f, -40.f, 100.f, 100.f*/);
    [self.popover presentPopoverFromRect:popoverFrame inView:view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

@end