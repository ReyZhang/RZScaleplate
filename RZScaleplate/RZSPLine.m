//
//  RZSPLine.m
//  HealthService
//
//  Created by Zhang Rey on 7/1/14.
//
//

#import "RZSPLine.h"

@implementation RZSPLine

-(id)initWithOritation:(SPOrientation)oritation isLong:(BOOL)isLong {
    if (self=[super init]) {
        self.oritation=oritation;
        self.isLong=isLong;
        
        self.backgroundColor=[UIColor clearColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    UIColor *drawColor;
    CGFloat lineLength;
    
    if (self.isLong) {
        drawColor= [UIColor darkGrayColor];
        lineLength=kMaxLineLength;
    }else {
        drawColor=[UIColor lightGrayColor];
        lineLength=kMaxLineLength-5;
    }
    
    
    
    CGContextSetStrokeColorWithColor(context, drawColor.CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextMoveToPoint(context, 0, 0);
    
    if (self.oritation==Horizontal) {
        CGContextAddLineToPoint(context, 0, lineLength);  /////水平时画竖线
    }else
        CGContextAddLineToPoint(context, lineLength, 0); //////竖着时画横线
    
    CGContextStrokePath(context);
}



@end
