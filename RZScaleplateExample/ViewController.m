//
//  ViewController.m
//  RZScaleplateExample
//
//  Created by Zhang Rey on 12/29/14.
//  Copyright (c) 2014 Zhang Rey. All rights reserved.
//

#import "ViewController.h"
#import "RZScaleplate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *heightTF;
@property (weak, nonatomic) IBOutlet UITextField *xibTF;
@property (weak, nonatomic) IBOutlet RZScaleplate *sp_xib;
@property(nonatomic,strong) RZScaleplate *sp_H;
@property(nonatomic,strong) RZScaleplate *sp_V;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /////水平标尺
    self.sp_H = [[RZScaleplate alloc]
                 initWithFrame:CGRectMake(20 , 120, 250, 50) oritation:Horizontal];
    
    self.sp_H.miniValue=0;
    self.sp_H.maxValue=100;
    self.sp_H.stepValue=1;
    self.sp_H.value=[NSNumber numberWithFloat:50];
    
    __weak typeof(self) weakSelf = self;
    
    [self.sp_H setValueChangedBlock:^(NSNumber *value) {
        weakSelf.ageTF.text=[NSString stringWithFormat:@"%d",[value intValue]];
    }];
    
    self.ageTF.text=[NSString stringWithFormat:@"%d",[self.sp_H.value intValue]];
    
    /////垂直标尺
    self.sp_V = [[RZScaleplate alloc]
                 initWithFrame:CGRectMake(20 , 250, 60, 200) oritation:Vertical];
    
    self.sp_V.miniValue=150;
    self.sp_V.maxValue=250;
    self.sp_V.stepValue=1;
    self.sp_V.value=[NSNumber numberWithFloat:175]; /////初始值

    [self.sp_V setValueChangedBlock:^(NSNumber *value) {
        weakSelf.heightTF.text = [NSString stringWithFormat:@"%d cm",[value intValue]];
    }];

    self.heightTF.text=[NSString stringWithFormat:@"%d cm",[self.sp_V.value intValue]];
    
    [self.view addSubview:self.sp_H];
    [self.view addSubview:self.sp_V];
    
    self.sp_xib.backgroundColor=[UIColor clearColor];
    self.sp_xib.miniValue = 2.1;
    self.sp_xib.maxValue  = 10.1;
    self.sp_xib.stepValue=0.1;
    self.sp_xib.value= [NSNumber numberWithFloat:5.5];

    [self.sp_xib setValueChangedBlock:^(NSNumber *value) {
        weakSelf.xibTF.text= [NSString stringWithFormat:@"%.1f",[value floatValue]];
    }];
    
    self.xibTF.text= [NSString stringWithFormat:@"%.1f",[self.sp_xib.value floatValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
