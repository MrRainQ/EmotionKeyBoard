//
//  RQCommentToolBar.m
//  diyidan
//
//  Created by apple on 15/3/11.
//  Copyright (c) 2015年 diyidan. All rights reserved.
//

#import "RQCommentToolBar.h"
#import "HMEmotionTextView.h"
#import "HMEmotion.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface RQCommentToolBar()<UITextViewDelegate>
@property (nonatomic,weak) UIButton *emotionButton;
@property (nonatomic, weak) UIButton *coverBtn;

@end

@implementation RQCommentToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];

        // 添加所有的子控件        
        self.emotionButton = [self addButtonWithIcon:@"Album_ToolViewEmotion" highIcon:@"Album_ToolViewEmotionHL" tag:RQCommentToolbarButtonTypeEmotion];
        self.emotionButton.bounds = CGRectMake(0, 0, 36, 36);
        self.emotionButton.center = CGPointMake(22, 20);
        
        UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 48, 5, 40, 30)];
        sendBtn.tag = RQCommentToolbarButtonTypeSend;
        [sendBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn setTitleColor:kColor(79, 81, 83) forState:UIControlStateNormal];
        sendBtn.layer.borderColor = [kColor(193, 195, 201) CGColor];
        sendBtn.backgroundColor = kColor(242, 242, 245);
        sendBtn.layer.borderWidth = 0.5;
        sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.sendBtn = sendBtn;
        [self addSubview:sendBtn];


        self.textView = [[HMEmotionTextView alloc]initWithFrame:CGRectMake(45, 5, kScreenWidth - 100, 30)];
        self.textView.showsVerticalScrollIndicator = NO;
        self.textView.showsHorizontalScrollIndicator = NO;
        self.textView.bounces = NO;
        self.textView.font = [UIFont systemFontOfSize:15];
        self.textView.contentInset = UIEdgeInsetsZero;
        self.textView.layer.borderColor = [kColor(193, 195, 201) CGColor];
        self.textView.layer.cornerRadius = 2;
        self.textView.layer.borderWidth = 0.5;
        self.textView.placehoder = @"请输入评论";
        self.textView.backgroundColor = kColor(252, 252, 255);
        self.textView.delegate = self;
        [self addSubview:self.textView];
        
        UIButton *cover = [[UIButton alloc]initWithFrame:CGRectMake(45, 5, kScreenWidth - 100, 30)];
        cover.adjustsImageWhenHighlighted = NO;
        cover.hidden = YES;
        [cover addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.coverBtn = cover;
    }
    return self;
}


- (void)click
{
    self.coverBtn.hidden = YES;
    if ([_delegate respondsToSelector:@selector(commentCoverBtnClick)]) {
        [_delegate commentCoverBtnClick];
    }
}

- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(RQCommentToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(commentTool:didClickedButton:)]) {
        [self.delegate commentTool:self didClickedButton:(int)button.tag];
    }
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    if (showEmotionButton) { // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"Album_ToolViewEmotion"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"Album_ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        self.coverBtn.hidden = YES;

    } else { // 切换为键盘按钮
        self.coverBtn.hidden = NO;

        [self.emotionButton setImage:[UIImage imageNamed:@"Album_ToolViewKeyboard"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"Album_ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - textView代理方法
- (void)textViewDidChange:(UITextView *)textView
{
    [self adjustTextInputHeightForText:textView.attributedText];
}

// 高度变化
- (void)adjustTextInputHeightForText:(NSAttributedString *)text
{
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(kScreenWidth - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
//    NSLog(@"width = %f height = %f",textSize.width,textSize.height);
    CGFloat magin = 30 - 17.895;
    
  
    CGFloat h = textSize.height + magin;
    if (h <= 30) {
        h = 30;
    }
    self.textView.frame = CGRectMake(45, 5, kScreenWidth - 100, h);
    self.frame = CGRectMake(0, 0, kScreenWidth, h + 14);
}


@end
