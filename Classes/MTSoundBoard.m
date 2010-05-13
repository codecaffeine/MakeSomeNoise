//
//  MTSoundBoard.m
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/8/10.
//  Copyright 2010 Unbound Medicine. All rights reserved.
//

#import "MTSoundBoard.h"
#import "CCAudioServices.h"
#import "CCOpenAL.h"


@implementation MTSoundBoard


- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super initWithCoder:decoder])) {
		openALSoundPlayer = [[CCOpenAL alloc] init];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		openALSoundPlayer = [[CCOpenAL alloc] init];
    }
    return self;
}


- (void)dealloc {
	[openALSoundPlayer release];
    [super dealloc];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[openALSoundPlayer playSound];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	[CCAudioServices playSound];
	[openALSoundPlayer stopSound];
	
	srand([[NSDate date] timeIntervalSince1970]);
	CGFloat red = (CGFloat)(rand() % 101)/100.0f;
	CGFloat green = (CGFloat)(rand() % 101)/100.0f;
	CGFloat blue = (CGFloat)(rand() % 101)/100.0f;
	CATransition *transition = [CATransition animation];
	transition.type = kCATransitionFade;
	self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
