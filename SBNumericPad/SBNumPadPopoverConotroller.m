//
//  SBNumPadPopoverConotroller.m
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/20/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "SBNumPadPopoverConotroller.h"

#import "SBNumPadViewController.h"


@interface SBNumPadPopoverConotroller () <UITextFieldDelegate, UIPopoverControllerDelegate>

@property(nonatomic, strong) UITextField *textField;

@end


@implementation SBNumPadPopoverConotroller

#pragma mark - Public methods

#pragma mark -UIPopoverController

- (void)dismissPopoverAnimated:(BOOL)animated
{
    [super dismissPopoverAnimated:animated];
    
    [self.textField resignFirstResponder];
}

#pragma mark -Other

- (id)initWithTextField:(UITextField *)textField
{
    SBNumPadViewController *numPadViewController = [[SBNumPadViewController alloc] initWithTextField:textField];
    self = [super initWithContentViewController:numPadViewController];
    if (self) {
        self.delegate = self;
        
        self.textField = textField;
        self.textField.delegate = self;

        self.popoverContentSize = CGSizeMake(320.f, 215.f);
    }
    return self;
}


#pragma mark - Private methods

#pragma mark -UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.padDelegate respondsToSelector:@selector(popoverWillAppear)]) {
        [self.padDelegate popoverWillAppear];
    }
    
    NSInteger padPosX = 0.f;
    NSInteger padPosY = 0.f;
    UIPopoverArrowDirection arrowDirection = UIPopoverArrowDirectionAny;
    switch (self.padPosition) {
        case SBNumPadPositionLeft:
            padPosY = self.textField.bounds.size.height / 2;
            arrowDirection = UIPopoverArrowDirectionRight;
            break;
        case SBNumPadPositionTop:
            padPosX = self.textField.bounds.size.width / 2;
            arrowDirection = UIPopoverArrowDirectionDown;
            break;
        case SBNumPadPositionRight:
            padPosX = self.textField.bounds.size.width;
            padPosY = self.textField.bounds.size.height / 2;
            arrowDirection = UIPopoverArrowDirectionLeft;
            break;
        case SBNumPadPositionBottom:
            padPosX = self.textField.bounds.size.width / 2;
            padPosY = self.textField.bounds.size.height;
            arrowDirection = UIPopoverArrowDirectionUp;
            break;
            
        default:
            break;
    }
    
    CGRect popoverFrame = CGRectMake(padPosX, padPosY, 1.f, 1.f);
    [self presentPopoverFromRect:popoverFrame inView:self.textField permittedArrowDirections:arrowDirection animated:YES];
}

#pragma mark -UIPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    if ([self.padDelegate respondsToSelector:@selector(isValidTextFieldText:)]) {
        return [self.padDelegate isValidTextFieldText:self.textField.text];
    }
    return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self.textField resignFirstResponder];
}

@end