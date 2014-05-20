//
//  SBNumPadViewController.h
//  SBNumericPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

@interface SBNumPadViewController : UIViewController

@property(nonatomic, assign) NSUInteger digitCntBeforeDot;
@property(nonatomic, assign) NSUInteger digitCntAfterDot;

- (id)initWithTextField:(UITextField *)textField;

#pragma mark - Unavailable methods

#pragma mark -NSObject

+ (id)new __attribute__((unavailable));

#pragma mark -UIViewController

- (id)init __attribute__((unavailable));
- (id)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable));
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil __attribute__((unavailable));

@end
