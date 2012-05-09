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
    UIFont *font = [delegate fontForButton];
    
    NSInteger buttonOffset = 10.0f;
    if ([delegate respondsToSelector:@selector(paddingForButton)]) {
        buttonOffset = [delegate paddingForButton];
    }
    
    NSInteger maxButtons = [delegate numberOfButtons];
    
    NSInteger xOffset = 0;
    NSInteger xButtonBuffer = 4.0f;
    if ([delegate respondsToSelector:@selector(spaceBetweenButtons)]) {
        xButtonBuffer = [delegate spaceBetweenButtons];
    }
    
    for (int i = 0; i < maxButtons; i++) {
        UIButton *button = [delegate buttonForIndex:i];
        button.titleLabel.font = font;
        
        NSString *text = [delegate stringForIndex:i];
        CGSize stringSize = [text sizeWithFont:font];
        CGFloat stringWidth = stringSize.width + buttonOffset;
        
        CGRect scrollViewFrame = self->_scrollView.frame;
        CGFloat scrollViewHeight = scrollViewFrame.size.height;
        CGFloat buttonHeight = stringSize.height;
        CGFloat diff = scrollViewHeight - buttonHeight;
        CGFloat yOffset = diff / 2.0f;
        yOffset += scrollViewFrame.origin.y;
        
        button.frame = CGRectMake(xOffset, yOffset, stringWidth, stringSize.height);
        
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
            
        xOffset += stringWidth + xButtonBuffer;
    }
    
    [self->_scrollView setContentSize:CGSizeMake(xOffset, [delegate heightForScrollView])];
}

@end
