//
//  UIView+JJPanAnimation.m
//  OneEightOne
//
//  Created by Joey Chan on 2019/3/11.
//  Copyright © 2019年 陈嘉健. All rights reserved.
//

#import "UIView+JJPanAnimation.h"
#import "JJPanAnimationTool.h"
@implementation UIView (JJPanAnimation)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        // Gets the viewDidLoad method to the class,whose type is a pointer to a objc_method structure.
        Method originMethod = class_getInstanceMethod([self class], @selector(hitTest:withEvent:));
        
        // Get the method you created.
        Method newMethod = class_getInstanceMethod([self class], @selector(jj_panAnimation_hitTest:withEvent:));
        
        IMP newIMP = method_getImplementation(newMethod);
        
        BOOL isAdd = class_addMethod([self class], @selector(jj_panAnimation_hitTest:withEvent:), newIMP, method_getTypeEncoding(newMethod));
        
        if (isAdd) {
            // replace
            class_replaceMethod([self class], @selector(hitTest:withEvent:), newIMP, method_getTypeEncoding(newMethod));
        } else {
            // exchange
            method_exchangeImplementations(originMethod, newMethod);
            
        }
    });
}

#pragma mark - Exchange Method

- (UIView *)jj_panAnimation_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if ([[JJPanAnimationTool shareManager] cheakCanPlayAnimationWithClassName:NSStringFromClass([self class])]) {
        
        //判断是否合格
        if (!self.hidden && self.alpha > 0.01 && self.isUserInteractionEnabled) {
            //判断点击位置是否在自己区域内部
            if ([self pointInside: point withEvent:event]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [JJPanAnimationTool shareManager].jj_PanAnimatdView = self;
                    [self startPanAnimated];
                });
            }
        }
    }
    return [self jj_panAnimation_hitTest:point withEvent:event];
}


- (void)startPanAnimated {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(0.90, 0.90);
    }];
}

- (void)stopPanAnimated {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}



/*
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[JJPanAnimationTool shareManager] reductionAllAnimated];
    [super touchesMoved:touches withEvent:event];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[JJPanAnimationTool shareManager] reductionAllAnimated];
    [super touchesEnded:touches withEvent:event];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[JJPanAnimationTool shareManager] reductionAllAnimated];
    [super touchesCancelled:touches withEvent:event];
}
*/
@end
