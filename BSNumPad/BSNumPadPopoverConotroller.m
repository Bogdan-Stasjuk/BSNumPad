//
//  SBNumPadPopoverConotroller.m
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/20/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "BSNumPadPopoverConotroller.h"

#import "BSNumPadViewController.h"


@interface BSNumPadPopoverConotroller () <UITextFieldDelegate, UIPopoverControllerDelegate>

@property(nonatomic, strong) UITextField *textField;

@end


@implementation BSNumPadPopoverConotroller

#pragma mark - Public methods

#pragma mark -UIPopoverController

- (void)dismissPopoverAnimated:(BOOL)animated
{
    [super dismissPopoverAnimated:animated];
    
    [self popoverDidDisappear];
}

#pragma mark -Other

- (id)initWithTextField:(UITextField *)textField andTextFieldFormat:(BSTextFieldFormat)textFieldFormat
{
    BSNumPadViewController *numPadViewController = [[BSNumPadViewController alloc] initWithTextField:textField];
    numPadViewController.textFieldFormat = textFieldFormat;
    self = [super initWithContentViewController:numPadViewController];
    if (self) {
        self.delegate = self;
        
        self.textField = textField;
        self.textField.delegate = self;
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
        case BSPopoverPositionLeft:
            padPosY = self.textField.bounds.size.height / 2;
            arrowDirection = UIPopoverArrowDirectionRight;
            break;
        case BSPopoverPositionTop:
            padPosX = self.textField.bounds.size.width / 2;
            arrowDirection = UIPopoverArrowDirectionDown;
            break;
        case BSPopoverPositionRight:
            padPosX = self.textField.bounds.size.width;
            padPosY = self.textField.bounds.size.height / 2;
            arrowDirection = UIPopoverArrowDirectionLeft;
            break;
        case BSPopoverPositionBottom:
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
    [self popoverDidDisappear];
}

#pragma mark -Other

- (void)popoverDidDisappear
{
    [self.textField resignFirstResponder];
    
    if ([self.padDelegate respondsToSelector:@selector(popoverDidDisappear)]) {
        [self.padDelegate popoverDidDisappear];
    }
}

@end