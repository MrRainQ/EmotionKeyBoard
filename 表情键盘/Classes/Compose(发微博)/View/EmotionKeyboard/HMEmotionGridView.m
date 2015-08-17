//
//  HMEmotionGridView.m
//   
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年  . All rights reserved.
//

#import "HMEmotionGridView.h"
#import "HMEmotion.h"
#import "HMEmotionView.h"
#import "HMEmotionTool.h"

@interface HMEmotionGridView()
@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, assign) int emotionMaxCountPerPage;
@property (nonatomic, assign) int emotionMaxCols;

@end

@implementation HMEmotionGridView

- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

/**
 *  根据触摸点返回对应的表情控件
 */
- (HMEmotionView *)emotionViewWithPoint:(CGPoint)point
{
    __block HMEmotionView *foundEmotionView = nil;
    [self.emotionViews enumerateObjectsUsingBlock:^(HMEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(emotionView.frame, point)) {
            foundEmotionView = emotionView;
            // 停止遍历
            *stop = YES;
        }
    }];
    return foundEmotionView;
}


- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    int count = (int)emotions.count;
    int currentEmotionViewCount = (int)self.emotionViews.count;
    for (int i = 0; i<count; i++) {
        HMEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) { // emotionView不够用
            emotionView = [[HMEmotionView alloc] init];
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else { // emotionView够用
            emotionView = self.emotionViews[i];
        }
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    
    // 隐藏多余的emotionView
    for (int i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
}

/**
 *  监听表情的单击
 */
- (void)emotionClick:(HMEmotionView *)emotionView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 选中表情
        [self selecteEmotion:emotionView.emotion];
    });
}

- (void)setIsEmotion:(BOOL)isEmotion
{
    _isEmotion = isEmotion;
    
    if (_isEmotion) { // 是表情
        _emotionMaxCols = 7;
    }else{
        _emotionMaxCols = 3;
    }
    _emotionMaxCountPerPage = (HMEmotionMaxRows * _emotionMaxCols - 1);
}

/**
 *  选中表情
 */
- (void)selecteEmotion:(HMEmotion *)emotion
{
    if (emotion == nil) return;    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HMEmotionDidSelectedNotification object:nil userInfo:@{HMSelectedEmotion : emotion}];
}

/**
 *  点击了删除按钮
 */
- (void)deleteClick
{
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HMEmotionDidDeletedNotification object:nil userInfo:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    // 1.排列所有的表情
    int count = (int)self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / _emotionMaxCols;

    CGFloat emotionViewH = (self.height - topInset) / HMEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % _emotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / _emotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}

@end
