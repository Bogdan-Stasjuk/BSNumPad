BSNumPad
========

Numeric keyboard in UIPopoverController for UITextField inspired by [ZenKeyboard](https://github.com/nickevin/ZenKeyboard).

##BSNumPadPopoverConotroller public properties and methods

```objc
@property(nonatomic, weak) id<BSNumPadPopoverConotrollerDelegate> padDelegate;
@property(nonatomic, assign) BSPopoverPosition padPosition;

- (instancetype)initWithTextField:(UITextField *)textField andTextFieldFormat:(BSTextFieldFormat)textFieldFormat andNextKey:(BOOL)nextKeyExist nextButtonTitle:(NSString *)nextButtonTitle;
- (void)dismissPopoverAnimated:(BOOL)animated onNextKeyPress:(BOOL)nextKeyPressed;
```

There are following Popover positions and TextField formats:

```objc
typedef NS_ENUM(NSUInteger, BSPopoverPosition)
{
    BSPopoverPositionLeft,
    BSPopoverPositionTop,
    BSPopoverPositionRight,
    BSPopoverPositionBottom,
};

typedef NS_ENUM(Byte, BSTextFieldFormat)
{
    BSTextFieldFormatFloat,
    BSTextFieldFormatDate,
    BSTextFieldFormatInteger
};
```

__BSNumPadPopoverConotrollerDelegate__ protocol:

```objc
@optional
- (BOOL)isValidTextFieldText:(NSString *)text onNextKeyPress:(BOOL)nextPressed;
- (void)popoverWillAppear;
- (void)popoverDidDisappearOnNextPress:(BOOL)nextPressed;
```

`isValidTextFieldText:onNextKeyPress:` with result `TRUE` gives possibility to dismiss numpad view.


##Initialization

```objc
    self.numPadPopoverConotroller = [[BSNumPadPopoverConotroller alloc] initWithTextField:textField andTextFieldFormat:BSTextFieldFormatFloat andNextKey:YES nextButtonTitle:nil];
    self.numPadPopoverConotroller.padDelegate = self;
    self.numPadPopoverConotroller.padPosition = BSPopoverPositionBottom;
```

NumPad appears on `textFieldDidBeginEditing:` message.


##Numeric keyboard view: 
<img src="https://raw.githubusercontent.com/Bogdan-Stasjuk/BSNumPad/master/NumPadScreenShot.png" />

<img src="https://raw.githubusercontent.com/Bogdan-Stasjuk/BSNumPad/master/NumPadWithNextBtnScreenShot.png" />


Demo
====

Clone project and run it. You can find examples of usage at `BSTestViewController`.


Compatibility
=============

This class has been tested back to iOS 6.0.


Installation
============

__Cocoapods__: `pod 'BSNumPad'`<br />
__Manual__: Copy the __BSNumPad__ folder in your project<br />

Import header 

    #import "BSNumPadPopoverConotroller.h"


License
=======

This code is released under the MIT License. See the LICENSE file for
details.
