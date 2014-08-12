//
//  SGDetailsViewController.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 27/07/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGReceita.h"
#import "SGCollectionViewController.h"

@interface SGDetailsViewController : UIViewController <UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) SGReceita *receita;

@property (strong, nonatomic) IBOutlet UILabel *nomeField;
@property (strong, nonatomic) IBOutlet UILabel *categoriaField;
@property (strong, nonatomic) IBOutlet UILabel *tempoField;
@property (strong, nonatomic) IBOutlet UILabel *porcoesField;
@property (strong, nonatomic) IBOutlet UISwitch *favoritoField;
@property (strong, nonatomic) IBOutlet UIImageView *imageField;

@property (strong, nonatomic) IBOutlet UITableView *ingredientesTable;
@property (strong, nonatomic) IBOutlet UITableView *procedimentosTable;

@property (nonatomic) NSArray *ingredientes;
@property (nonatomic) NSArray *procedimentos;

- (IBAction)editReceita:(id)sender;
- (IBAction)favoritoButton:(id)sender;
- (IBAction)apagarReceita:(id)sender;

@property (nonatomic) id delegate;

@end
