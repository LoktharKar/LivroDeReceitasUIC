//
//  SGCollectionViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 27/07/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGCollectionViewController.h"
#import "SGCollectionViewCell.h"
#import "SGDetailsViewController.h"
#import "SGAddViewController.h"
#import "SGEditViewController.h"
#import "SGAddIngredienteViewController.h"
#import "SGReceita.h"
#import "SGProtocols.h"


@interface SGCollectionViewController ()

@end

@implementation SGCollectionViewController

@synthesize livroDeReceitas;

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
    // Do any additional setup after loading the view.
    
    [self loadArrayFromUD];
    // para o caso da biblioteca existente nao se encontrar em ordem alfabetica
    [self sortArray:livroDeReceitas];
}

// metodo para ordenar por ordem alfabetica o livro de receitas
-(NSMutableArray *) sortArray: (NSMutableArray *) array{
    NSMutableArray *sortedArray = array;
    [sortedArray sortUsingComparator:^NSComparisonResult(SGReceita *a, SGReceita *b) {
        return [a.nome caseInsensitiveCompare:b.nome];
    }];
    return sortedArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [livroDeReceitas count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"Cell";
    SGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[SGCollectionViewCell alloc] init];
    }
    
    SGReceita *receita = [livroDeReceitas objectAtIndex:indexPath.row];
    receita.posicao = indexPath.row;
    
    cell.nomeReceita.text = receita.nome;
    cell.imageView.image = receita.imagem;
    
    
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SGDetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    
    details.receita = [livroDeReceitas objectAtIndex:indexPath.row];
    
    details.delegate = self;
    
    [self.navigationController pushViewController:details animated:YES];
}

- (IBAction)addReceita:(id)sender {
    SGAddViewController *adicionar = [self.storyboard instantiateViewControllerWithIdentifier:@"adicionar"];
    
    // importantissimo ..... perdi duas horas por causa disto XD não conseguia gravar.
    // apos definirmos o delegate no SGAddViewController.m, temos de dizer ao nosso CollectionController
    // que quando carregamos no botao adicionar ele e o delegate dele, se nao nao existe comunicacao
    // entre o SGAdd e o SGCollection
    
    adicionar.delegate = self;
    
    [self.navigationController pushViewController:adicionar animated:YES];
}

// para guardar a nova receita na livraria
-(void) adicionarReceita:(SGReceita *)receita{
    [livroDeReceitas addObject:receita];
    [self saveArrayToUD];
}

// para editar uma receita
-(void) editarReceita:(SGReceita *)receita{
    [livroDeReceitas replaceObjectAtIndex:receita.posicao withObject:receita];
    [self saveArrayToUD];
}

// para apagar uma receita
-(void) apagarReceita:(SGReceita *)receita{
    [livroDeReceitas removeObjectAtIndex: receita.posicao];
    [self saveArrayToUD];
}

// para carregar as receitas da livraria
-(void) loadArrayFromUD{
    livroDeReceitas = [[NSMutableArray alloc] init];
    NSData *receitasData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SGReceitasUDKey"];
    
    //se existe informação carrega-a
    if(receitasData){
        livroDeReceitas = [NSKeyedUnarchiver unarchiveObjectWithData:receitasData];
    }
    
    // para o caso de dar erro
    if(!livroDeReceitas){
        livroDeReceitas = [[NSMutableArray alloc] init];
    }
}

// para armazenar o array nas NSUserDefaults
- (void) saveArrayToUD{
    NSData * receitasData = [NSKeyedArchiver archivedDataWithRootObject:livroDeReceitas];
    [[NSUserDefaults standardUserDefaults] setObject:receitasData forKey:@"SGReceitasUDKey"];
    
    // sincronização da livraria
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self sortArray:livroDeReceitas];
    [self.collectionView reloadData];
}

@end
