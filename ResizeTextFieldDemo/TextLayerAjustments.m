//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import "TextLayerAjustments.h"


@implementation TextLayerAjustments

+ (id)adjustmentsWithFrame:(CGRect)frame fontSize:(float)fontSize transform:(CGAffineTransform)transform
{
	TextLayerAjustments *adjustments = [[TextLayerAjustments alloc] init];
	[adjustments setFrame:frame];
	[adjustments setTransform:transform];
	[adjustments setFontSize:fontSize];

	return adjustments;
}

@end