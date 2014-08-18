//
//  SBNumPadPopoverConotroller.m
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/20/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "BSNumPadPopoverConotroller.h"

#import "BSNumPadViewController.h"

#if ! __has_feature(objc_arc)
    #warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface BSNumPadPopoverConotroller () <UITextFieldDelegate, UIPopoverControllerDelegate, BSNumPadViewControllerDelegate>

@property(nonatomic, strong) UITextField *textField;

@end


@implementation BSNumPadPopoverConotroller

@synthesize textField = _textField;

#pragma mark - Public methods

#pragma mark -Other

- (instancetype)initWithTextField:(UITextField *)textField andTextFieldFormat:(BSTextFieldFormat)textFieldFormat andNextKey:(BOOL)nextKeyExist nextButtonTitle:(NSString *)nextButtonTitle
{
    BOOL includeDecimalKey = (textFieldFormat == BSTextFieldFormatFloat);
    
    BSNumPadViewController *numPadViewController = [[BSNumPadViewController alloc] initWithTextField:textField andNextKey:nextKeyExist decimalKey:includeDecimalKey];
    numPadViewController.textFieldFormat = textFieldFormat;
    numPadViewController.delegate = self;
    [numPadViewController setNextButtonTitle:nextButtonTitle];
    
    self = [super initWithContentViewController:numPadViewController];
    if (self) {
        self.delegate = self;
        
        self.textField = textField;
    }
    return self;
}

- (void)setTextField:(UITextField *)inTextField
{
    if (_textField) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UITextFieldTextDidBeginEditingNotification
                                                      object:_textField];
    }

    _textField = inTextField;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEditing:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:_textField];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidBeginEditingNotification
                                                  object:self.textField];
}

- (void)dismissPopoverAnimated:(BOOL)animated onNextKeyPress:(BOOL)nextKeyPressed
{
    [super dismissPopoverAnimated:animated];
    
    [self popoverDidDisappearOnNextPress:nextKeyPressed];
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
    return [self isValidTextOnNextKeyPress:NO];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self popoverDidDisappearOnNextPress:NO];
}

#pragma mark -BSNumPadViewControllerDelegate

- (void)nextKeyPressed
{
    if ([self isValidTextOnNextKeyPress:YES]) {
        [self dismissPopoverAnimated:YES onNextKeyPress:YES];
    }
}

#pragma mark -Other

- (void)popoverDidDisappearOnNextPress:(BOOL)nextPressed
{
    [self.textField resignFirstResponder];
    
    if ([self.padDelegate respondsToSelector:@selector(popoverDidDisappearOnNextPress:)]) {
        [self.padDelegate popoverDidDisappearOnNextPress:nextPressed];
    }
}

- (BOOL)isValidTextOnNextKeyPress:(BOOL)nextPressed
{
    if ([self.padDelegate respondsToSelector:@selector(isValidTextFieldText:onNextKeyPress:)]) {
        return [self.padDelegate isValidTextFieldText:self.textField.text onNextKeyPress:nextPressed];
    }
    return YES;
}

@end