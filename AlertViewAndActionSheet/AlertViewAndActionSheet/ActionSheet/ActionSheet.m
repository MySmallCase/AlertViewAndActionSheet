//
//  ActionSheet.m
//  AlertViewAndActionSheet
//
//  Created by MyMac on 15/9/23.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ActionSheet.h"


@interface ActionSheet ()
{
    CGFloat width;
    CGFloat height;
    UIView *titleView;
    UIView *bottom;
    UIView *allBottom;
    UIView *layView;
    BOOL InAnimate;
}
@end

@implementation ActionSheet

- (instancetype)init{
    self = [super init];
    if (self) {
        [self Initialization];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title Desc:(NSString *)desc{
    self = [super init];
    if (self) {
        [self Initialization];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width*0.9, 15)];
        _title.font = [UIFont systemFontOfSize:14];
        [_title setAdjustsFontSizeToFitWidth:true];
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = title;
        
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, width*0.9, 15)];
        [_desc setAdjustsFontSizeToFitWidth:true];
        _desc.font = [UIFont systemFontOfSize:12];
        _desc.textColor = [UIColor whiteColor];
        _desc.textAlignment = NSTextAlignmentCenter;
        _desc.text = desc;
        
        titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width * 0.9, 49.5)];
        titleView.backgroundColor = [UIColor colorWithRed:(CGFloat)52/255 green:(CGFloat)170/255 blue:(CGFloat)135/255 alpha:1];
        [titleView addSubview:_title];
        [titleView addSubview:_desc];
        
    }
    return self;
}

/**
 *  初始化
 */
- (void)Initialization{
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, 0, width, height);
    self.btnArray = [NSMutableArray array];
    InAnimate = NO;
}

/**
 *  添加取消按钮
 */
- (void)addCancelButtonTitle:(NSString *)title{
    self.cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:title forState:normal];
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.layer.masksToBounds = true;
    self.cancelButton.backgroundColor = [UIColor brownColor];
    [self.cancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  添加按钮
 */
- (void)addButtonTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = _btnArray.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor colorWithRed:(CGFloat)52/255 green:(CGFloat)170/255 blue:(CGFloat)135/255 alpha:1];
    [btn setTitle:title forState:normal];
    [_btnArray addObject:btn];
}

/**
 *  按钮点击动作
 */
- (void)buttonClick:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    [self.delegate actionSheet:self btnClick:btn.tag];
    [self close];
}


/**
 *  展示动画
 */
- (void)show{
    CGFloat bottomHeight = 0;
    if (titleView) {
        bottomHeight += 50;
    }
    
    bottomHeight += 40*_btnArray.count;
    
    bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width*0.9, bottomHeight)];
    bottom.layer.cornerRadius = 5;
    bottom.layer.masksToBounds = true;
    
    if (self.cancelButton) {
        bottomHeight += 56;
    }
    
    allBottom = [[UIView alloc]initWithFrame:CGRectMake(width*0.05, height, width*0.9, bottomHeight)];
    
    
    
    CGFloat btnY = 0;
    if (titleView) {
        [bottom addSubview:titleView];
        btnY +=50;
    }
    for (UIButton *btn in _btnArray) {
        CGRect rect = CGRectMake(0, btnY, width * 0.9, 39.5);
        btn.frame = rect;
        [bottom addSubview:btn];
        btnY += 40;
    }
    
    [allBottom addSubview:bottom];
    
    if (self.cancelButton) {
        btnY += 8;
        CGRect rect = CGRectMake(0, btnY, width * 0.9, 39.5);
        self.cancelButton.frame = rect;
        [allBottom addSubview:self.cancelButton];
    }
    
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    layView = [[UIView alloc]initWithFrame:self.frame];
    layView.backgroundColor = [UIColor grayColor];
    layView.alpha = 0;
    [self addSubview:layView];
    [self addSubview:allBottom];

    [UIView animateWithDuration:0.2 animations:^{
        allBottom.frame = CGRectMake(width*0.05, height - bottomHeight, width*0.9, bottomHeight);
        layView.alpha = 0.2;
    }];
}

