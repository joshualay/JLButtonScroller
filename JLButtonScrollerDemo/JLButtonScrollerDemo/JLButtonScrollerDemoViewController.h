//
//  JLButtonScrollerDemoViewController.h
//  JLButtonScrollerDemo
//
//  Created by Joshua Lay on 7/09/11.
//  Copyright 2011 Joshua Lay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLButtonScroller.h"

@interface JLButtonScrollerDemoViewController : UIViewController <JLButtonScrollerDelegate, UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *label;
}

- (IBAction)reload:(id)sender;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, retain) JLButtonScroller *buttonScroller;

@end
