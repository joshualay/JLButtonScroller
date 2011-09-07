//
//  JLButtonScrollerDemoViewController.m
//  JLButtonScrollerDemo
//
//  Created by Joshua Lay on 7/09/11.
//  Copyright 2011 Joshua Lay. All rights reserved.
//

#import "JLButtonScrollerDemoViewController.h"

@interface JLButtonScrollerDemoViewController()
- (void)populateDataSource;
- (void)buttonReleased:(id)sender;
@end

@implementation JLButtonScrollerDemoViewController

@synthesize scrollView=_scrollView;
@synthesize dataSource=_dataSource;
@synthesize label=_label;

- (void)dealloc
{
    [_scrollView release];
    [_label release];
    [_dataSource release];
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

    JLButtonScroller *buttonScrollWorker = [[JLButtonScroller alloc] init];
    buttonScrollWorker.delegate = self;
    
    [buttonScrollWorker addButtonsForContentAreaIn:self.scrollView];
    
    [buttonScrollWorker release];
}


#pragma mark - ButtonScrollDelegate
- (UIFont *)fontForButton {
    return [UIFont systemFontOfSize:24.0f];
}

- (NSInteger)numberOfButtons {
    return [self.dataSource count];
}

- (UIButton *)buttonForIndex:(NSInteger)position {   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.titleLabel.textColor = [UIColor blackColor];
    button.backgroundColor = [UIColor lightGrayColor];
    
    [button addTarget:self action:@selector(buttonReleased:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (NSString *)stringForIndex:(NSInteger)position {
    return [self.dataSource objectAtIndex:position];
}

- (CGFloat)heightForScrollView {
    return 44.0f;
}

- (CGFloat)paddingForButton {
    return 45.0f;
}

#pragma mark - button selector
-(void) buttonReleased:(id)sender {
    UIButton *button = (UIButton *)sender;
    self.label.text = button.titleLabel.text;
}

@end
