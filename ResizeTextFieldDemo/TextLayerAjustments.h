//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface TextLayerAjustments : NSObject

@property(nonatomic) CGRect frame;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) float fontSize;

+ (id)adjustmentsWithFrame:(CGRect)frame fontSize:(float)fontSize transform:(CGAffineTransform)transform;
@end