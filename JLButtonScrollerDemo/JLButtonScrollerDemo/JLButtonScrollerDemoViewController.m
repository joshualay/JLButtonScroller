//
//  JLButtonScrollerDemoViewController.m
//  JLButtonScrollerDemo
//
//  Created by Joshua Lay on 7/09/11.
//  Copyright 2011 Joshua Lay. All rights reserved.
//

#include <stdlib.h>

#import "JLButtonScrollerDemoViewController.h"

@interface JLButtonScrollerDemoViewController()
- (void)populateDataSource;
- (void)buttonReleased:(id)sender;
@end

@implementation JLButtonScrollerDemoViewController

@synthesize scrollView=_scrollView;
@synthesize dataSource=_dataSource;
@synthesize label=_label;
@synthesize buttonScroller=_buttonScroller;

- (void)dealloc
{
    [_scrollView release];
    [_label release];
    [_dataSource release];
    _buttonScroller.delegate = nil;
    [_buttonScroller release];
    [super dealloc];
}

- (void)populateDataSource {
    self.dataSource = [NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", @"Eleven", nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateDataSource];

    _buttonScroller = [[JLButtonScroller alloc] init];
    
    _buttonScroller.delegate = self;
    
    [_buttonScroller addButtonsForContentAreaIn:self.scrollView];
    
    self.label.font = [UIFont systemFontOfSize:36.0f];
}


#pragma mark - ButtonScrollDelegate
- (UIFont *)fontForButton {
    return [UIFont systemFontOfSize:17.0f];
}

- (NSInteger)numberOfButtons {
    return [self.dataSource count];
}

- (UIButton *)buttonForIndex:(NSInteger)position {   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button setTintColor:[UIColor lightTextColor]];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonReleased:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (NSString *)stringButtonTitleForPosition:(NSInteger)position {
    return [self.dataSource objectAtIndex:position];
}

- (CGFloat)heightForScrollView {
    return 44.0f;
}

- (CGFloat)paddingForButton {
    return 20.0f;
}

- (NSInteger)spaceBetweenButtons {
    return 7;
}

#pragma mark - button selector
-(void) buttonReleased:(id)sender {
    UIButton *button = (UIButton *)sender;
    self.label.text = button.titleLabel.text;
}

- (IBAction)reload:(id)sender {
    int range = arc4random_uniform(70);
    while (range == 0) {
        range = arc4random_uniform(70);
    }
    
    NSMutableArray *randArray = [[NSMutableArray alloc] initWithCapacity:range];
    for (int i = 0; i < range; i++) {
        [randArray addObject:[NSString stringWithFormat:@"Num: %i", i]];
    }

    _dataSource = nil;
    _dataSource = [randArray copy];

    [randArray release];
    
    [_buttonScroller reloadButtons];
}

@end
