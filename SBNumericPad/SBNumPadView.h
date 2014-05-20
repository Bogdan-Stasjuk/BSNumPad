//
//  SBNumPadView.h
//  SBNumericPad
//
//  Created by Bogdan Stasjuk on 5/14/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

@protocol SBNumPadViewDelegate;


@interface SBNumPadView : UIView

@property(nonatomic, weak) id<SBNumPadViewDelegate> delegate;

#pragma mark - Unavailable methods
#pragma mark -NSObject

+ (id)new __attribute__((unavailable));

#pragma mark -UIView

- (id)init __attribute__((unavailable));
- (id)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable));

@end


@protocol SBNumPadViewDelegate <NSObject>

@required
- (void)keyPressed:(NSString *)key;
- (void)backspaceKeyDidPressed;

@end