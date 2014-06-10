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

@property(nonatomic, weak) id<BSNumPadPopoverConotrollerDelegate> padDelegate;

@property(nonatomic, assign) BSPopoverPosition padPosition;

- (id)initWithTextField:(UITextField *)textField andTextFieldFormat:(BSTextFieldFormat)textFieldFormat;

#pragma mark -Unavailable methods

+ (id)new __attribute__((unavailable));
- (id)init __attribute__((unavailable));
- (id)initWithContentViewController:(UIViewController *)viewController __attribute__((unavailable));

@end


@protocol BSNumPadPopoverConotrollerDelegate <NSObject>

@optional
- (BOOL)isValidTextFieldText:(NSString *)text;
- (void)popoverWillAppear;
- (void)popoverDidDisappear;

@end