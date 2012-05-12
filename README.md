# JLButtonScroller
> Author: Joshua Lay


## What is this?

A very simple implementation to set the content area of a scroll view with buttons from a given data source.

## Is it useful?

It is to me.. but probably not for you. This is the first time I've written a protocol before so it may be bad.


# JLButtonScrollerDelegate

    @protocol JLButtonScrollerDelegate <NSObject>
    @required

    - (UIFont *)fontForButton;
    // In order to work out the button size we need to know the font it will be using for the text label

    - (NSInteger)numberOfButtons;
    // So we can create a loop for without knowing the data source

    - (UIButton *)buttonForIndex:(NSInteger)position;
    // Just like a table view, you provide the button - this way you can set up gesture responders

    - (NSString *)stringForIndex:(NSInteger)position;
    // We need this in order to know what to label the button with

    - (CGFloat)heightForScrollView;
    // The height you want to set the content area of the scroll view -- it _may_ be overriden by IB



## Closing notes

Let me know what I've done wrong so I can improve. I hope someone out there can actually use this :)
