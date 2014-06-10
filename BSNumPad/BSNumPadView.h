//
//  SBNumPadView.h
//  SBNumericPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

@protocol SBNumPadViewDelegate;


@interface BSNumPadView : UIView

@property(nonatomic, weak) id<SBNumPadViewDelegate> delegate;

#pragma mark - Unavailable methods

#pragma mark -UIView

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable));

@end


@protocol SBNumPadViewDelegate <NSObject>

@required
- (void)keyPressed:(NSString *)key;
- (void)backspaceKeyDidPressed;

@end