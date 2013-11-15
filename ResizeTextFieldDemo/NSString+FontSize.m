//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import <CoreText/CoreText.h>
#import "NSString+FontSize.h"


@implementation NSString (FontSize)

- (float)fontSizeWithFont:(NSString *)fontName inFrame:(CGRect)frame
{
	// Try all font sizes from largest to smallest font size
	float fontSize = frame.size.height;
	int minFontSize = 5;

	do {
		// Set current font size
		UIFont *newFont = [UIFont fontWithName:fontName size:fontSize];

		// Find label size for current font size

		CGSize labelSize = [self sizeWithFont:newFont];
			/*
		CGSize labelSize = [self boundingRectWithSize:constraintSize options:NSStringDrawingUsesDeviceMetrics attributes:nil context:nil].size;


		CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);;
		CGSize labelSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [attributedString length]), NULL, constraintSize, NULL);
		CFRelease(framesetter);
		*/

		// Done, if created label is within target size
		if(labelSize.height <= frame.size.height && labelSize.width <= frame.size.width)
			break;

		// Decrease the font size and try again
		fontSize -= 2.0f;

	} while (fontSize > minFontSize);

	return fontSize;
}


@end