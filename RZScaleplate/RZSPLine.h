//
//  RZSPLine.h
//  HealthService
//
//  Created by Zhang Rey on 7/1/14.
//
//

#import <UIKit/UIKit.h>

@interface RZSPLine : UIView
@property(nonatomic) SPOrientation oritation; /////oritation
@property(nonatomic) BOOL isLong;

-(id)initWithOritation:(SPOrientation)oritation isLong:(BOOL)isLong;
@end
