//
//  MakeSomeNoiseAppDelegate.h
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/4/10.
//  Copyright Matthew Thomas 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MakeSomeNoiseViewController;

@interface MakeSomeNoiseAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MakeSomeNoiseViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MakeSomeNoiseViewController *viewController;

@end

