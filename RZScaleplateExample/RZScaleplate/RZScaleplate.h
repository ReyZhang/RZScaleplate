//
//  RZscaleplate.h
//  HealthService
//
//  Created by Zhang Rey on 7/1/14.
//
//

#import <UIKit/UIKit.h>
#import "GeneralEnum.h"


typedef void(^ValueChangedBlock)(NSNumber *value);
@class RZSPView;
@interface RZScaleplate : UIView <UIScrollViewDelegate>{
    CAShapeLayer *_topLayer;
    UIBezierPath *_topPath;
    
    CAShapeLayer *_lineLayer;
    UIBezierPath *_linePath;
    RZSPView *sp_view;
}

@property(nonatomic) SPOrientation oritation; /////oritation
@property(nonatomic) CGFloat stepValue;   /////accumulation step
@property (nonatomic) CGFloat miniValue;   ////minimum value
@property (nonatomic) CGFloat maxValue;       //////max value
@property (nonatomic) NSNumber  *value;      ///////current choose value
@property (nonatomic,strong) ValueChangedBlock block;
@property (nonatomic,strong) UIScrollView *scrollView;

-(id)initWithFrame:(CGRect)frame oritation:(SPOrientation)oritation;
-(void)setValueChangedBlock:(void(^)(NSNumber *value))block;

@end




