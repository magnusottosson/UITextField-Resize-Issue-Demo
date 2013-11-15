//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AdjustableTextField.h"

@class TextElement;


@interface TextField : AdjustableTextField <UITextFieldDelegate>

@property(nonatomic) BOOL disableEditing;
@property(nonatomic, strong) TextElement *textElement;

- (void)adjustFontSize;

- (void)prepareForScreenShot;

- (void)restoreColorAfterScreenShot;

- (void)prepareForMask;

- (void)restoreColorAfterMask;
@end