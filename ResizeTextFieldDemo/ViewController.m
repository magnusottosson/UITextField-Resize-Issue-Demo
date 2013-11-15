//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import "ViewController.h"
#import "TextField.h"


@implementation ViewController
{

}

- (void)loadView
{
	[super loadView];

	[self.view setBackgroundColor:[UIColor blackColor]];

	TextField *textField = [[TextField alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
	[textField setText:@"Hello World"];
	[textField setBackgroundColor:[UIColor clearColor]];
	[textField setTextColor:[UIColor whiteColor]];
	[textField setTextAlignment:NSTextAlignmentCenter];
	[self.view addSubview:textField];
}


@end