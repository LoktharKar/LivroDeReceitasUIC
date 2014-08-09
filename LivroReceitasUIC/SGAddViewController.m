//
//  SGAddViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 05/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGAddViewController.h"
#import "SGCollectionViewController.h"
#import "SGAddIngredienteViewController.h"
#import "SGIngredientesTableViewController.h"
#import "SGReceita.h"
#import "SGProtocols.h"

@interface SGAddViewController ()

@property (nonatomic) UIImage *imagem;

@end

@implementation SGAddViewController

@synthesize nomeField;
@synthesize categoriaField;
@synthesize tempoField;
@synthesize porcoesField;
@synthesize favoritoSwitch;

@synthesize adicionarImagemButton;
@synthesize AdicionarImagemImage;
@synthesize ingredientesINS;
@synthesize procedimentosINS;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Funcao para guardar a receita
- (IBAction)guardarReceitaButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Livro de Receitas" message:@"Deseja guardar a receita?"
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
            ingredientesTotal = ingredientesINS;
            
            //obtencao dos procedimentos da tabela
            NSMutableArray *procedimentosTotal = [[NSMutableArray alloc] init];
            procedimentosTotal = procedimentosINS;
            
            SGReceita *receita = [[SGReceita alloc] initWithNome:self.nomeField.text Categoria:self.categoriaField.text TempoPrep:[NSNumber numberWithInt:[self.tempoField.text intValue]]  Porcoes:[NSNumber numberWithInt:[self.porcoesField.text intValue]] Ingredientes:  ingredientesTotal Procedimentos: procedimentosTotal Favorito: self.favoritoSwitch.on Imagem:self.imagem];
            
            if([[self delegate] respondsToSelector:@selector(adicionarReceita:)]){
                [[self delegate] adicionarReceita:receita];
            }
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (IBAction)adicionarIngredienteButton:(id)sender {
    SGAddIngredienteViewController *adicionarIngrediente = [self.storyboard instantiateViewControllerWithIdentifier:@"adicionarIngrediente"];
    
    // definir o tipo de janela
    adicionarIngrediente.modalInPopover = YES;
    adicionarIngrediente.modalPresentationStyle = UIModalPresentationFormSheet;
    adicionarIngrediente.delegate = self;
    
    //mostrar a nova janela
    [self.navigationController presentViewController:adicionarIngrediente animated:YES completion:nil];
}

- (IBAction)adicionarProcedimentoButton:(id)sender {
    
    
    
}

- (IBAction)addImage:(id)sender {
    
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
    [AdicionarImagemImage setImage:self.imagem];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) adicionarIngrediente: (NSString *) ingrediente{
    [self.ingredientesINS addObject:ingrediente];
    
    NSLog(@"aqui");
    NSLog(@"%@", ingredientesINS[0]);

    for (int i = 0; ingredientesINS.count; i++) {
        NSLog(@"%@", ingredientesINS[i]);
    }
    
    SGIngredientesTableViewController *ingTable = [[SGIngredientesTableViewController alloc] init];
    ingTable.listaDeIngredientes = ingredientesINS;
}
@end