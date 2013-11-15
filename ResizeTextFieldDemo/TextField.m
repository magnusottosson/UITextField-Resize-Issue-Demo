//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import "TextField.h"
#import "TextLayerAjustments.h"
#import "NSString+FontSize.h"


@interface TextField ()
@property(nonatomic, strong) UIColor *currentTextColor;
@end

@implementation TextField

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self];

		[self setDelegate:self];
		[self setReturnKeyType:UIReturnKeyDone];

		[self setAutocorrectionType:UITextAutocorrectionTypeNo];
		[self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[self setSpellCheckingType:UITextSpellCheckingTypeNo];
	}

	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self resignFirstResponder];
	return YES;
}


- (void)setTextColor:(UIColor *)textColor
{
	self.currentTextColor = textColor;
	[super setTextColor:textColor];
}


- (void)textChanged:(id)sender
{
	[self adjustFontSize];
}

- (void)updateAdjustments
{
	[super updateAdjustments];
}

- (void)adjustFontSize
{
	[self setFont:[UIFont fontWithName:self.font.fontName size:[self.text fontSizeWithFont:self.font.fontName inFrame:self.bounds]]];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return !self.disableEditing;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[super textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[super textFieldDidEndEditing:textField];
}

- (void)textLayerStartEditing:(id)sender
{
	if(!self.disableEditing)
	{
		[super setTextColor:_currentTextColor];
	}
}

- (void)textLayerChanged:(id)sender
{
	if(!self.disableEditing)
	{
		[super setTextColor:[UIColor clearColor]];
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self adjustFontSize];
}

@end