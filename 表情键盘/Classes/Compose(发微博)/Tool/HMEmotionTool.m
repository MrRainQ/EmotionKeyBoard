//
//  HMEmotionTool.m
//   
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年  . All rights reserved.
//

#import "HMEmotionTool.h"
#import "HMEmotion.h"
#import "MJExtension.h"

@implementation HMEmotionTool

/** 默认表情 */
static NSArray *_defaultEmotions;

/** 浪小花表情 */
static NSArray *_lxhEmotions;

/** 最近表情 */
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [HMEmotion objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [HMEmotion objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (HMEmotion *)emotionWithDesc:(NSString *)desc
{
    if (!desc) return nil;
    
    __block HMEmotion *foundEmotion = nil;
    
    // 从默认表情中找
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(HMEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    if (foundEmotion) return foundEmotion;
    
    // 从浪小花表情中查找
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(HMEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    return foundEmotion;
}
@end
