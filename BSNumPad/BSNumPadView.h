//
//  BSNumPadView.h
//  BSNumPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

@protocol SBNumPadViewDelegate;


@interface BSNumPadView : UIView

@property(weak, nonatomic) id<SBNumPadViewDelegate> delegate;


- (instancetype)initWithNextButton:(BOOL)nextButtonExist decimalKey:(BOOL)decimalKeyExist;
@property (nonatomic, strong) NSString *nextButtonTitle;

#pragma mark - Unavailable methods

#pragma mark -NSObject

+ (id)new __attribute__((unavailable));

#pragma mark -UIView

- (instancetype)init __attribute__((unavailable));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable));

@end


@protocol SBNumPadViewDelegate <NSObject>

@required
- (void)keyPressed:(NSString *)key;
- (void)backspaceKeyDidPressed;

@optional
- (void)nextKeyPressed;

@end