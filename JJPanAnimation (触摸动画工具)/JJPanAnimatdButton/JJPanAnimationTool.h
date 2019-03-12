//
//  JJPanAnimationTool.h
//  OneEightOne
//
//  Created by Joey Chan on 2019/3/11.
//  Copyright © 2019年 陈嘉健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJPanAnimationTool : NSObject
+ (instancetype)shareManager;
@property (nonatomic , strong) UIView *jj_PanAnimatdView;

/**
 注册需要展示动画的视图类名
 
 @param className 类名
 */
- (void)registeredClassWithClassName:(NSString *)className;

/**
 注册需要展示动画的视图类名
 
 @param classNames 类名数组
 */
- (void)registeredClassWithClassNames:(NSArray *)classNames;

/**
 还原全部动画效果
 */
- (void)reductionAllAnimated;


/**
 检查是否见识动画
 
 @param className 类名
 @return 是否
 */
- (BOOL)cheakCanPlayAnimationWithClassName:(NSString *)className;
@end

NS_ASSUME_NONNULL_END
