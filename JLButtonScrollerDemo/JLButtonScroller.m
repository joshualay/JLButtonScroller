//
//  JLButtonScroller.m
//  aporterapp
//
//  Created by Joshua Lay on 7/09/11.
//  Copyright 2011 Joshua Lay. All rights reserved.
//

#import "JLButtonScroller.h"

@interface JLButtonScroller (Private)
- (void)addButtonSubviewsForScrollView;

- (NSString *)stringForIndex:(NSInteger)position;
- (UIFont *)fontForButton;
@end

@implementation JLButtonScroller

@synthesize delegate;

- (void)dealloc {
    delegate = nil;
    [super dealloc];
}


- (void)addButtonsForContentAreaIn:(UIScrollView *)scrollView {
    self->_scrollView = scrollView;
    [self addButtonSubviewsForScrollView];
}

- (void)reloadButtons {
    if (!self->_scrollView)
        return;
    
    for (UIView *view in self->_scrollView.subviews) {
        [view removeFromSuperview];
    }
        
    [self addButtonSubviewsForScrollView];
}


- (void)addButtonSubviewsForScrollView {
    UIFont *font = [self fontForButton];
    
    /*  The button length is calculated using the string length below
        This buffer is so the button isn't the length of the text
        E.g. 
            buttonOffset = 0 -    [buttontext]
            buttonOffset = 8 - [   buttontext    ]
     */
    
    NSInteger buttonOffset = 10.0f;
    if ([delegate respondsToSelector:@selector(paddingForButton)]) {
        buttonOffset = [delegate paddingForButton];
    }
    
    NSInteger maxButtons = [delegate numberOfButtons];
    
    NSInteger xOffset = 0; // Work out where to place the next button
    NSInteger xButtonBuffer = 4.0f; // Gap between buttons
    if ([delegate respondsToSelector:@selector(spaceBetweenButtons)]) {
        xButtonBuffer = [delegate spaceBetweenButtons];
    }
    
    for (int i = 0; i < maxButtons; i++) {
        UIButton *button = [delegate buttonForIndex:i];
        button.titleLabel.font = font;
        
        NSString *text = [[self stringForIndex:i] copy];
        CGSize stringSize = [text sizeWithFont:font];
        // Work out the width we need the button to be by determining how long the string is
        CGFloat stringWidth = stringSize.width + buttonOffset;
        
        CGRect scrollViewFrame = self->_scrollView.frame;
        
        CGFloat buttonHeight = stringSize.height;
        if ([self.delegate respondsToSelector:@selector(heightForButton)])
            buttonHeight = [self.delegate heightForButton];
        
        CGFloat scrollViewHeight = scrollViewFrame.size.height;

        // Don't want the button to go beyond the scroll view.
        // If this is intentional then implement: heightForScrollView
        if (buttonHeight > scrollViewHeight)
            scrollViewHeight = buttonHeight;
        
        if ([self.delegate respondsToSelector:@selector(heightForScrollView)])
            scrollViewHeight = [self.delegate heightForScrollView];
        
        CGFloat diff = scrollViewHeight - buttonHeight;
        CGFloat yOffset = diff / 2.0f;
        yOffset += scrollViewFrame.origin.y;
        
        button.frame = CGRectMake(xOffset, yOffset, stringWidth, buttonHeight);
        
        [button setTitle:text forState:UIControlStateNormal];
        [button setTitle:text forState:UIControlStateHighlighted];
        [button setTitle:text forState:UIControlStateSelected];
        [button setTitle:text forState:UIControlStateDisabled];
        
        [text release];
        
        if ([delegate respondsToSelector:@selector(setTitleForStateNormalFor:atIndex:)])
            [delegate setTitleForStateNormalFor:button atIndex:i];
        
        if ([delegate respondsToSelector:@selector(setTitleForStateSelectedFor:atIndex:)])
            [delegate setTitleForStateSelectedFor:button atIndex:i];
        
        if ([delegate respondsToSelector:@selector(setTitleForStateHighlightedFor:atIndex:)])
            [delegate setTitleForStateHighlightedFor:button atIndex:i];
        
        if ([delegate respondsToSelector:@selector(setTitleForStateDisabledFor:atIndex:)])
            [delegate setTitleForStateDisabledFor:button atIndex:i];
        
        [self->_scrollView addSubview:button];
        
        xOffset += stringWidth + xButtonBuffer; // move our origin.x position for the next button
    }
    
    [self->_scrollView setContentSize:CGSizeMake(xOffset, [delegate heightForScrollView])];
}

- (UIFont *)fontForButton {
    if ([self.delegate respondsToSelector:@selector(fontForButton)])
        return [self.delegate fontForButton];
    
    return [UIFont systemFontOfSize:12.0f];
}

- (NSString *)stringForIndex:(NSInteger)position {
    if ([self.delegate respondsToSelector:@selector(stringButtonTitleForPosition:)]) 
        return [self.delegate stringButtonTitleForPosition:position];
    
    return @"";
}


@end
