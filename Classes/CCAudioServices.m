//
//  CCAudioServices.m
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/12/10.
//  Copyright 2010 Unbound Medicine. All rights reserved.
//

#import "CCAudioServices.h"


@implementation CCAudioServices

+(void)playSound {
	NSURL *afUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tink" ofType:@"caf"]];
	UInt32 soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)afUrl, &soundID);
	AudioServicesPlaySystemSound(soundID);	
}

@end
