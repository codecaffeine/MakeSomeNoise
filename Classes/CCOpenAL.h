//
//  CCOpenAL.h
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/12/10.
//  Copyright 2010 Unbound Medicine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>


@interface CCOpenAL : NSObject {
	ALCcontext *mContext;
	ALCdevice *mDevice;
	NSMutableArray *bufferStorageArray;
	NSMutableDictionary *soundDictionary;
}

- (void)playSound;
- (void)stopSound;
- (void)load;
- (AudioFileID)openAudioFile:(NSString *)filePath;
- (UInt32)audioFileSize:(AudioFileID)fileDescriptor;

@end
