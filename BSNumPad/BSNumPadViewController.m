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

@property(strong, nonatomic) BSNumPadView           *keyboard;
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

- (id)initWithTextField:(UITextField *)textField andNextKey:(BOOL)nextKeyExist decimalKey:(BOOL)decimalKeyExist
{
    self = [super init];
    if (self) {
        self.textField = textField;
        self.textField.inputView = [self inputViewCap];
        
        self.digitCntBeforeDot = 6;
        self.digitCntAfterDot = 3;

        CGFloat preferredContentHeight = nextKeyExist ? 270.f : 215.f;
        self.preferredContentSize = CGSizeMake(320.f, preferredContentHeight);
        
        self.keyboard = [[BSNumPadView alloc] initWithNextButton:nextKeyExist decimalKey:decimalKeyExist];
        self.keyboard.delegate = self;
        self.view = self.keyboard;
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
        case BSTextFieldFormatInteger:
            [self keyPressedHandlerForNumber:key];
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
        case BSTextFieldFormatInteger:
            [self backspacePressedHandlerForNumber];
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

- (NSRange)rangeFromTextRange:(UITextRange *)textRange inTextInputView:(id<UITextInput>)textInputView {
    
    UITextPosition* beginning = textInputView.beginningOfDocument;
    UITextPosition* start = textRange.start;
    UITextPosition* end = textRange.end;
    
    const NSInteger location = [textInputView offsetFromPosition:beginning toPosition:start];
    const NSInteger length = [textInputView offsetFromPosition:start toPosition:end];
    
    return NSMakeRange(location, length);
}

- (void)insertTextIfValidated:(NSString *)text
{
    BOOL shouldInsert = YES;

    if ([self.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        NSRange selectedRange = [self rangeFromTextRange:self.textField.selectedTextRange
                                         inTextInputView:self.textField];
        shouldInsert = [self.textField.delegate textField:self.textField
                            shouldChangeCharactersInRange:selectedRange
                                        replacementString:text];
    }
    
    if (shouldInsert)
        [self.textField insertText:text];
}

- (void)keyPressedHandlerForNumber:(NSString *)key
{
    BOOL isDot = [key isEqualToString:Dot];
    NSRange dotRange = [_textField.text rangeOfString:Dot];
    
    if (isDot)
    {
        if (dotRange.location == NSNotFound && _textField.text.length == 0)
            [self insertTextIfValidated:[@"0" stringByAppendingString:Dot]];
        else if (dotRange.location == NSNotFound)
            [self insertTextIfValidated:Dot];
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
            [self insertTextIfValidated:key];
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
            [self insertTextIfValidated:key];
            break;
        case 1: {
            Byte firstDigit = _textField.text.integerValue;
            if (firstDigit == 3 && digit > 1) {
                return;
            }
            [self insertTextIfValidated:[key stringByAppendingString:DateDelimeter]];
        }
            break;
        case 2:
            if (digit > 1) {
                return;
            }
            [self insertTextIfValidated:[DateDelimeter stringByAppendingString:key]];
            break;
        case 3:
            if (digit > 1) {
                return;
            }
            [self insertTextIfValidated:key];
            break;
        case 4: {
            NSString *month = [_textField.text substringFromIndex:3];
            if (month.integerValue == 1 && digit > 2) {
                return;
            }
            [self insertTextIfValidated:[key stringByAppendingString:DateDelimeter]];
        }
            break;
        case 5: {
            if (digit != 2) {
                return;
            }
            [self insertTextIfValidated:[DateDelimeter stringByAppendingString:key]];
        }
            break;
        case 6: {
            if (digit != 2) {
                return;
            }
            [self insertTextIfValidated:key];
        }
            break;
        case 7: {
            [self insertTextIfValidated:key];
        }
            break;
        case 8: {
            [self insertTextIfValidated:key];
        }
            break;
        case 9: {
            [self insertTextIfValidated:[key stringByAppendingString:@" "]];
        }
            break;
        case 10: {
            if (digit > 2) {
                return;
            }
            [self insertTextIfValidated:[DateTimeDelimeter stringByAppendingString:key]];
        }
            break;
        case 11: {
            if (digit > 2) {
                return;
            }
            [self insertTextIfValidated:key];
        }
            break;
        case 12: {
            NSString *hours = [_textField.text substringFromIndex:11];
            if (hours.integerValue == 2 && digit > 3) {
                return;
            }
            [self insertTextIfValidated:[key stringByAppendingString:TimeDelimeter]];
        }
            break;
        case 13: {
            if (digit > 5) {
                return;
            }
            [self insertTextIfValidated:[TimeDelimeter stringByAppendingString:key]];
        }
            break;
        case 14: {
            if (digit > 5) {
                return;
            }
            [self insertTextIfValidated:key];
        }
            break;
        case 15: {
            [self insertTextIfValidated:key];
        }
            break;
            
        default:
            break;
    }
}

- (void)backspacePressedHandlerForNumber
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

- (void)setNextButtonTitle:(NSString *)inTitle
{
    self.keyboard.nextButtonTitle = inTitle;
}

@end