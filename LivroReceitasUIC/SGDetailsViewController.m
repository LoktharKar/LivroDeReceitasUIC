//
//  SGDetailsViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 27/07/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGDetailsViewController.h"
#import "SGCollectionViewController.h"
#import "SGEditViewController.h"
#import "SGReceita.h"

@interface SGDetailsViewController ()

@end

@implementation SGDetailsViewController

static BOOL favoriteINS;

@synthesize receita;

@synthesize ingredientes;
@synthesize procedimentos;

@synthesize ingredientesTable;
@synthesize procedimentosTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nomeField.text = receita.nome;
    self.categoriaField.text = receita.categoria;
    self.tempoField.text = [receita.tempoDePreparacao stringValue];
    self.porcoesField.text = [receita.porcoes stringValue];
    self.favoritoField.on = receita.favorito;
    self.imageField.image = receita.imagem;
    self.ingredientes = receita.ingredientes;
    self.procedimentos = receita.procedimentos;
    
    favoriteINS = receita.favorito;
    
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated{
    if(receita.favorito != favoriteINS){
        receita.favorito = favoriteINS;
        
        if([[self delegate] respondsToSelector:@selector(editarReceita:)]){
            [[self delegate] editarReceita:receita];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)editReceita:(id)sender {
    SGEditViewController *editar = [self.storyboard instantiateViewControllerWithIdentifier:@"editar"];
    editar.receita = receita;
    
    if(receita.favorito != favoriteINS){
        receita.favorito = favoriteINS;
    }
    
    editar.delegate = self.delegate;
    
    [self.navigationController pushViewController:editar animated:YES];
}

// desta forma modificamos o botao favorito sem ter que entrar em modo de 
- (IBAction)favoritoButton:(id)sender {
    favoriteINS = self.favoritoField.on;
}

- (IBAction)apagarReceita:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Livro de Receitas"
        message:@"Deseja eliminar a receita?"
        delegate:self
        cancelButtonTitle:@"Não"
        otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Sim"];
    
    // dar sempre uma tag aos alerts
    alert.tag = 1;
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alert.tag == 1) {
        if(buttonIndex == 1){
            SGReceita *receitaALT = [[SGReceita alloc] init];
            receitaALT.posicao = receita.posicao;
            
            if([[self delegate] respondsToSelector:@selector(apagarReceita:)]){
                [[self delegate] apagarReceita:receitaALT];
            }
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

// o numero de seccoes que a tabela tem
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// o numero de linhas que a tabela tem
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.ingredientesTable) {
        return [ingredientes count];
    }else{
        return [procedimentos count];
    }
}

// para apresentar os valores inseridos nas tabelas (ingredientes e procedimentos)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == ingredientesTable){
        static NSString *identifier = @"ingredientesTableCellADD";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        }
        
        NSString *ingrediente = [self.ingredientes objectAtIndex:indexPath.row];
        cell.textLabel.text = ingrediente;
        
        return cell;
    }else{
        static NSString *identifier = @"procedimentosTableCellADD";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        }
        
        NSString *procedimento = [self.procedimentos objectAtIndex:indexPath.row];
        cell.textLabel.text = procedimento;
        
        return cell;
    }
}
    
@end