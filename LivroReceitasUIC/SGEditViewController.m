//
//  SGEditViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 08/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGEditViewController.h"
#import "SGCollectionViewController.h"
#import "SGAddIngredienteViewController.h"
#import "SGAddProcedimentoViewController.h"
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

@synthesize apagarIngredienteButtonText;
@synthesize apagarProcedimentoButtonText;

@synthesize ingredientes;
@synthesize procedimentos;

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
    self.ingredientes = receita.ingredientes;
    self.procedimentos = receita.procedimentos;
    
    
    // para verificar se existem valores no array de ingredientes
    if([ingredientes count] != 0){
        [apagarIngredienteButtonText setHidden:NO];
    }
    
    // para verificar se existem valores no array de procedimentos
    if([procedimentos count] != 0){
        [apagarProcedimentoButtonText setHidden:NO];
    }
    
    self.editarImagemImage.image = receita.imagem;
    self.imagem = receita.imagem;
    
    // para verificar se existe imagem ou nao
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
            ingredientesTotal = self.ingredientes;
            
            //obtencao dos procedimentos da tabela
            NSMutableArray *procedimentosTotal = [[NSMutableArray alloc] init];
            procedimentosTotal = self.procedimentos;
            
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

// Para determinar se a tabela de ingredientes esta em modo de edicao
- (IBAction)apagarIngrediente:(id)sender {
    if(![self.ingredientesTableField isEditing]){
        [self.apagarIngredienteButtonText setTitle:@"Terminar" forState:UIControlStateNormal];
        [self.ingredientesTableField setEditing:YES animated:YES];
    }else{
        [self.apagarIngredienteButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
        [self.ingredientesTableField setEditing:NO animated:YES];
    }
}

// Para determinar se a tabela de procedimentos esta em modo de edicao
- (IBAction)apagarProcedimento:(id)sender {
    if(![self.procedimentoTableField isEditing]){
        [self.apagarProcedimentoButtonText setTitle:@"Terminar" forState:UIControlStateNormal];
        [self.procedimentoTableField setEditing:YES animated:YES];
    }else{
        [self.apagarProcedimentoButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
        [self.procedimentoTableField setEditing:NO animated:YES];
    }
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

// para adicionar o ingrediente ao array de ingredientes
-(void) adicionarIngrediente: (NSString *) ingrediente naPosicao: (NSIndexPath *)indexPath;{
    if(!ingredientes){
        ingredientes = [[NSMutableArray alloc] init];
    }
    
    if(!indexPath){
        [self.ingredientes addObject:ingrediente];
    }else{
        [self.ingredientes replaceObjectAtIndex:indexPath.row withObject:ingrediente];
    }
    
    if([self.ingredientes count] != 0){
        [apagarIngredienteButtonText setHidden:NO];
    }
    
    [ingredientesTableField reloadData];
}

// para adicionar o procedimento ao array de procedimentos
-(void) adicionarProcedimento: (NSString *) procedimento naPosicao: (NSIndexPath *)indexPath;{
    if(!procedimentos){
        procedimentos = [[NSMutableArray alloc] init];
    }
    
    if(!indexPath){
        [self.procedimentos addObject:procedimento];
    }else{
        [self.procedimentos replaceObjectAtIndex:indexPath.row withObject:procedimento];
    }
    
    if([self.procedimentos count] != 0){
        [apagarProcedimentoButtonText setHidden:NO];
    }
    
    [procedimentoTableField reloadData];
}

// o numero de seccoes que a tabela tem
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// o numero de linhas que a tabela tem
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.ingredientesTableField) {
        return [ingredientes count];
    }else{
        return [procedimentos count];
    }
}

// para apresentar os valores inseridos nas tabelas (ingredientes e procedimentos)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == ingredientesTableField){
        static NSString *identifier = @"ingredientesTableCellADD";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        }
        
        NSString *ingrediente = [ingredientes objectAtIndex:indexPath.row];
        cell.textLabel.text = ingrediente;
        
        return cell;
    }else{
        static NSString *identifier = @"procedimentosTableCellADD";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
        }
        
        NSString *procedimento = [procedimentos objectAtIndex:indexPath.row];
        cell.textLabel.text = procedimento;
        
        return cell;
    }
}

// para editar os valores inseridos nas tabelas (ingredientes e procedimentos)
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == ingredientesTableField){
        SGAddIngredienteViewController *adicionarIngrediente = [self.storyboard instantiateViewControllerWithIdentifier:@"adicionarIngrediente"];
        
        // definir o tipo de janela
        adicionarIngrediente.modalInPopover = YES;
        adicionarIngrediente.modalPresentationStyle = UIModalPresentationFormSheet;
        adicionarIngrediente.delegate = self;
        
        adicionarIngrediente.indexPath = indexPath;
        
        //mostrar a nova janela
        [self.navigationController presentViewController:adicionarIngrediente animated:YES completion:nil];
        
        // preencher com os valores já definidos no array de ingredientes
        adicionarIngrediente.nomeField.text = [[[ingredientes objectAtIndex:indexPath.row] componentsSeparatedByString:@" - "] objectAtIndex:1];
        adicionarIngrediente.quantidadeField.text = [[[ingredientes objectAtIndex:indexPath.row] componentsSeparatedByString:@" - "] objectAtIndex:0];
        
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
        adicionarProcedimento.procedimentoField.text = [[[procedimentos objectAtIndex:indexPath.row] componentsSeparatedByString:@"- "] objectAtIndex:1];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // para eliminar as celulas nas tabelas
    if (tableView == self.ingredientesTableField){
        if(editingStyle == UITableViewCellEditingStyleDelete){
            [self.ingredientes removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if([ingredientes count] == 0){
                [tableView setEditing:NO];
                [self.apagarIngredienteButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
                [self.apagarIngredienteButtonText setHidden:YES];
            }
        }
    }else{
        if(editingStyle == UITableViewCellEditingStyleDelete){
            [self.procedimentos removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if([procedimentos count] == 0){
                [tableView setEditing:NO];
                [self.apagarProcedimentoButtonText setTitle:@"Apagar" forState:UIControlStateNormal];
                [self.apagarProcedimentoButtonText setHidden:YES];
            }
        }
    }
}

@end