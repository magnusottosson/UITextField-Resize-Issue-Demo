//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import "ViewAdjustments.h"


@implementation ViewAdjustments

+ (ViewAdjustments *)adjustmentsWithScale:(float)scale rotation:(float)rotation moveX:(float)moveX moveY:(float)moveY
{
	ViewAdjustments *adjustments = [[ViewAdjustments alloc] init];
	[adjustments setScale:scale];
	[adjustments setRotation:rotation];
	[adjustments setMoveX:moveX];
	[adjustments setMoveY:moveY];

	return adjustments;
}

@end