//
//  TestViewController.m
//  JJPanAnimationDemo
//
//  Created by Joey Chan on 2019/3/12.
//  Copyright © 2019年 Joey Chan. All rights reserved.
//

#import "TestViewController.h"
#import "JJPanAnimatdButton.h"
// use to iPad
#define isIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// use to iphone 5,5s,6,7,8
#define isIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// use to iphone 6P,7P,8P
#define isIPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
// use to iphoneX,XR,XS,XS Max
#define isIPhoneFill (([UIScreen mainScreen].bounds.size.height == 812) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO))

#define kNavigationHeight (isIPhoneFill?88:64)

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupButtons];
}

- (void)setupButtons {
    for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 3; x++) {
            JJPanAnimatdButton *button = [JJPanAnimatdButton new];
            [self.view addSubview:button];
            button.frame = CGRectMake(5 + (self.view.frame.size.width/3) * x, kNavigationHeight + 5 + (self.view.frame.size.width/3 + 5 ) * y, self.view.frame.size.width/3 - 15, self.view.frame.size.width/3 - 15);
            
            [button setImage:[UIImage imageNamed:@"可达鸭.jpg"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"可达鸭.jpg"] forState:UIControlStateHighlighted];
            button.layer.shadowColor = [UIColor blackColor].CGColor;
            button.layer.shadowOffset = CGSizeMake(0, 1);
            button.layer.shadowRadius = 5;
            button.layer.shadowOpacity = 0.5;
            button.layer.cornerRadius = 4.0;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
