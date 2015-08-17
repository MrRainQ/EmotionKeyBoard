//
//  RQCommentToolBar.h
//  diyidan
//
//  Created by apple on 15/3/11.
//  Copyright (c) 2015年 diyidan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmotionTextView;
typedef enum {
    RQCommentToolbarButtonTypeEmotion, // 表情
    RQCommentToolbarButtonTypeSend,    // 话题
} RQCommentToolbarButtonType;

@class RQCommentToolBar;

@protocol RQCommentToolBarDelegate <NSObject>

@optional
- (void)commentTool:(RQCommentToolBar *)toolbar didClickedButton:(RQCommentToolbarButtonType)buttonType;
- (void)commentCoverBtnClick;

@end
@interface RQCommentToolBar : UIView
@property (nonatomic, weak) id<RQCommentToolBarDelegate> delegate;
@property (nonatomic, strong) HMEmotionTextView *textView;
@property (nonatomic,   weak) UIButton *sendBtn;

@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;
@end
