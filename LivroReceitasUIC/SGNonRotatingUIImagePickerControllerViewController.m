//
//  SGNonRotatingUIImagePickerControllerViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 06/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGNonRotatingUIImagePickerControllerViewController.h"

@interface SGNonRotatingUIImagePickerControllerViewController ()
@end

@implementation SGNonRotatingUIImagePickerControllerViewController

// para impedir que de erro ao nao inverter
- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orient {
    return (orient == UIInterfaceOrientationLandscapeLeft) | (orient == UIInterfaceOrientationLandscapeRight);
}
@end
