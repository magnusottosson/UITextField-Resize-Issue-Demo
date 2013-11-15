//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import "UIView+Size.h"


@implementation UIView (Size)

- (void)setWidth:(float)width height:(float)height
{
	[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height)];
}

- (void)setWidth:(float)width
{
	[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height)];
}

- (void)setHeight:(float)height
{
	[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)];
}

@end