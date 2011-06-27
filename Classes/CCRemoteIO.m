//
//  CCRemoteIO.m
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/16/10.
//  Copyright 2010 Matthew Thomas. All rights reserved.
//

#import "CCRemoteIO.h"


#define kOutputBus 0
#define kInputBus 1


UInt32 sSinWaveFrameCount = 0; // this keeps track of the number of frames you render

static OSStatus playbackCallback(void *inRefCon,
								 AudioUnitRenderActionFlags *ioActionFlags,
								 const AudioTimeStamp *inTimeStamp,
								 UInt32 inBusNumber,
								 UInt32 inNumberFrames,
								 AudioBufferList *ioData) {
	
	double frequency = 440.;
	sSinWaveFrameCount += inNumberFrames;
	double j = sSinWaveFrameCount;
	double cycleLength = 44100. / frequency;
	
	SInt16 *toneBuffer = (SInt16 *)ioData->mBuffers[0].mData;
	
	for (UInt32 currentFrame = 0; currentFrame < inNumberFrames; ++currentFrame) {
        double x = j / cycleLength * (M_PI * 2.);
		double nextFloat = sin(x);
		toneBuffer[currentFrame] = 32767. * nextFloat;
		
		j += 1.0f;
		if (j > cycleLength) {
			j -= cycleLength;
		}
	}
	
	return noErr;
}


@implementation CCRemoteIO

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self initializeAudio];
	}
	return self;
}


- (void) dealloc
{
	[self uninitializeAudio];
	[super dealloc];
}


- (void)playSound {
	OSStatus status = AudioOutputUnitStart(myAudioUnit);
	NSLog(@"playSound status: %d", (signed int)status);
}


- (void)stopSound {
	OSStatus status = AudioOutputUnitStop(myAudioUnit);
	NSLog(@"stopSound status: %d", (signed int)status);
}

- (void)initializeAudio {
	OSStatus status;
	
	// Describe audio component
	AudioComponentDescription desc;
	desc.componentType = kAudioUnitType_Output;
	desc.componentSubType = kAudioUnitSubType_RemoteIO;
	desc.componentFlags = 0;
	desc.componentFlagsMask = 0;
	desc.componentManufacturer = kAudioUnitManufacturer_Apple;
	
	// Get component
	AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);
	
	// Get audio units
	status = AudioComponentInstanceNew(inputComponent, &myAudioUnit);
	
	// Enable IO for playback
	UInt32 flag = 1;
	status = AudioUnitSetProperty(myAudioUnit, 
								  kAudioOutputUnitProperty_EnableIO, 
								  kAudioUnitScope_Output, 
								  kOutputBus, 
								  &flag, 
								  sizeof(flag));
	
	// Describe format
	AudioStreamBasicDescription audioFormat;
	audioFormat.mSampleRate = 44100.00;
	audioFormat.mFormatID = kAudioFormatLinearPCM;
	audioFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
	audioFormat.mFramesPerPacket = 1;
	audioFormat.mChannelsPerFrame = 1;
	audioFormat.mBitsPerChannel = 16;
	audioFormat.mBytesPerPacket = 2;
	audioFormat.mBytesPerFrame = 2;
	
	// Apply format
	status = AudioUnitSetProperty(myAudioUnit, 
								  kAudioUnitProperty_StreamFormat, 
								  kAudioUnitScope_Output, 
								  kInputBus, 
								  &audioFormat, 
								  sizeof(audioFormat));

	status = AudioUnitSetProperty(myAudioUnit, 
								  kAudioUnitProperty_StreamFormat, 
								  kAudioUnitScope_Input, // output?
								  kOutputBus, 
								  &audioFormat, 
								  sizeof(audioFormat));
	
	// Set output callback
	AURenderCallbackStruct callbackStruct;
	callbackStruct.inputProc = playbackCallback;
	callbackStruct.inputProcRefCon = self;
	status = AudioUnitSetProperty(myAudioUnit, 
								  kAudioUnitProperty_SetRenderCallback, 
								  kAudioUnitScope_Global, 
								  kOutputBus, 
								  &callbackStruct, 
								  sizeof(callbackStruct));
	
	// Initialize
	status = AudioUnitInitialize(myAudioUnit);
}


- (void)uninitializeAudio {
	AudioUnitUninitialize(myAudioUnit);
}

@end
