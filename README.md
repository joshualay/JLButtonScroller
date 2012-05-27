# JLButtonScroller
> Author: Joshua Lay


## What is this?

A very simple implementation to set the content area of a scroll view with buttons from a given data source.

## Is it useful?

It is to me.. but probably not for you. This is the first time I've written a protocol before so it may be bad.


# JLButtonScrollerDelegate

    @protocol JLButtonScrollerDelegate <NSObject>
    @required
    // So we can create a loop for without knowing the data source
    - (NSInteger)numberOfButtons;

    // Just like a table view, you provide the button - this way you can set up gesture responders
    - (UIButton *)buttonForIndex:(NSInteger)position;


## Closing notes

Let me know what I've done wrong so I can improve. I hope someone out there can actually use this :)
