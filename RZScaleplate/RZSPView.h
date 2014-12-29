//
//  RZSPView.h
//  HealthService
//
//  Created by Zhang Rey on 7/1/14.
//
//

#import <UIKit/UIKit.h>

@interface RZSPView : UIView {
    CGFloat _width;
    CGFloat _height;
}

@property(nonatomic) SPOrientation oritation; /////oritation
@property(nonatomic) CGFloat stepValue;   /////accumulation step
@property (nonatomic) CGFloat miniValue;   ////minimum value
@property (nonatomic) CGFloat maxValue;       //////max value


-(id)initWithOritation:(SPOrientation)oritation;
-(CGFloat)sp_width;
-(CGFloat)sp_height;
-(void)renderView;
@end