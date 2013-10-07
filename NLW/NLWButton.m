//
//  NLWButton.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/30/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWButton.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation NLWButton

-(id) init
{
	self = [super init];
	if (self) {
		[self setupBorder];
		self.imageView.contentMode = UIViewContentModeScaleToFill;
		[self setTitleColor:[super titleColorForState:UIControlStateNormal] forState:UIControlStateHighlighted];
		[self setupView];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupBorder];
		self.imageView.contentMode = UIViewContentModeScaleToFill;
		[self setTitleColor:[super titleColorForState:UIControlStateNormal] forState:UIControlStateHighlighted];
		[self setupView];
	}
	return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setupBorder];
		self.imageView.contentMode = UIViewContentModeScaleToFill;
		[self setTitleColor:[super titleColorForState:UIControlStateNormal] forState:UIControlStateHighlighted];
		[self setupView];
	}
	return self;
}

- (void)awakeFromNib
{
	[self setupView];
}

-(void) setupBorder
{
	
	const CGFloat* components = CGColorGetComponents(self.backgroundColor.CGColor);
	if (components)
		self.layer.borderColor = [[[UIColor alloc] initWithRed:components[0] * BUTTON_BORDER_DARKNESS
																										 green:components[1] * BUTTON_BORDER_DARKNESS
																											blue:components[2] * BUTTON_BORDER_DARKNESS
																										 alpha:CGColorGetAlpha(self.backgroundColor.CGColor)] CGColor];
	self.layer.borderWidth = BUTTON_BORDER_THICKNESS;
	//self.clipsToBounds = YES;
	[self.layer setCornerRadius:BUTTON_CORNER_RADIUS];
	
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
	[super setBackgroundColor:backgroundColor];
	[self setupBorder];
}

-(void)setHighlighted:(BOOL)highlighted
{
	
	if (highlighted == YES)
	{
		[self highlightView];
	} else
	{
		[self clearHighlightView];
	}
	
	[super setHighlighted:highlighted];
}

- (void)setupView
{
	[self setupBorder];
	self.clipsToBounds = YES;
	self.layer.shadowColor = [UIColor blackColor].CGColor;
	[self clearHighlightView];
}

- (void)highlightView
{
	self.layer.backgroundColor = self.highlightedColor.CGColor;
}

- (void)clearHighlightView {
	self.layer.backgroundColor = self.unHighlightedColor.CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
