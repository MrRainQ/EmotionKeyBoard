//
//  HMEmotionGridView.h
//   
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年  . All rights reserved.
//  一个HMEmotionGridView展示一页的表情

#import <UIKit/UIKit.h>

@interface HMEmotionGridView : UIView
/** 需要展示的所有表情 */
@property (nonatomic, strong) NSArray *emotions;
@property (nonatomic, assign ,getter = isEmojiEmotion) BOOL isEmotion;

@end
