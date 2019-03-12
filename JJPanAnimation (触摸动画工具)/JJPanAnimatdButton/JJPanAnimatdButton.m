//
//  JJPanAnimatdButton.m
//  OneEightOne
//
//  Created by Joey Chan on 2019/3/11.
//  Copyright © 2019年 陈嘉健. All rights reserved.
//

#import "JJPanAnimatdButton.h"

@implementation JJPanAnimatdButton

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[JJPanAnimationTool shareManager] reductionAllAnimated];
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[JJPanAnimationTool shareManager] reductionAllAnimated];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[JJPanAnimationTool shareManager] reductionAllAnimated];
    [super touchesEnded:touches withEvent:event];
}

@end
