//
//  LLPasswordView.h
//  LLInstalmentSDK
//
//  Created by zdy on 2017/2/9.
//  Copyright © 2017年 lianlian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLPasswordView;
@protocol LLPasswordViewDelegate <NSObject>

- (void)passwordViewDidChange:(LLPasswordView *)passwordView;
- (void)passwordViewCompleteInput:(LLPasswordView *)passwordView;
@end

@interface LLPasswordView : UIView<UIKeyInput>
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isSecure;

@property (nonatomic, strong) UIColor *normalBorderColor;
@property (nonatomic, strong) UIColor *selectedBorderColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) id<LLPasswordViewDelegate>delegate;
@end
