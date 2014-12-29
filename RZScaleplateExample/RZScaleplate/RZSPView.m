//
//  RZSPView.m
//  HealthService
//
//  Created by Zhang Rey on 7/1/14.
//
//

#import "RZSPView.h"
#import "RZSPLine.h"




@implementation RZSPView

-(id)initWithOritation:(SPOrientation)oritation {
    if (self=[super init]) {
        self.oritation=oritation;
        _width=0;
        _height=0;
        self.backgroundColor=[UIColor clearColor];
    }
    
    return self;
}


-(void)renderView {
    
    int count=0;
    for (CGFloat i=self.miniValue; i<=self.maxValue; i=i+self.stepValue) {
        
        RZSPLine *line = [[RZSPLine alloc] initWithOritation:self.oritation isLong:(count%5==0)];
        
        
        if (self.oritation==Horizontal) {
            line.frame=CGRectMake(count*kSpace,0,2,15);
            _width+=kSpace;
            
            if (count%10==0) {
                UILabel *label=[[UILabel alloc] init];
                label.backgroundColor=[UIColor clearColor];

                NSString *n=[NSString stringWithFormat:@"%.1f",i];
                ////////using nsnumber
                NSNumber *number = [NSNumber numberWithFloat:[n floatValue]];
                NSString *str=[number stringValue];
                UIFont *font=[UIFont systemFontOfSize:10];
                CGSize size=CGSizeMake(200, 200);
                
                CGRect labelRect=[str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
                
                
                
                label.font=font;
                label.text=str;
                label.textColor=[UIColor darkGrayColor];
                
                label.frame=CGRectMake(line.frame.origin.x-labelRect.size.width/2, CGRectGetMaxY(line.frame)+5, labelRect.size.width+5, labelRect.size.height);
                
                [self addSubview:label];
            }
            
            
        }else {
            line.frame=CGRectMake(0,count*kSpace,kMaxLineLength,2);
            _height+=kSpace;
            
            
            
            if (count%10==0) {
                UILabel *label=[[UILabel alloc] init];
                label.backgroundColor=[UIColor clearColor];
                
                
                
                NSString *n=[NSString stringWithFormat:@"%.1f",self.maxValue - count*self.stepValue];
                ////////using nsnumber
                NSNumber *number = [NSNumber numberWithFloat:[n floatValue]];
                NSString *str=[number stringValue];
                
                UIFont *font=[UIFont systemFontOfSize:10];
                CGSize size=CGSizeMake(200, 200);
                
                CGRect labelRect=[str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
                
                
                
                label.font=font;
                label.text=str;
                label.textColor=[UIColor darkGrayColor];
                
                label.frame=CGRectMake(CGRectGetMaxX(line.frame)+6,line.frame.origin.y-labelRect.size.height/2, labelRect.size.width+5, labelRect.size.height);
                
                [self addSubview:label];
            }

            
        }
        
        [self addSubview:line];
        count++;
    }
}


-(CGFloat)sp_width {
    return _width;
}

-(CGFloat)sp_height {
    return _height;
}


@end