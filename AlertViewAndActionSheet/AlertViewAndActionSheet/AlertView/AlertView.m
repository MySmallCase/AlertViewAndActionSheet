//
//  AlertView.m
//  AlertViewAndActionSheet
//
//  Created by MyMac on 15/9/22.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "AlertView.h"
#import <POP.h>

#define green_Color [UIColor colorWithRed:102.0/255.0 green:195.0/255.0 blue:165.0/255.0 alpha:1.0f]


static const int titleHeight = 30;
static const int descMargin = 10;

@interface AlertView ()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *descLabel;

@property (nonatomic,assign) CGRect containRect;

@property (nonatomic,strong) UIView *bottom;

@property (nonatomic,strong) UIView *layView;

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGFloat btnWidth;

@end

@implementation AlertView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self Initialization];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title WithDesc:(NSString *)desc{
    self = [super init];
    if (self) {
        [self Initialization];
        
        self.titleLabel.text = title;
        [self.containView addSubview:self.titleLabel];
        
        self.descLabel.text = desc;
        CGSize size = [desc boundingRectWithSize:CGSizeMake(self.bottom.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.descLabel.font} context:nil].size;
        self.descLabel.frame = CGRectMake(descMargin, titleHeight, self.bottom.frame.size.width - descMargin * 2, size.height);
        self.containViewHeight = size.height + titleHeight;
        [self.containView addSubview:self.descLabel];
    }
    return self;
}

/**
 *  初始化
 */
- (void)Initialization{
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, 0, self.width, self.height);
    self.containViewHeight = 50;
    
    self.layView = [[UIView alloc] initWithFrame:self.frame];
    self.layView.backgroundColor = [UIColor grayColor];
    self.layView.alpha = 0.0;
    [self addSubview:self.layView];
    
    self.bottom = [[UIView alloc] initWithFrame:CGRectMake(self.width * 0.1, -100, self.width * 0.8, 50 + self.containViewHeight)];
    self.bottom.backgroundColor = [UIColor whiteColor];
    self.bottom.layer.masksToBounds = YES;
    self.bottom.layer.cornerRadius = 5;
    [self addSubview:self.bottom];

    self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width * 0.8, self.containViewHeight)];
    [self.bottom addSubview:self.containView];
    self.btnArray = [[NSMutableArray alloc] init];
    
}

- (void)setContainRect:(CGRect)rect{
    self.containRect = rect;
}

- (void)showAnimation1{
    [self initUI];
    [self showAction1];
}

- (void)showAnimation2{
    [self initUI];
    self.bottom.frame = CGRectMake((self.width - self.width/3)/2, (self.height - self.width/3)/2, self.width/3, self.width/3);
    [self showAction2];
    
}

- (void)initUI{
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    self.btnWidth = (self.width * 0.8) / self.btnTitleArray.count;
    
    self.containView.frame = CGRectMake(0, 0, self.width * 0.8, self.containViewHeight);
    self.bottom.frame = CGRectMake(self.width * 0.1, -100, self.width * 0.8, 50 + self.containViewHeight);
    
    for (int i = 0; i < self.btnTitleArray.count; i ++) {
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * self.btnWidth, self.containViewHeight + 10, self.btnWidth, 40)];
        [titleBtn setTitle:self.btnTitleArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:green_Color forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [titleBtn addTarget:self action:@selector(closeAction1:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.tag = self.btnArray.count;
        [self.btnArray addObject:titleBtn];
        [self.bottom addSubview:titleBtn];
        if (i != 0) {
            UIView *sp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
            sp.backgroundColor = green_Color;
            sp.alpha = 0.2;
            [titleBtn addSubview:sp];
        }
    }
    UIView *sp = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom.frame.size.height - 40, self.bottom.frame.size.width, 1)];
    sp.backgroundColor = green_Color;
    [self.bottom addSubview:sp];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.layView.alpha = 0.4;
    }];
}

-(void)closeAction1:(UIButton *)btn{
    POPBasicAnimation *transform = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transform.fromValue = @(0);
    transform.toValue = @(M_PI/2);
    transform.duration = 0.3;
    [self.bottom.layer pop_addAnimation:transform forKey:@""];
    
    POPBasicAnimation *Opacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    Opacity.fromValue = @(0.2);
    Opacity.toValue = @(0);
    Opacity.duration = 0.5;
    [self.layView.layer pop_addAnimation:Opacity forKey:@""];
    
    
    
    POPSpringAnimation *move = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    move.fromValue = @(self.bounds.size.height/2);
    move.toValue = @(self.bounds.size.height+self.width);
    move.beginTime = CACurrentMediaTime();
    move.springSpeed = 5;
    move.springBounciness = 2;
    [self.bottom pop_addAnimation:move forKey:@""];
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self removeFromSuperview];
    });
    [self.delegate alertView:self btnClicked:btn.tag];
    
}

- (void)showAction1{
    POPBasicAnimation *transform = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transform.fromValue = @(-M_PI_2);
    transform.toValue = @(0);
    transform.duration = 0.3;
    [self.bottom.layer pop_addAnimation:transform forKey:@""];
    
    POPSpringAnimation *move = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    move.fromValue = @(0);
    move.toValue = @(self.bounds.size.height / 2);
    move.beginTime = CACurrentMediaTime();
    move.springSpeed = 5;
    move.springBounciness = 10;
    [self.bottom pop_addAnimation:move forKey:@""];
    
}

- (void)showAction2{
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bottom.frame = CGRectMake(self.width * 0.1, (self.height - _containViewHeight - 50)/2, self.width * 0.8, _containViewHeight + 50);
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - getter and setter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = green_Color;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.frame = CGRectMake(0, 0, self.bottom.frame.size.width, titleHeight);
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = green_Color;
        _descLabel.font = [UIFont systemFontOfSize:14.0];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}





@end
