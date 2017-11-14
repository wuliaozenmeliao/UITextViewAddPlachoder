//
//  UITextView+ZYZTextView.h
//  TextView
//
//  Created by XinGou on 2017/11/14.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZYZTextView)
/*
 *占位符文字
 */
@property(nonatomic,strong)NSString *zyz_placeholder;
/*
 *占位符文字大小
 */
@property(nonatomic,strong)UIFont *zyz_placeholderFont;
/*
 *占位提示语标签
 */
@property(nonatomic,strong,readonly)UILabel *zyz_placeholderLabel;
@end
