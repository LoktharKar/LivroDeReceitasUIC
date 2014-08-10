//
//  SGAddProcedimentoViewController.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 10/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGAddProcedimentoViewController : UIViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextView *procedimentoField;

- (IBAction)cancelarButton:(id)sender;
- (IBAction)guardarButton:(id)sender;

@property (nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) IBOutlet UILabel *tituloField;

@property (nonatomic) id delegate;

@end