- (void)showInAnimation{
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    layView = [[UIView alloc]initWithFrame:self.frame];
    layView.backgroundColor = [UIColor grayColor];
    layView.alpha = 0;
    [self addSubview:layView];
    InAnimate = YES;
    
    NSMutableArray *viewArray = [[NSMutableArray alloc]init];
    if (titleView) {
        [viewArray addObject:titleView];
    }
    [viewArray addObjectsFromArray:_btnArray];
    [self cornerRadiu:viewArray.firstObject];
    
    
    CGFloat btnY = height - 8 - 40;
    /**
     *  i是一个标记位  1 表示从左边进入 0 表示从右边进入
     */
    CGFloat i = 1;
    if (self.cancelButton) {
        CGFloat x;
        if (i) {
            x = -width*0.9;
            i = 0;
        }else{
            x = width;
            i = 1;
        }
        CGRect rect = CGRectMake(x, btnY, width*0.9, 40);
        self.cancelButton.frame = rect;
        [self addSubview:self.cancelButton];
        btnY -= 48;
    }
    for (int j = (int)viewArray.count - 1; j >= 0; j--) {
        UIView *btn = (UIView *)viewArray[j];
        CGFloat x;
        if (i) {
            x = -width*0.9;
            i = 0;
        }else{
            x = width;
            i = 1;
        }
        if (j==0 && titleView) {
            CGRect rect = CGRectMake(x, btnY, width*0.9, 49.5);
            btn.frame = rect;
        }else{
            CGRect rect = CGRectMake(x, btnY, width*0.9, 39.5);
            btn.frame = rect;
        }
        btnY -= 40;
        if (j == 1) {
            btnY -= 10; //当为倒数第二个时  也就是接下来是第一个title Y往上多移10
        }
        [self addSubview:btn];
    }
    
    
    __block double delay = 0;
    double duration = 0.1 * viewArray.count + 0.1;
    if (self.cancelButton) {
        duration += 0.2;
    }
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedOptions animations:^{
        for (UIView *view in viewArray) {
            [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.3 animations:^{
                CGRect rect = view.frame;
                rect.origin.x = width * 0.05;
                view.frame = rect;
            }];
            delay = delay + 0.2;
        }
        if (self.cancelButton) {
            [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.2 animations:^{
                CGRect rect = self.cancelButton.frame;
                rect.origin.x = width * 0.05;
                self.cancelButton.frame = rect;
            }];
            delay = delay + 0.2;
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        layView.alpha = 0.2;
    }];
    
}
/**
 *  退出动画
 */
-(void)close{
    if (InAnimate) {
        [self closeInAnimation];
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = allBottom.frame;
        rect.origin.y = height;
        allBottom.frame = rect;
        layView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



-(void)closeInAnimation{
    
    
    
    NSMutableArray *viewArray = [[NSMutableArray alloc]init];
    if (titleView) {
        [viewArray addObject:titleView];
    }
    [viewArray addObjectsFromArray:_btnArray];
    if (self.cancelButton) {
        [viewArray addObject:self.cancelButton];
    }
    
    /**
     *  i是一个标记位  1 表示从左边出去 0 表示从右边出去
     */
    __block CGFloat i = 1;
    
    __block double delay = 0;
    double duration = 0.1 * viewArray.count + 0.1;
    if (self.cancelButton) {
        duration += 0.1;
    }
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedOptions animations:^{
        for (UIView *view in viewArray) {
            __block CGRect rect = view.frame;
            if (i) {
                rect.origin.x = -width*0.9;
                i = 0;
            }else{
                rect.origin.x = width;
                i = 1;
            }
            [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.2 animations:^{
                view.frame = rect;
            }];
            delay = delay + 0.2;
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        layView.alpha = 0;
    }];
    
}
/**
 *  画上面两个圆角
 */
- (void)cornerRadiu:(UIView *)view{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
