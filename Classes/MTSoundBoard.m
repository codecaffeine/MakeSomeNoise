//
//  MTSoundBoard.m
//  MakeSomeNoise
//
//  Created by Matthew Thomas on 5/8/10.
//  Copyright 2010 Unbound Medicine. All rights reserved.
//

#import "MTSoundBoard.h"


@implementation MTSoundBoard


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSURL *afUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tink" ofType:@"caf"]];
	UInt32 soundID;
	AudioServicesCreateSystemSoundID((CFURLRef)afUrl, &soundID);
	AudioServicesPlaySystemSound(soundID);
	
	srand(time(NULL));
	CGFloat red = (CGFloat)(rand() % 101)/100.0f;
	CGFloat green = (CGFloat)(rand() % 101)/100.0f;
	CGFloat blue = (CGFloat)(rand() % 101)/100.0f;
	CATransition *transition = [CATransition animation];
	transition.type = kCATransitionFade;
	self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
	NSLog(@"background-color: %@", self.backgroundColor);
}

@end
