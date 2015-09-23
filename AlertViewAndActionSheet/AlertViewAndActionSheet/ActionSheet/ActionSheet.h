//
//  ActionSheet.h
//  AlertViewAndActionSheet
//
//  Created by MyMac on 15/9/23.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionSheet;
@protocol  ActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(ActionSheet *)actionSheet btnClick:(NSInteger)index;

@end

@interface ActionSheet : UIView

@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UILabel *desc;

@property (nonatomic,strong) UIButton *cancelButton;

@property (nonatomic,strong) NSMutableArray *btnArray;

@property (nonatomic,weak) id<ActionSheetDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title Desc:(NSString *)desc;

- (void)addCancelButtonTitle:(NSString *)title;

- (void)addButtonTitle:(NSString *)title;

- (void)show;

- (void)showInAnimation;

- (void)close;

- (void)closeInAnimation;

@end
