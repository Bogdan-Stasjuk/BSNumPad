//
//  BSNumPadView.m
//  BSNumPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "BSNumPadView.h"

#import "UIImage+Helpers.h"


#define KEYBOARD_NUMERIC_KEY_WIDTH 108
#define KEYBOARD_NUMERIC_KEY_HEIGHT 53

#define RGB(r, g, b)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define FONT_SIZE_SMALL 12.0f
#define FONT_SIZE_NORMAL 14.0f
#define FONT_SIZE_MEDIUM 15.0f
#define FONT_SIZE_LARGE 16.0f

#define HEITI_SC_LIGHT @"STHeitiSC-Light"
#define HEITI_SC_MEDIUM @"STHeitiSC-Medium"

#define FONT_SIZE_NORMAL_HEIGHT 16.0f
#define FONT_SIZE_MEDIUM_HEIGHT 17.0f


@interface BSNumPadView()


@end


@implementation BSNumPadView

#pragma mark - Public methods

#pragma mark -UIView

- (instancetype)initWithNextButton:(BOOL)nextButtonExist
{
    self = [super init];
    if (self) {
        self.autoresizesSubviews = YES;
        self.clipsToBounds = YES;
        [self addSubviewsWithNextButton:nextButtonExist];
    }
    return self;
}


#pragma mark - Private methods

#pragma mark -Actions

- (void)pressNumericKey:(UIButton *)button
{
    NSString *keyText = button.titleLabel.text;
    
    if ([self.delegate respondsToSelector:@selector(keyPressed:)])
        [self.delegate keyPressed:keyText];
}

- (void)pressBackspaceKey
{
    if ([self.delegate respondsToSelector:@selector(backspaceKeyDidPressed)])
    {
        [self.delegate backspaceKeyDidPressed];
    }
}

- (void)pressNextKey
{
    if ([self.delegate respondsToSelector:@selector(nextKeyPressed)])
    {
        [self.delegate nextKeyPressed];
    }
}

#pragma mark -Other

- (void)addSubviewsWithNextButton:(BOOL)nextButtonExist
{
    UIImageView *keyboardBackground = [[UIImageView alloc] initWithImage:[self imageForResource:@"KeyboardBackgroundTextured"]];
    UIImageView *keyboardGridLines = [[UIImageView alloc] initWithImage:[self imageForResource:@"KeyboardNumericEntryViewGridLinesTextured"]];
    [self addSubview:keyboardBackground];
    [self addSubview:keyboardGridLines];
    
    [self addSubview:[self addNumericKeyWithTitle:@"1" frame:CGRectMake(0, 1, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addNumericKeyWithTitle:@"2" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, 1, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addNumericKeyWithTitle:@"3" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, 1, KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    
    [self addSubview:[self addNumericKeyWithTitle:@"4" frame:CGRectMake(0, KEYBOARD_NUMERIC_KEY_HEIGHT + 2, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addNumericKeyWithTitle:@"5" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT + 2, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addNumericKeyWithTitle:@"6" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, KEYBOARD_NUMERIC_KEY_HEIGHT + 2, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    
    [self addSubview:[self addNumericKeyWithTitle:@"7" frame:CGRectMake(0, KEYBOARD_NUMERIC_KEY_HEIGHT * 2 + 3, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addNumericKeyWithTitle:@"8" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT * 2 + 3, KEYBOARD_NUMERIC_KEY_WIDTH , KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addNumericKeyWithTitle:@"9" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, KEYBOARD_NUMERIC_KEY_HEIGHT * 2 + 3, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    
    [self addSubview:[self addNumericKeyWithTitle:@"." frame:CGRectMake(0, KEYBOARD_NUMERIC_KEY_HEIGHT * 3 + 4, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addNumericKeyWithTitle:@"0" frame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH - 2, KEYBOARD_NUMERIC_KEY_HEIGHT * 3 + 4, KEYBOARD_NUMERIC_KEY_WIDTH, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    [self addSubview:[self addBackspaceKeyWithFrame:CGRectMake(KEYBOARD_NUMERIC_KEY_WIDTH * 2 - 1, KEYBOARD_NUMERIC_KEY_HEIGHT * 3 + 4, KEYBOARD_NUMERIC_KEY_WIDTH - 3, KEYBOARD_NUMERIC_KEY_HEIGHT)]];
    
    if (nextButtonExist) {
        UIButton *btnNext = [self addKeyWithTitle:@"NEXT" frame:CGRectMake(0.f, KEYBOARD_NUMERIC_KEY_HEIGHT * 4 + 5, KEYBOARD_NUMERIC_KEY_WIDTH * 3,  KEYBOARD_NUMERIC_KEY_HEIGHT) action:@selector(pressNextKey)];
        btnNext.backgroundColor = [UIColor grayColor];
        [self addSubview:btnNext];
    }
}

- (UIButton *)addNumericKeyWithTitle:(NSString *)title frame:(CGRect)frame
{
    return [self addKeyWithTitle:title frame:frame action:@selector(pressNumericKey:)];
}

- (UIButton *)addKeyWithTitle:(NSString *)title frame:(CGRect)frame action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:28.0]];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -0.5)];
    
    UIImage *buttonImage = [self imageForResource:@"KeyboardNumericEntryKeyTextured"];
    UIImage *buttonPressedImage = [self imageForResource:@"KeyboardNumericEntryKeyPressedTextured"];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIButton *)addBackspaceKeyWithFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    UIImage *buttonImage = [self imageForResource:@"KeyboardNumericEntryKeyTextured"];
    UIImage *buttonPressedImage = [self imageForResource:@"KeyboardNumericEntryKeyPressedTextured"];
    UIImage *image = [self imageForResource:@"KeyboardNumericEntryKeyBackspaceGlyphTextured"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((buttonImage.size.width - image.size.width) / 2, (buttonImage.size.height - image.size.height) / 2, image.size.width, image.size.height)];
    imgView.image = image;
    [button addSubview:imgView];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(pressBackspaceKey) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (UIImage *)imageForResource:(NSString *)imageRes
{
    UIImage *image = [UIImage imageNamed:imageRes];
    if (image) {
        return [image scale:0.5f];
    }
    
    NSString *imageResPath = [@"Images.bundle/" stringByAppendingString:imageRes];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageResPath withExtension:@"png"];
    NSData *imgData = [NSData dataWithContentsOfURL:url];

    return [UIImage imageWithData:imgData scale:2.f];
}

@end