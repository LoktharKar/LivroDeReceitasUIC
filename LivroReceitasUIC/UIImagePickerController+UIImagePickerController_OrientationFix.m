//
//  UIImagePickerController+UIImagePickerController_OrientationFix.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 09/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "UIImagePickerController+UIImagePickerController_OrientationFix.h"

@implementation UIImagePickerController (UIImagePickerController_OrientationFix)

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
