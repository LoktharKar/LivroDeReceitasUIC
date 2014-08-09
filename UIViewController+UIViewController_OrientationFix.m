//
//  UIViewController+UIViewController_OrientationFix.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 09/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "UIViewController+UIViewController_OrientationFix.h"

@implementation UIViewController (UIViewController_OrientationFix)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
