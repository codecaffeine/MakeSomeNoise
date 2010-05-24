//
//  MTSoundBoard.h
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/8/10.
//  Copyright 2010 Unbound Medicine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class CCOpenAL;
@class CCRemoteIO;

@interface CCSoundBoard : UIView {
	CCOpenAL *openALSoundPlayer;
	CCRemoteIO *remoteIOSoundPlayer;
}

@end
