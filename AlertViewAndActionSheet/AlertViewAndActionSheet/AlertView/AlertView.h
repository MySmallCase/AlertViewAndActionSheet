//
//  AlertView.h
//  AlertViewAndActionSheet
//
//  Created by MyMac on 15/9/22.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlertView;
@protocol AlertViewDelegate <NSObject>

@optional
- (void)alertView:(AlertView *)alertView btnClicked:(NSInteger)index;

@end

@interface AlertView : UIView



@property (nonatomic,strong) UIView *containView;

@property (nonatomic,assign) CGFloat containViewHeight;

@property (nonatomic,strong) NSArray *btnTitleArray;

@property (nonatomic,strong) NSMutableArray *btnArray;

@property (nonatomic,weak) id<AlertViewDelegate>delegate;

- (instancetype)initWithTitle:(NSString *)title WithDesc:(NSString *)desc;

- (void)setContainRect:(CGRect)rect;

- (void)showAnimation1;

- (void)showAnimation2;

@end
