RZScaleplate
============
RZScaleplate是一个自定义的标尺控件。使用该控制可以在两个临界值内选择其中的某个值。该控件的使用场景可以用在选择如年龄，身高，体重等情形。项目中用到这个效果，故而写了这么一个控件。
[![](https://raw.github.com/ReyZhang/RZScaleplate/master/Screens/1.png)](https://raw.github.com/ReyZhang/RZScaleplate/master/Screens/1.png)
How to use
============
水平方向的标尺
``` objective-c
RZScaleplate *sp_H = [[RZScaleplate alloc]
                 initWithFrame:CGRectMake(20 , 120, 250, 50) oritation:Horizontal];
    
    sp_H.miniValue=0; ////临界点最小值
    sp_H.maxValue=100; ///临界点最大值
    sp_H.stepValue=1; /////每个刻度值
    sp_H.value=[NSNumber numberWithFloat:50]; //////初始值
    
    [sp_H setValueChangedBlock:^(NSNumber *value) {
        ///...标尺valuechanged时的回调block
    }];
    [self.view addSubview:sp_H];
```
垂直方向的标尺
``` objective-c
RZScaleplate *sp_V = [[RZScaleplate alloc]
                 initWithFrame:CGRectMake(20 , 120, 60, 200) oritation:Vertical];
    
    sp_V.miniValue=150; ////临界点最小值
    sp_V.maxValue=250; ///临界点最大值
    sp_V.stepValue=1; /////每个刻度值
    sp_V.value=[NSNumber numberWithFloat:175]; //////初始值
    
    [sp_V setValueChangedBlock:^(NSNumber *value) {
        ///...标尺valuechanged时的回调block
    }];
    [self.view addSubview:sp_V];
```
