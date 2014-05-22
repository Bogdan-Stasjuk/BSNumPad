//
//  SBNumPadPopoverConotroller.h
//  SBNumericPadExamples
//
//  Created by Bogdan Stasjuk on 5/20/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

@protocol SBNumPadPopoverConotrollerDelegate;


typedef NS_ENUM(NSUInteger, SBNumPadPosition)
{
    SBNumPadPositionLeft,
    SBNumPadPositionTop,
    SBNumPadPositionRight,
    SBNumPadPositionBottom,
};


@interface SBNumPadPopoverConotroller : UIPopoverController

@property(nonatomic, weak) id<SBNumPadPopoverConotrollerDelegate> padDelegate;

@property(nonatomic, assign) SBNumPadPosition padPosition;

- (id)initWithTextField:(UITextField *)textField;

#pragma mark -Unavailable methods
+ (id)new __attribute__((unavailable));
- (id)init __attribute__((unavailable));
- (id)initWithContentViewController:(UIViewController *)viewController __attribute__((unavailable));

@end


@protocol SBNumPadPopoverConotrollerDelegate <NSObject>

@optional
- (BOOL)isValidTextFieldText:(NSString *)text;
- (void)popoverWillAppear;
- (void)popoverDidDisappear;

@end