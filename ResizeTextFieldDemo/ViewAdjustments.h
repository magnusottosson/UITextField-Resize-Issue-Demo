//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface ViewAdjustments : NSObject

@property(nonatomic) float scale;
@property(nonatomic) float rotation;
@property(nonatomic) float moveX;
@property(nonatomic) float moveY;
@property(nonatomic) CGAffineTransform transform;

+ (ViewAdjustments *)adjustmentsWithScale:(float)scale rotation:(float)rotation moveX:(float)moveX moveY:(float)moveY;
@end