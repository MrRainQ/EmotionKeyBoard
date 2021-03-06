//
//  HMComposePhotosView.h
//   
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMComposePhotosView : UIView

/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;

- (NSArray *)images;

@end
