//
//  SGAddIngredienteViewController.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 09/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGAddIngredienteViewController : UIViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nomeField;
@property (strong, nonatomic) IBOutlet UITextField *quantidadeField;

- (IBAction)guardarButton:(id)sender;
- (IBAction)cancelarButton:(id)sender;

@property (nonatomic) id delegate;

@end
