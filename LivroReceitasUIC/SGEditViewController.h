//
//  SGEditViewController.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 08/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGReceita.h"
#import "SGCollectionViewController.h"

@interface SGEditViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property SGReceita *receita;

@property (strong, nonatomic) IBOutlet UITextField *nomeField;
@property (strong, nonatomic) IBOutlet UITextField *categoriaField;
@property (strong, nonatomic) IBOutlet UITextField *tempoField;
@property (strong, nonatomic) IBOutlet UITextField *porcoesField;
@property (strong, nonatomic) IBOutlet UISwitch *favoritoSwitch;

@property (strong, nonatomic) IBOutlet UITableView *ingredientesTableField;
@property (strong, nonatomic) IBOutlet UITableView *procedimentoTableField;

- (IBAction)guardarAlteracoesButton:(id)sender;
- (IBAction)adicionarIngredienteButton:(id)sender;
- (IBAction)adicionarProcedimentoButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *editarImagemImage;
@property (strong, nonatomic) IBOutlet UIButton *adicionarImagemButton;

- (IBAction)adicionarImagemButton:(id)sender;

@property (nonatomic) id delegate;

@end
