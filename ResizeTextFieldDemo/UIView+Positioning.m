//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import "UIView+Positioning.h"


@implementation UIView (Positioning)

- (void)setOrigin:(CGPoint)origin
{
	[self setFrame:CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height)];
}

- (void)setOriginX:(float)originX
{
	[self setOrigin:CGPointMake(originX, self.frame.origin.y)];
}

- (void)setOriginY:(float)originY
{
	[self setOrigin:CGPointMake(self.frame.origin.x, originY)];
}

- (void)centerHorizontal
{
	float originX = self.superview.frame.size.width/2 - self.frame.size.width/2;
	[self setOriginX:originX];
}

- (void)centerVertical
{
	float originY = self.superview.frame.size.height/2 - self.frame.size.height/2;
	[self setOriginY:originY];
}

@end