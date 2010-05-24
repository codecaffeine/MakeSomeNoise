//
//  CCRemoteIO.h
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/16/10.
//  Copyright 2010 Unbound Medicine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioUnit/AudioUnit.h>


@interface CCRemoteIO : NSObject {
	NSMutableArray *audioInterface;
	AudioComponentInstance myAudioUnit;
}
- (void)playSound;
- (void)stopSound;
- (void)initializeAudio;
- (void)uninitializeAudio;
@end
