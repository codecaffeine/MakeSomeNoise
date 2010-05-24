//
//  MakeSomeNoiseAppDelegate.m
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/4/10.
//  Copyright Matthew Thomas 2010. All rights reserved.
//

#import "MakeSomeNoiseAppDelegate.h"
#import "MakeSomeNoiseViewController.h"

@implementation MakeSomeNoiseAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
