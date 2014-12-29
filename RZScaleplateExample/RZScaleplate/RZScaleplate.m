//
//  RZscaleplate.m
//  HealthService
//
//  Created by Zhang Rey on 7/1/14.
//
//

#import "RZScaleplate.h"
#import "RZSPView.h"
#import "RZSPLine.h"



@interface RZScaleplate (private)
-(void)layoutBorder;
-(void)initUI;
-(void)layoutScaleplate;
-(void)settingsScrollView;
@end

@implementation RZScaleplate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame oritation:(SPOrientation)oritation {
    if (self=[super initWithFrame:frame]) {
        self.oritation=oritation;
        self.miniValue=0.0;
        self.maxValue=1.0;
        self.stepValue=0.1;
        
        [self layoutBorder];
        [self initUI];
    }
    
    return self;
}

-(void)setValueChangedBlock:(void(^)(NSNumber *value))block {
    if (block) {
        self.block=block;
    }
}



-(void)layoutBorder {
    /////////draw border
    _topLayer=[CAShapeLayer new];
    [self.layer addSublayer:_topLayer];
    _topLayer.fillColor=nil;
    _topLayer.strokeColor=[UIColor lightGrayColor].CGColor;
    _topLayer.shadowColor=[UIColor blackColor].CGColor;
    _topLayer.shadowOffset=CGSizeMake(-1, 1);
    _topLayer.opacity=0.7f;
    
    _topLayer.frame=self.bounds;
    
    _topPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:3];
    _topLayer.path=_topPath.CGPath;
    
    
    /////////draw center line
    _lineLayer = [CAShapeLayer new];
    [self.layer addSublayer:_lineLayer];
    _lineLayer.fillColor=nil;
    _lineLayer.strokeColor=[UIColor colorWithRed:28/255.0 green:188/255.0 blue:156/255.0 alpha:1.0].CGColor;
    _linePath = [UIBezierPath bezierPath];
    if (self.oritation==Horizontal) {
        _lineLayer.frame=CGRectMake(_topLayer.frame.size.width/4, 2, 1, kMaxLineLength+5);
        [_linePath moveToPoint:_lineLayer.frame.origin];
        [_linePath addLineToPoint:CGPointMake(_lineLayer.frame.origin.x, CGRectGetMaxY(_lineLayer.frame))];
    }else{
        _lineLayer.frame=CGRectMake(2,_topLayer.frame.size.height/4,kMaxLineLength+5, 1);
        [_linePath moveToPoint:_lineLayer.frame.origin];
        [_linePath addLineToPoint:CGPointMake(CGRectGetMaxX(_lineLayer.frame),_lineLayer.frame.origin.y)];
    }
    
    
    _lineLayer.path=_linePath.CGPath;

}


-(void)initUI {
    /////////add bottom view
    self.scrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
    /////////settings uiscrollview
    self.scrollView.scrollEnabled=YES;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.delegate=self;

    [self addSubview:self.scrollView];

}
-(void)layoutScaleplate {
    
    sp_view=[[RZSPView alloc] initWithOritation:self.oritation];
    sp_view.miniValue=self.miniValue;
    sp_view.maxValue=self.maxValue;
    sp_view.stepValue=self.stepValue;

    [sp_view renderView];
    if (self.oritation==Horizontal)
        sp_view.frame=CGRectMake(0,5,sp_view.sp_width,self.bounds.size.height);
    else
        sp_view.frame=CGRectMake(5,0,self.bounds.size.width,sp_view.sp_height);
    
    
    //    view.frame=self.bounds;
    
    NSLog(@"view width:%f",sp_view.sp_width);
    
    [self.scrollView addSubview:sp_view];

}


-(void)layoutSubviews {
    if (nil==sp_view) {
        [self layoutScaleplate];
        [self settingsScrollView];
    }
//    [self settingsScrollView];
}


-(void)settingsScrollView {
    if(self.oritation==Horizontal) {
        self.scrollView.contentSize=CGSizeMake(sp_view.sp_width-5, self.scrollView.frame.size.height);
        self.scrollView.contentInset=UIEdgeInsetsMake(0, self.frame.size.width/2, 0, self.frame.size.width/2); /////top-right-bottom-left
        
        if ([self checkValue]) {
            CGFloat offsetX= 5*([_value floatValue]-self.miniValue)/self.stepValue-self.frame.size.width/2;   ////////根据得到的value公式，反向得到表达式 rey
            self.scrollView.contentOffset=CGPointMake(offsetX, self.scrollView.contentOffset.y);
        }else {
            self.scrollView.contentOffset=CGPointMake(-self.frame.size.width/2, 0);
        }
        
        
    }else {
        self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, sp_view.sp_height-5);
        self.scrollView.contentInset=UIEdgeInsetsMake(self.scrollView.frame.size.height/2, 0, self.scrollView.frame.size.height/2, 0); //////缩进
        
        
        if ([self checkValue]) {
            CGFloat offsetY= 5*(((self.maxValue+self.miniValue)-[_value floatValue])-self.miniValue)/self.stepValue-self.scrollView.frame.size.height/2;     ////////由于取值时，为使数据从大到小排列，用最大值self.maxValue减去取的值得到的结果，在反向时需要再反向回来  rey
            self.scrollView.contentOffset=CGPointMake(self.scrollView.contentOffset.x,offsetY);
            
        }else {
            self.scrollView.contentOffset=CGPointMake( 0,-self.scrollView.frame.size.height/2);
        }
        
        
    }

}

-(BOOL)checkValue {
    BOOL flag = NO;
    if (self.value) {
        if ([self.value floatValue]>=self.miniValue && [self.value floatValue] <= self.maxValue) {
            return YES;
        }else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"value property should between minValue and maxValue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    return flag;
}


#pragma mark UIScrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"contentoffset:%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"contentoffset:%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat value=0;
    if (self.oritation==Horizontal) {
        CGFloat halfWidth=self.frame.size.width/2;
        value=(scrollView.contentOffset.x+halfWidth)/5*self.stepValue+self.miniValue; /////除以5是因为每个标尺之间是5个像素 rey
    }else {
        CGFloat halfHeight=self.frame.size.height/2;
        value=(scrollView.contentOffset.y+halfHeight)/5*self.stepValue+self.miniValue;
        value = (self.maxValue + self.miniValue) - value;
//        value=self.maxValue-value;
    }
    
    if (value<self.miniValue)
        value=self.miniValue;
    if (value>self.maxValue)
        value=self.maxValue;
    
    NSLog(@"scaleplate value is:%f",value);
    NSString *n=[NSString stringWithFormat:@"%.1f",value];
    _value=[NSNumber numberWithFloat:[n floatValue]];
    
    if (self.block) {
        self.block(_value);
    }
}



-(void)setValue:(NSNumber *)value {
    _value=value;
    
    if (nil==sp_view)
        [self layoutScaleplate];
    
    [self settingsScrollView];
}

@end






