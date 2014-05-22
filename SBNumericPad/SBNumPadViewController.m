//
//  SBNumPadViewController.m
//  SBNumericPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "SBNumPadViewController.h"

#import "SBNumPadView.h"


@interface SBNumPadViewController () <UITextFieldDelegate, SBNumPadViewDelegate>

@property(nonatomic, strong) UIPopoverController    *popover;
@property(nonatomic, weak)      UITextField         *textField;
@property (nonatomic,assign) id<UITextInput>        textInputDelegate;

@end


@implementation SBNumPadViewController

NSString * const dot = @".";

#pragma mark - Properties

#pragma mark -Public

- (void)setTextField:(UITextField *)textField
{
    _textField = textField;
    self.textInputDelegate = _textField;
}


#pragma mark - Public methods

- (id)initWithTextField:(UITextField *)textField
{
    self = [super init];
    if (self) {
        self.textField = textField;
        self.textField.inputView = [UIView new];
        
        self.digitCntBeforeDot = 6;
        self.digitCntAfterDot = 3;
        
        CGRect keyboardFrame = CGRectMake(0.f, 0.f, 100.f, 100.f);
        SBNumPadView *keyboard = [[SBNumPadView alloc] initWithFrame:keyboardFrame];
        keyboard.delegate = self;
        self.view = keyboard;
    }
    return self;
}


#pragma mark - Private methods

#pragma mark -UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -SBNumPadViewDelegate

- (void)keyPressed:(NSString *)key
{
    BOOL isDot = [@"." isEqualToString:key];
    NSRange dot = [_textField.text rangeOfString:@"."];
    
    if (isDot)
    {
        if (dot.location == NSNotFound && _textField.text.length == 0)
            [self.textInputDelegate insertText:@"0."];
        else if (dot.location == NSNotFound)
            [self.textInputDelegate insertText:@"."];
    }
    else
    {
        NSArray *numberParts = [self.textField.text componentsSeparatedByString:@"."];
        
        NSString *decimalPart = (numberParts.count == 2) ? numberParts.lastObject : nil;
        if (decimalPart.length >= self.digitCntAfterDot)
            return;

        if (!decimalPart) {
            NSString *integralPart = numberParts.firstObject;
            if (integralPart.length >= self.digitCntBeforeDot)
                return;
        }
        
        
        if (dot.location == NSNotFound || _textField.text.length <= dot.location + self.digitCntAfterDot)
        {
            [self.textInputDelegate insertText:key];
        }
    }
}

- (void)backspaceKeyDidPressed
{
    if ([@"0." isEqualToString:_textField.text])
    {
        _textField.text = @"";
        return;
    }
    else
    {
        [self.textInputDelegate deleteBackward];
    }
}

#pragma mark -Actions

- (void)btnPressed
{
    self.textField.text = [self.textField.text stringByAppendingString:@"+"];
}

@end