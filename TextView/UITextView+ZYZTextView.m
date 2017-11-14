//
//  UITextView+ZYZTextView.m
//  TextView
//
//  Created by XinGou on 2017/11/14.
//  Copyright © 2017年 XinGou. All rights reserved.
//

#import "UITextView+ZYZTextView.h"
#import <objc/runtime.h>
#import <Masonry.h>
//占位label的key
static const void *s_zyzTextViewPlaceholderLabelKey = @"s_zyzTextViewPlaceholderLabelKey";
//占位字符key
static const void *s_zyzTextViewPlaceholderTextKey = @"s_zyzTextViewPlaceholderTextKey";

@interface UIApplication (ZYZTextViewHolder)
@end
@implementation UIApplication (ZYZTextViewHolder)
-(void)zyz_placeholderTextChange:(NSNotification*)notification
{
    UITextView *textView = notification.object;
    if (![textView.text isEqualToString:@""]) {
        textView.zyz_placeholderLabel.text = @"";
    }else{
        textView.zyz_placeholderLabel.text= textView.zyz_placeholder;
    }
}
@end

@interface UITextView (ZYZPlaceholderLabel)
@property(nonatomic,strong)UILabel *pLabel;
@end
@implementation UITextView (ZYZPlaceholderLabel)
-(void)setPLabel:(UILabel *)pLabel
{
    //使用runtime添加一个属性创建一个label
    objc_setAssociatedObject(self, s_zyzTextViewPlaceholderLabelKey, pLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UILabel*)pLabel
{
    UILabel *label = objc_getAssociatedObject(self, s_zyzTextViewPlaceholderLabelKey);
    if (!label || ![label isKindOfClass:[UILabel class]]) {
        label = [[UILabel alloc] init];
        label.font = self.font;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        label.enabled = NO;
        self.pLabel = label;
        __weak typeof(self) weakSelf = self;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf).insets(UIEdgeInsetsMake(7.5, 5, 0, 0));
        }];
        //当textview发生改变的时候进行监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zyz_placeholderTextChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return label;
}
@end

@implementation UITextView (ZYZTextView)
-(void)zyz_placeholderTextChange:(NSNotification*)notification
{
    //接收监听当textview的text不为空的时候 占位label为空
    if (![self.text isEqualToString:@""]) {
        self.zyz_placeholderLabel.text = @"";
    }else{
        self.zyz_placeholderLabel.text = self.zyz_placeholder;
    }
}
-(UILabel*)zyz_placeholderLabel
{
    return self.pLabel;
}
-(void)setZyz_placeholder:(NSString *)zyz_placeholder
{
    //创建的时候是否添加上占位符，如果没有添加移除占位label
    if ([zyz_placeholder isEqualToString:@""]) {
        objc_setAssociatedObject(self, s_zyzTextViewPlaceholderTextKey, zyz_placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.pLabel removeFromSuperview];
        return;
    }
    objc_setAssociatedObject(self, s_zyzTextViewPlaceholderTextKey, zyz_placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (![self.text isEqualToString:@""]) {
        self.zyz_placeholderLabel.text = @"";
    }else{
        self.zyz_placeholderLabel.text = self.zyz_placeholder;
    }
}
-(NSString*)zyz_placeholder
{
    return objc_getAssociatedObject(self, s_zyzTextViewPlaceholderTextKey);
}
-(void)setZyz_placeholderFont:(UIFont *)zyz_placeholderFont
{
    self.pLabel.font = zyz_placeholderFont;
}
-(UIFont*)zyz_placeholderFont
{
    return self.pLabel.font;
}
@end
