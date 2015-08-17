//
//  HMComposeToolbar.h
//   
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年  . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HMComposeToolbarButtonTypeCamera, // 照相机
    HMComposeToolbarButtonTypePicture, // 相册
    HMComposeToolbarButtonTypeMention, // 提到@
    HMComposeToolbarButtonTypeTrend, // 话题
    HMComposeToolbarButtonTypeEmotion // 表情
} HMComposeToolbarButtonType;

@class HMComposeToolbar;

@protocol HMComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(HMComposeToolbar *)toolbar didClickedButton:(HMComposeToolbarButtonType)buttonType;

@end

@interface HMComposeToolbar : UIView
@property (nonatomic, weak) id<HMComposeToolbarDelegate> delegate;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;
@end
