//
//  JLButtonScrollerDemoAppDelegate.h
//  JLButtonScrollerDemo
//
//  Created by Joshua Lay on 7/09/11.
//  Copyright 2011 Joshua Lay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLButtonScrollerDemoViewController;

@interface JLButtonScrollerDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet JLButtonScrollerDemoViewController *viewController;

@end
