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
    
@end