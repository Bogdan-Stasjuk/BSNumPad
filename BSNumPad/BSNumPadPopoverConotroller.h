//
//  SBNumPadPopoverConotroller.h
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/20/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "BSNumPad.h"


@protocol BSNumPadPopoverConotrollerDelegate;


@interface BSNumPadPopoverConotroller : UIPopoverController

@property(weak, nonatomic) id<BSNumPadPopoverConotrollerDelegate> padDelegate;

@property(assign, nonatomic) BSPopoverPosition padPosition;

/* Pass nil for nextButtonTitle to use the default, "NEXT" */
- (instancetype)initWithTextField:(UITextField *)textField andTextFieldFormat:(BSTextFieldFormat)textFieldFormat andNextKey:(BOOL)nextKeyExist nextButtonTitle:(NSString *)nextButtonTitle;

- (void)dismissPopoverAnimated:(BOOL)animated onNextKeyPress:(BOOL)nextKeyPressed;


#pragma mark -Unavailable methods

+ (id)new __attribute__((unavailable));
- (id)init __attribute__((unavailable));
- (id)initWithContentViewController:(UIViewController *)viewController __attribute__((unavailable));

- (void)dismissPopoverAnimated:(BOOL)animated __attribute__((unavailable));

@end


@protocol BSNumPadPopoverConotrollerDelegate <NSObject>

@optional
- (BOOL)isValidTextFieldText:(NSString *)text onNextKeyPress:(BOOL)nextPressed;
- (void)popoverWillAppear;
- (void)popoverDidDisappearOnNextPress:(BOOL)nextPressed;

@end