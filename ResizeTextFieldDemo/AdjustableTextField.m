//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import "AdjustableTextField.h"
#import "ViewAdjustments.h"
#import "TextLayerAjustments.h"
#import "UIView+Positioning.h"
#import <QuartzCore/QuartzCore.h>

typedef enum {
	AdjustModeMove,
	AdjustModeResize,
	AdjustModeRotate
} AdjustMode;

@interface AdjustableTextField ()
@property(nonatomic) CGPoint startPoint;
@property(nonatomic) CGPoint startCenter;
@property(nonatomic) AdjustMode adjustMode;
@property(nonatomic) CGRect startBounds;
@property(nonatomic) CGAffineTransform startTransform;
@property(nonatomic, strong) UIImageView *rotateIcon;
@property(nonatomic, strong) UIImageView *resizeIcon;
@property(nonatomic, strong) UIView *borderView;
@property(nonatomic, strong) UIColor *internalCurrentColor;
@property(nonatomic) BOOL shouldBecomeFirstResponderOnTouchEnd;
@end

#define MIN_WIDTH 100
#define MIN_HEIGHT 44

@implementation AdjustableTextField

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setUserInteractionEnabled:YES];
		[self setClipsToBounds:NO];

		self.borderView = [[UIView alloc] initWithFrame:self.bounds];
		[_borderView setBackgroundColor:[UIColor clearColor]];
		[_borderView setHidden:YES];
		[_borderView.layer setBorderWidth:1];
		[_borderView.layer setBorderColor:[UIColor whiteColor].CGColor];
		[_borderView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
		[self addSubview:_borderView];

		self.rotateIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotate.png"]];
		[_rotateIcon setOrigin:CGPointMake(-roundf(_rotateIcon.frame.size.width/2), -roundf(_rotateIcon.frame.size.height/2))];
		[_rotateIcon setHidden:YES];
		[self addSubview:_rotateIcon];


		self.resizeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"resize.png"]];
		[_resizeIcon setOrigin:CGPointMake(self.frame.size.width - roundf(_resizeIcon.frame.size.width/2), self.frame.size.height - roundf(_resizeIcon.frame.size.height/2))];
		[_resizeIcon setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin];
		[_resizeIcon setHidden:YES];
		[self addSubview:_resizeIcon];

		[self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];

		//[self setScrollEnabled:NO];

		[self resetScrollView];

	}

	return self;
}

- (void)setTextColor:(UIColor *)textColor
{
	[super setTextColor:textColor];
	self.internalCurrentColor = textColor;
}


- (void)didMoveToSuperview
{
	[super didMoveToSuperview];

	if(self.superview)
	{
		[self updateAdjustments];
	}
}


- (void)updateAdjustments
{
	CGAffineTransform transform = self.transform;

	[self setTransform:CGAffineTransformIdentity];

	CGRect frame = self.frame;
	frame = CGRectMake(frame.origin.x/self.superview.frame.size.width, frame.origin.y/self.superview.frame.size.height, frame.size.width/self.superview.frame.size.width, frame.size.height/self.superview.frame.size.height);

	[self setTransform:transform];

	float fontSize = self.font.pointSize/self.bounds.size.width;

	self.adjustments = [TextLayerAjustments adjustmentsWithFrame:frame fontSize:fontSize transform:transform];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesCancelled:touches withEvent:event];

	[self updateAdjustments];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	self.startPoint = [touch locationInView:self.superview];
	self.startBounds = self.bounds;
	self.startCenter = self.center;
	self.startTransform = self.transform;

	CGPoint pointInView = [touch locationInView:self];
	
	if(pointInView.x > self.bounds.size.width - 44)
	{
		self.adjustMode = AdjustModeResize;
	}
	else if(pointInView.x < 44)
	{
		self.adjustMode = AdjustModeRotate;
	}
	else
	{
		self.adjustMode = AdjustModeMove;
	}

	[self resetScrollView];

	if(self.isFirstResponder)
	{
		self.preventScreenShot = YES;
		//[self resignFirstResponder];
		[super setTextColor:_internalCurrentColor];
		self.shouldBecomeFirstResponderOnTouchEnd = YES;
	}
	[self resetScrollView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];

	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point = [touch locationInView:self.superview];

	float diffX = point.x - self.startPoint.x;
	float diffY = point.y - self.startPoint.y;

	//float diffX = transformedPoint.x - self.startPoint.x;
	//float diffY = transformedPoint.y - self.startPoint.y;

	if(self.adjustMode == AdjustModeMove)
	{
		[self setCenter:CGPointMake(self.startCenter.x + diffX, self.startCenter.y + diffY)];
	}
	else if(self.adjustMode == AdjustModeResize)
	{
		float width = MAX(self.startBounds.size.width + diffX, MIN_WIDTH);
		float height = MAX(self.startBounds.size.height + diffY, MIN_HEIGHT);

		[self setBounds:CGRectMake(0, 0, width, height)];
		[self resetScrollView];
	}
	else if(self.adjustMode == AdjustModeRotate)
	{
		float sRad = atan2f(point.y - self.startCenter.y, point.x - self.startCenter.x);
		sRad -= atan2f(self.startPoint.y - self.startCenter.y, self.startPoint.x - self.startCenter.x);

		CGAffineTransform transform = CGAffineTransformRotate(self.startTransform, sRad);
		[self setTransform:transform];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];

	if(self.shouldBecomeFirstResponderOnTouchEnd)
	{
		//[self becomeFirstResponder];
		self.preventScreenShot = NO;
		self.shouldBecomeFirstResponderOnTouchEnd = NO;
	}

	self.startPoint = CGPointZero;
	self.startCenter = CGPointZero;

	[self updateAdjustments];
}

- (void)resetScrollView
{
	UIScrollView *scrollView = [self findScrollViewFromView:self];

	NSLog(@"self %@", NSStringFromCGRect(self.frame));
	NSLog(@"scrollview %@", NSStringFromCGRect(scrollView.frame));
	NSLog(@"contentsize %@", NSStringFromCGSize(scrollView.contentSize));
	NSLog(@"offset %@", NSStringFromCGPoint(scrollView.contentOffset));

	float x = roundf((self.frame.size.width - scrollView.contentSize.width)/2);
	float y = roundf((self.frame.size.height - scrollView.contentSize.height)/2);

	//[scrollView setContentOffset:CGPointMake(x, y)];

	//NSLog(@"offset after %@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)layoutSubviews
{
	[super layoutSubviews];


	[self resetScrollView];
}


- (UIScrollView *)findScrollViewFromView:(UIView *)view
{
	if([view isKindOfClass:[UIScrollView class]])
	{
		return (UIScrollView *) view;
	}

	for(UIView *v in view.subviews)
	{
		UIScrollView *scrollView = [self findScrollViewFromView:v];

		if(scrollView)
		{
			return scrollView;
		}
	}

	return nil;
}

- (void)setCenter:(CGPoint)center
{
	[super setCenter:center];
}

- (void)setBounds:(CGRect)bounds
{
	[super setBounds:bounds];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if(!self.preventScreenShot)
	{
		[_borderView setHidden:NO];
		[self.resizeIcon setHidden:NO];
		[self.rotateIcon setHidden:NO];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if(!self.preventScreenShot)
	{
		[_borderView setHidden:YES];
		[self.resizeIcon setHidden:YES];
		[self.rotateIcon setHidden:YES];
	}
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	CGRect relativeFrame = self.bounds;
	CGRect hitFrame = CGRectInset(relativeFrame, -25, -25);

	return CGRectContainsPoint(hitFrame, point);
}




@end