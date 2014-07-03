//
//  SBNumPadViewController.m
//  SBNumericPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "BSNumPadViewController.h"

#import "BSNumPadView.h"


@interface BSNumPadViewController () <UITextFieldDelegate, SBNumPadViewDelegate>

@property(weak, nonatomic)      UITextField         *textField;
@property(assign, nonatomic) id<UITextInput>        textInputDelegate;

@end


@implementation BSNumPadViewController

static UIView *inputViewCap;

NSString * const Dot = @".";

NSString * const DateDelimeter = @"/";
NSString * const TimeDelimeter = @":";
NSString * const DateTimeDelimeter = @" ";


#pragma mark - Properties

#pragma mark -Public

- (void)setTextField:(UITextField *)textField
{
    _textField = textField;
    self.textInputDelegate = _textField;
}


#pragma mark - Public methods

- (id)initWithTextField:(UITextField *)textField andNextKey:(BOOL)nextKeyExist
{
    self = [super init];
    if (self) {
        self.textField = textField;
        self.textField.inputView = [self inputViewCap];
        
        self.digitCntBeforeDot = 6;
        self.digitCntAfterDot = 3;

        CGFloat preferredContentHeight = nextKeyExist ? 270.f : 215.f;
        self.preferredContentSize = CGSizeMake(320.f, preferredContentHeight);
        
        BSNumPadView *keyboard = [[BSNumPadView alloc] initWithNextButton:nextKeyExist];
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
    switch (self.textFieldFormat) {
        case BSTextFieldFormatFloat:
            [self keyPressedHandlerForFloat:key];
            break;
        case BSTextFieldFormatDate:
            [self keyPressedHandlerForDate:key];
            break;
            
        default:
            break;
    }
}

- (void)backspaceKeyDidPressed
{
    switch (self.textFieldFormat) {
        case BSTextFieldFormatFloat:
            [self backspacePressedHandlerForFloat];
            break;
        case BSTextFieldFormatDate:
            [self backspacePressedHandlerForDate];
            break;
            
        default:
            break;
    }
}

- (void)nextKeyPressed
{
    if ([self.delegate respondsToSelector:@selector(nextKeyPressed)]) {
        [self.delegate nextKeyPressed];
    }
}


#pragma mark -Other

- (UIView *)inputViewCap
{
    if (inputViewCap == nil) {
        inputViewCap = [UIView new];
        inputViewCap.backgroundColor = [UIColor clearColor];
    }
    return inputViewCap;
}

- (void)keyPressedHandlerForFloat:(NSString *)key
{
    BOOL isDot = [key isEqualToString:Dot];
    NSRange dotRange = [_textField.text rangeOfString:Dot];
    
    if (isDot)
    {
        if (dotRange.location == NSNotFound && _textField.text.length == 0)
            [self.textInputDelegate insertText:[@"0" stringByAppendingString:Dot]];
        else if (dotRange.location == NSNotFound)
            [self.textInputDelegate insertText:Dot];
    }
    else
    {
        NSArray *numberParts = [self.textField.text componentsSeparatedByString:Dot];
        
        NSString *decimalPart = (numberParts.count == 2) ? numberParts.lastObject : nil;
        if (decimalPart.length >= self.digitCntAfterDot)
            return;
        
        if (!decimalPart) {
            NSString *integralPart = numberParts.firstObject;
            if (integralPart.length >= self.digitCntBeforeDot)
                return;
        }
        
        
        if (dotRange.location == NSNotFound || _textField.text.length <= dotRange.location + self.digitCntAfterDot)
        {
            [self.textInputDelegate insertText:key];
        }
    }
}

- (void)keyPressedHandlerForDate:(NSString *)key
{
    if ([key isEqualToString:Dot]) {
        return;
    }
    Byte digit = key.integerValue;
    Byte textLength = _textField.text.length;
    switch (textLength) {
        case 0:
            if (digit > 3) {
                return;
            }
            [self.textInputDelegate insertText:key];
            break;
        case 1: {
            Byte firstDigit = _textField.text.integerValue;
            if (firstDigit == 3 && digit > 1) {
                return;
            }
            [self.textInputDelegate insertText:[key stringByAppendingString:DateDelimeter]];
        }
            break;
        case 2:
            if (digit > 1) {
                return;
            }
            [self.textInputDelegate insertText:[DateDelimeter stringByAppendingString:key]];
            break;
        case 3:
            if (digit > 1) {
                return;
            }
            [self.textInputDelegate insertText:key];
            break;
        case 4: {
            NSString *month = [_textField.text substringFromIndex:3];
            if (month.integerValue == 1 && digit > 2) {
                return;
            }
            [self.textInputDelegate insertText:[key stringByAppendingString:DateDelimeter]];
        }
            break;
        case 5: {
            if (digit != 2) {
                return;
            }
            [self.textInputDelegate insertText:[DateDelimeter stringByAppendingString:key]];
        }
            break;
        case 6: {
            if (digit != 2) {
                return;
            }
            [self.textInputDelegate insertText:key];
        }
            break;
        case 7: {
            [self.textInputDelegate insertText:key];
        }
            break;
        case 8: {
            [self.textInputDelegate insertText:key];
        }
            break;
        case 9: {
            [self.textInputDelegate insertText:[key stringByAppendingString:@" "]];
        }
            break;
        case 10: {
            if (digit > 2) {
                return;
            }
            [self.textInputDelegate insertText:[DateTimeDelimeter stringByAppendingString:key]];
        }
            break;
        case 11: {
            if (digit > 2) {
                return;
            }
            [self.textInputDelegate insertText:key];
        }
            break;
        case 12: {
            NSString *hours = [_textField.text substringFromIndex:11];
            if (hours.integerValue == 2 && digit > 3) {
                return;
            }
            [self.textInputDelegate insertText:[key stringByAppendingString:TimeDelimeter]];
        }
            break;
        case 13: {
            if (digit > 5) {
                return;
            }
            [self.textInputDelegate insertText:[TimeDelimeter stringByAppendingString:key]];
        }
            break;
        case 14: {
            if (digit > 5) {
                return;
            }
            [self.textInputDelegate insertText:key];
        }
            break;
        case 15: {
            [self.textInputDelegate insertText:key];
        }
            break;
            
        default:
            break;
    }
}

- (void)backspacePressedHandlerForFloat
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

- (void)backspacePressedHandlerForDate
{
    [self.textInputDelegate deleteBackward];
}

@end