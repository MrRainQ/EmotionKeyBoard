//
//  HMEmotionTool.h
//   
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年  . All rights reserved.
//  管理表情数据：加载表情数据、存储表情使用记录

#import <Foundation/Foundation.h>
@class HMEmotion;

@interface HMEmotionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;

/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;

/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (HMEmotion *)emotionWithDesc:(NSString *)desc;

@end
