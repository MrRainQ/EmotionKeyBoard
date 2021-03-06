//
//  HMEmotionListView.h
//   
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2014年  . All rights reserved.
//  表情列表（能展示多页表情）

#import <UIKit/UIKit.h>

@interface HMEmotionListView : UIView
/** 需要展示的所有表情 */
@property (nonatomic, strong) NSArray *emotions;
@property (nonatomic, assign ,getter = isEmojiEmotion) BOOL isEmotion;

@end
