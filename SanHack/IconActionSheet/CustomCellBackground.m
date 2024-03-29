//
//  CustomCellBackground.m
//  IconActionSheetDemo
//
//  Created by Jonathan Grana on 10/7/12.
//  Copyright (c) 2012 Jonathan Grana. All rights reserved.
//

#import "CustomCellBackground.h"

@implementation CustomCellBackground

- (void)drawRect:(CGRect)rect
{
    // draw a rounded rect bezier path filled with blue
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    
    [bezierPath setLineWidth:5.0f];
    [[UIColor clearColor] setStroke];
    
    UIColor *fillColor = [UIColor clearColor]; // color equivalent is #87ceeb
    [fillColor setFill];
    
    [bezierPath stroke];
    [bezierPath fill];
    CGContextRestoreGState(aRef);
}

@end
