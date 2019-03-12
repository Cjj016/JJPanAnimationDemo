//
//  JJPanAnimationTool.m
//  OneEightOne
//
//  Created by Joey Chan on 2019/3/11.
//  Copyright © 2019年 陈嘉健. All rights reserved.
//

#import "JJPanAnimationTool.h"
#import "UIView+JJPanAnimation.h"
@interface JJPanAnimationTool ()
@property (nonatomic , strong) NSMutableArray *registeredClassNames;
@end

@implementation JJPanAnimationTool

+ (instancetype)shareManager {
    static JJPanAnimationTool *config = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        config = [JJPanAnimationTool new];
    });
    return config;
}


/**
 注册需要展示动画的视图类名

 @param className 类名
 */
- (void)registeredClassWithClassName:(NSString *)className {
    if (![self.registeredClassNames containsObject:className]) {
        [self.registeredClassNames addObject:className];
    }
}


/**
 注册需要展示动画的视图类名
 
 @param classNames 类名数组
 */
- (void)registeredClassWithClassNames:(NSArray *)classNames {
    for (NSString *className in classNames) {
        if (![self.registeredClassNames containsObject:className]) {
            [self.registeredClassNames addObject:className];
        }
    }
}



/**
 检查是否见识动画

 @param className 类名
 @return 是否
 */
- (BOOL)cheakCanPlayAnimationWithClassName:(NSString *)className {
    return [self.registeredClassNames containsObject:className];
}


/**
 还原全部动画效果
 */
- (void)reductionAllAnimated {
    [self.jj_PanAnimatdView stopPanAnimated];
}

- (NSMutableArray *)registeredClassNames {
    if (!_registeredClassNames) {
        _registeredClassNames = [NSMutableArray array];
    }
    return _registeredClassNames;
}

- (void)setJj_PanAnimatdView:(UIView *)jj_PanAnimatdView {
    _jj_PanAnimatdView = jj_PanAnimatdView;
    [self findSupviewWithSubview:jj_PanAnimatdView];
}



/**
 寻找子视图的父视图，如果为滚动视图添加kvo监听滚动偏移

 @param subView 子视图
 */
- (void)findSupviewWithSubview:(UIView *)subView {
//    NSLog(@"subView.superview == %@",subView.superview);
    if (!subView) {
        return;
    }
    UIView *superView = subView.superview;
    
    if ([superView isKindOfClass:[UIScrollView class]]) {
        [superView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    } else if ([superView isKindOfClass:[UITableView class]]) {
        [superView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    } else if ([superView isKindOfClass:[UICollectionView class]]) {
        [superView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }

    [self findSupviewWithSubview:superView];
}


#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        NSValue *oldvalue = change[NSKeyValueChangeOldKey];
        NSValue *newvalue = change[NSKeyValueChangeNewKey];
        CGFloat oldoffset_y = oldvalue.UIOffsetValue.vertical;
        CGFloat newoffset_y = newvalue.UIOffsetValue.vertical;
//        NSLog(@"Old:%f\nNew:%f",oldoffset_y,newoffset_y);
        
        [[JJPanAnimationTool shareManager] reductionAllAnimated];
        
        if (newoffset_y > oldoffset_y)
        {
//            NSLog(@"向下滑动");
        }
        else if(newoffset_y < oldoffset_y)
        {
//            NSLog(@"向上滑动");
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
