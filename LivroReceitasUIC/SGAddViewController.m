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
#import "SGAddProcedimentoViewController.h"
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

@synthesize ingTable;
@synthesize procTable;

@synthesize apagarIngredienteButtonText;
@synthesize apagarProcedimentoButtonText;

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
    //load prototype table cell nib static
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
    SGAddProcedimentoViewController *adicionarProcedimento = [self.storyboard instantiateViewControllerWithIdentifier:@"adicionarProcedimento"];
    
    // definir o tipo de janela
    adicionarProcedimento.modalInPopover = YES;
    adicionarProcedimento.modalPresentationStyle = UIModalPresentationFormSheet;
    adicionarProcedimento.delegate = self;
    
    //mostrar a nova janela
    [self.navigationController presentViewController:adicionarProcedimento animated:YES completion:nil];
}

- (IBAction)apagarIngrediente:(id)sender {
    if(![self.ingTable isEditing]){
        [self.apagarIngredienteButtonText setTitle:@"Terminar" forState:UIControlStateNormal];
        [self.ingTable setEditing:YES animated:YES];
    }else{
        [self.apagarIngredienteButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
        [self.ingTable setEditing:NO animated:YES];
    }
}

- (IBAction)apagarProcedimento:(id)sender {
    if(![self.procTable isEditing]){
        [self.apagarProcedimentoButtonText setTitle:@"Terminar" forState:UIControlStateNormal];
        [self.procTable setEditing:YES animated:YES];
    }else{
        [self.apagarProcedimentoButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
        [self.procTable setEditing:NO animated:YES];
    }
}

// para adicionar imagem
- (IBAction)addImage:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // tipo de seleccao de imagem
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// para escolher a imagem a partir do album de fotografias
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

// para adicionar o ingrediente ao array de ingredientes
-(void) adicionarIngrediente: (NSString *) ingrediente naPosicao: (NSIndexPath *)indexPath;{
    if(!ingredientesINS){
        ingredientesINS = [[NSMutableArray alloc] init];
    }
    
    if(!indexPath){
        [self.ingredientesINS addObject:ingrediente];
    }else{
        [self.ingredientesINS replaceObjectAtIndex:indexPath.row withObject:ingrediente];
    }
    
    if([self.ingredientesINS count] != 0){
        [apagarIngredienteButtonText setHidden:NO];
    }
    
    [ingTable reloadData];
}

// para adicionar o procedimento ao array de procedimentos
-(void) adicionarProcedimento: (NSString *) procedimento naPosicao: (NSIndexPath *)indexPath;{
    if(!procedimentosINS){
        procedimentosINS = [[NSMutableArray alloc] init];
    }
    
    if(!indexPath){
        [self.procedimentosINS addObject:procedimento];
    }else{
        [self.procedimentosINS replaceObjectAtIndex:indexPath.row withObject:procedimento];
    }
    
    if([self.procedimentosINS count] != 0){
        [apagarProcedimentoButtonText setHidden:NO];
    }
    
    [procTable reloadData];
}

// o numero de seccoes que a tabela tem
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// o numero de linhas que a tabela tem
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.ingTable) {
        return [ingredientesINS count];
    }else{
        return [procedimentosINS count];
    }
}

// para apresentar os valores inseridos nas tabelas (ingredientes e procedimentos)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == ingTable){
        static NSString *identifier = @"ingredientesTableCellADD";
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
        if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        }
    
        NSString *ingrediente = [ingredientesINS objectAtIndex:indexPath.row];
        cell.textLabel.text = ingrediente;
        
        return cell;
    }else{
        static NSString *identifier = @"procedimentosTableCellADD";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        }
        
        NSString *procedimento = [procedimentosINS objectAtIndex:indexPath.row];
        cell.textLabel.text = procedimento;
        
        return cell;
    }
}

// para editar os valores inseridos nas tabelas (ingredientes e procedimentos)
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == ingTable){
        SGAddIngredienteViewController *adicionarIngrediente = [self.storyboard instantiateViewControllerWithIdentifier:@"adicionarIngrediente"];
        
        // definir o tipo de janela
        adicionarIngrediente.modalInPopover = YES;
        adicionarIngrediente.modalPresentationStyle = UIModalPresentationFormSheet;
        adicionarIngrediente.delegate = self;
        
        adicionarIngrediente.indexPath = indexPath;
        
        //mostrar a nova janela
        [self.navigationController presentViewController:adicionarIngrediente animated:YES completion:nil];
        
        // preencher com os valores já definidos no array de ingredientes
        adicionarIngrediente.nomeField.text = [[[ingredientesINS objectAtIndex:indexPath.row] componentsSeparatedByString:@" - "] objectAtIndex:1];
        adicionarIngrediente.quantidadeField.text = [[[ingredientesINS objectAtIndex:indexPath.row] componentsSeparatedByString:@" - "] objectAtIndex:0];
        
    }else{
        SGAddProcedimentoViewController *adicionarProcedimento = [self.storyboard instantiateViewControllerWithIdentifier:@"adicionarProcedimento"];
        
        // definir o tipo de janela
        adicionarProcedimento.modalInPopover = YES;
        adicionarProcedimento.modalPresentationStyle = UIModalPresentationFormSheet;
        adicionarProcedimento.delegate = self;
        
        adicionarProcedimento.indexPath = indexPath;
        
        //mostrar a nova janela
        [self.navigationController presentViewController:adicionarProcedimento animated:YES completion:nil];
        
        // preencher com os valores já definidos no array de proceddimentos
        adicionarProcedimento.procedimentoField.text = [[[procedimentosINS objectAtIndex:indexPath.row] componentsSeparatedByString:@"- "] objectAtIndex:1];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // para eliminar as celulas nas tabelas
    if (tableView == self.ingTable){
        if(editingStyle == UITableViewCellEditingStyleDelete){
            [self.ingredientesINS removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if([ingredientesINS count] == 0){
                [tableView setEditing:NO];
                [self.apagarIngredienteButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
                [self.apagarIngredienteButtonText setHidden:YES];
            }
        }
    }else{
        if(editingStyle == UITableViewCellEditingStyleDelete){
            [self.procedimentosINS removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if([procedimentosINS count] == 0){
                [tableView setEditing:NO];
                [self.apagarProcedimentoButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
                [self.apagarProcedimentoButtonText setHidden:YES];
            }
        }
    }
}

@end