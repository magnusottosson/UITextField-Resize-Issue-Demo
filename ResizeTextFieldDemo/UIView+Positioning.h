//
//  Created by Magnus Ottosson on 2013-08-12.
//  Copyright (c) 2013 NIXON NIXON. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface UIView (Positioning)
- (void)setOrigin:(CGPoint)origin;

- (void)setOriginX:(float)originX;

- (void)setOriginY:(float)originY;

- (void)centerHorizontal;

- (void)centerVertical;
@end