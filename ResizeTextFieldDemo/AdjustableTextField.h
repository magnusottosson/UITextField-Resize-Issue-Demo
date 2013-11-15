//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import <Foundation/Foundation.h>

@class TextLayerAjustments;


@interface AdjustableTextField : UITextField<UITextFieldDelegate>
@property(nonatomic, strong) TextLayerAjustments *adjustments;

@property(nonatomic) BOOL preventScreenShot;

- (void)updateAdjustments;
@end