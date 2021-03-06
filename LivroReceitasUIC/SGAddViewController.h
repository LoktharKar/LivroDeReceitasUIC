//
//  SGAddViewController.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 05/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGReceita.h"
#import "SGCollectionViewController.h"

@interface SGAddViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SGProtocolsADD_ING_PROC, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *nomeField;
@property (strong, nonatomic) IBOutlet UITextField *categoriaField;
@property (strong, nonatomic) IBOutlet UITextField *tempoField;
@property (strong, nonatomic) IBOutlet UITextField *porcoesField;
@property (strong, nonatomic) IBOutlet UISwitch *favoritoSwitch;

- (IBAction)guardarReceitaButton:(id)sender;

- (IBAction)adicionarIngredienteButton:(id)sender;
- (IBAction)adicionarProcedimentoButton:(id)sender;

- (IBAction)apagarIngrediente:(id)sender;
- (IBAction)apagarProcedimento:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *apagarIngredienteButtonText;
@property (strong, nonatomic) IBOutlet UIButton *apagarProcedimentoButtonText;

@property (strong, nonatomic) IBOutlet UIImageView *AdicionarImagemImage;
@property (strong, nonatomic) IBOutlet UIButton *adicionarImagemButton;

- (IBAction)addImage:(id)sender;

@property (nonatomic) id delegate;

@property (nonatomic) NSMutableArray *ingredientesINS;
@property (nonatomic) NSMutableArray *procedimentosINS;

@property (strong, nonatomic) IBOutlet UITableView *ingTable;
@property (strong, nonatomic) IBOutlet UITableView *procTable;

@end
