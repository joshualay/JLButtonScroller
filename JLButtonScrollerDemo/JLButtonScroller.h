//
//  JLButtonScroller.h

//  Created by Joshua Lay on 7/09/11.
//  Copyright 2011 Joshua Lay. All rights reserved.
//
//  Simple class to allow you to add a set of buttons to a UIScrollView

#import <Foundation/Foundation.h>

@protocol JLButtonScrollerDelegate <NSObject>
@required
- (NSInteger)numberOfButtons; // How many buttons we're going to create
- (UIButton *)buttonForIndex:(NSInteger)position; // The UIButton to put in place

@optional
/*
 This will determine the text to display for the title in all states. 
 
 The default is an empty string if you wish to only show images.
 
 [button setTitle:text forState:UIControlStateNormal];
 [button setTitle:text forState:UIControlStateHighlighted];
 [button setTitle:text forState:UIControlStateSelected];
 [button setTitle:text forState:UIControlStateDisabled];
 */
- (NSString *)stringButtonTitleForPosition:(NSInteger)position;

- (CGFloat)heightForScrollView; // By default this will work out a height based on the size of the buttons
- (CGFloat)heightForButton;
- (UIFont *)fontForButton;

- (void)setTitleForStateNormalFor:(UIButton *)button atIndex:(NSInteger)position;
- (void)setTitleForStateHighlightedFor:(UIButton *)button atIndex:(NSInteger)position;
- (void)setTitleForStateSelectedFor:(UIButton *)button atIndex:(NSInteger)position;
- (void)setTitleForStateDisabledFor:(UIButton *)button atIndex:(NSInteger)position;

- (CGFloat)paddingForButton; // How much extra space you want in a button besides the width of the string
- (NSInteger)spaceBetweenButtons; // The gap between buttons
@end

@interface JLButtonScroller : NSObject {
    id <JLButtonScrollerDelegate> delegate;
    UIScrollView *_scrollView;
}

@property (nonatomic, assign) id<JLButtonScrollerDelegate> delegate;

- (void)addButtonsForContentAreaIn:(UIScrollView *)scrollView;
- (void)reloadButtons;

@end
