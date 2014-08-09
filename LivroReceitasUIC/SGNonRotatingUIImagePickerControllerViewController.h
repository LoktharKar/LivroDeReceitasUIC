//
//  SGNonRotatingUIImagePickerControllerViewController.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 06/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGNonRotatingUIImagePickerControllerViewController : UIImagePickerController

- (BOOL)shouldAutorotate;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orient;

@end
