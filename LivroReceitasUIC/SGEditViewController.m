//
//  SGEditViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 08/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGEditViewController.h"
#import "SGCollectionViewController.h"
#import "SGReceita.h"

@interface SGEditViewController ()

@property (nonatomic) UIImage* imagem;

@end

@implementation SGEditViewController

@synthesize receita;

@synthesize nomeField;
@synthesize categoriaField;
@synthesize tempoField;
@synthesize porcoesField;
@synthesize favoritoSwitch;

@synthesize ingredientesTableField;
@synthesize procedimentoTableField;

@synthesize adicionarImagemButton;
@synthesize editarImagemImage;

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
    self.favoritoSwitch.on = receita.favorito;
    
    self.editarImagemImage.image = receita.imagem;
    self.imagem = receita.imagem;
    
    if(!receita.imagem){
        [adicionarImagemButton setHidden:NO];
    }else{
        [adicionarImagemButton setHidden:YES];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Funcao para guardar a receita
- (IBAction)guardarAlteracoesButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Livro de Receitas"
        message:@"Deseja guardar as alterações efectuadas à receita?"
        delegate:self
        cancelButtonTitle:@"Não"
        otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Sim"];
    
    alert.tag = 1;
    [alert show];
}

// para determinar se foi pressionado o botão de "Sim" no alert, caso contrario não faz nada
-(void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alert.tag == 1) {
        if(buttonIndex == 1){
            //obtencao dos ingredientes da tabela
            NSMutableArray *ingredientesTotal = [[NSMutableArray alloc] init];
            
            //obtencao dos procedimentos da tabela
            NSMutableArray *procedimentosTotal = [[NSMutableArray alloc] init];
            
            SGReceita *receitaALT = [[SGReceita alloc] initWithNome:self.nomeField.text Categoria:self.categoriaField.text TempoPrep:[NSNumber numberWithInt:[self.tempoField.text intValue]]  Porcoes:[NSNumber numberWithInt:[self.porcoesField.text intValue]] Ingredientes:  ingredientesTotal Procedimentos: procedimentosTotal Favorito: self.favoritoSwitch.on Imagem:self.imagem];
            receitaALT.posicao = receita.posicao;
            
            if([[self delegate] respondsToSelector:@selector(editarReceita:)]){
                [[self delegate] editarReceita:receitaALT];
            }
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (IBAction)adicionarIngredienteButton:(id)sender {
    
    
}

- (IBAction)adicionarProcedimentoButton:(id)sender {
    
    
}

- (IBAction)adicionarImagemButton:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // tipo de seleccao de imagem
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = info[UIImagePickerControllerEditedImage];
    
    if(!img){
        img = info[UIImagePickerControllerOriginalImage];
    }
    
    self.imagem = img;
    
    [adicionarImagemButton setHidden:YES];
    [editarImagemImage setImage:self.imagem];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end