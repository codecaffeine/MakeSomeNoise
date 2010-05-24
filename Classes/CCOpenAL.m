//
//  CCOpenAL.m
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/12/10.
//  Copyright 2010 Matthew Thomas. All rights reserved.
//
// This code is based on http://benbritten.com/2008/11/06/openal-sound-on-the-iphone/

#import "CCOpenAL.h"


@implementation CCOpenAL

- (id)init {
	self = [super init];
	if (self != nil) {
		mDevice = alcOpenDevice(NULL);
		if (mDevice) {
			mContext = alcCreateContext(mDevice, NULL);
			alcMakeContextCurrent(mContext);
			bufferStorageArray = [[NSMutableArray alloc] initWithCapacity:10];
			soundDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
			[self load];
		}
	}
	return self;
}


- (void)dealloc {
	for (NSNumber *sourceNumber in [soundDictionary allValues]) {
		NSUInteger sourceID = [sourceNumber unsignedIntegerValue];
		alDeleteSources(1, &sourceID);
	}
	[soundDictionary removeAllObjects];
	
	// delete the buffers
	for (NSNumber *bufferNumber in bufferStorageArray) {
		NSUInteger bufferID = [bufferNumber unsignedIntegerValue];
		alDeleteBuffers(1, &bufferID);
	}
	[bufferStorageArray removeAllObjects];
	
	// destroy the context
	alcDestroyContext(mContext);
	// close the device
	alcCloseDevice(mDevice);
	
	
	[bufferStorageArray release];
	[soundDictionary release];
	[super dealloc];
}


- (void)playSound {
	NSNumber *numVal = [soundDictionary objectForKey:@"neatoSound"];
	if (numVal == nil)
		return;
	NSUInteger sourceID = [numVal unsignedIntValue];
	alSourcePlay(sourceID);
}


- (void)stopSound {
	NSNumber * numVal = [soundDictionary objectForKey:@"neatoSound"];
	if (numVal == nil)
		return;
	NSUInteger sourceID = [numVal unsignedIntValue];
	alSourceStop(sourceID);	
}


- (void)load {
	NSString *fileName = @"communicator";
	AudioFileID fileID = [self openAudioFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"]];
	UInt32 fileSize = [self audioFileSize:fileID];
	unsigned char *outData = malloc(fileSize);
	OSStatus result = AudioFileReadBytes(fileID, false, 0, &fileSize, outData);
	AudioFileClose(fileID);
	if (result != 0) {
		NSLog(@"cannot load file: %@", fileName);
	}
	NSUInteger bufferID;
	alGenBuffers(1, &bufferID);
	alBufferData(bufferID, AL_FORMAT_STEREO16, outData, fileSize, 441000);
	[bufferStorageArray addObject:[NSNumber numberWithUnsignedInteger:bufferID]];
	
	NSUInteger sourceID;
	alGenSources(1, &sourceID);
	alSourcei(sourceID, AL_BUFFER, bufferID);
	alSourcef(sourceID, AL_PITCH, 1.0f);
	alSourcef(sourceID, AL_GAIN, 1.0f);
	alSourcei(sourceID, AL_LOOPING, AL_TRUE);
	[soundDictionary setObject:[NSNumber numberWithUnsignedInt:sourceID] forKey:@"neatoSound"];
	if (outData) {
		free(outData);
		outData = NULL;
	}
}


- (AudioFileID)openAudioFile:(NSString *)filePath {
	AudioFileID outAFID;
	NSURL *afURL = [NSURL fileURLWithPath:filePath];
	OSStatus result = AudioFileOpenURL((CFURLRef)afURL, kAudioFileReadPermission, 0, &outAFID);
	if (result != 0) {
		NSLog(@"cannot open file: %@", filePath);
	}
	return outAFID;
}


- (UInt32)audioFileSize:(AudioFileID)fileDescriptor {
	UInt64 outDataSize = 0;
	UInt32 thePropSize = sizeof(UInt64);
	OSStatus result = AudioFileGetProperty(fileDescriptor, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
	if (result != 0) {
		NSLog(@"cannot find file size");
	}
	return (UInt32)outDataSize;
}

@end
