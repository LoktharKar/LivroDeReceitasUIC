//
//  SGReceita.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 27/07/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGReceita : NSObject <NSCoding>

@property (nonatomic) NSString *nome;
@property (nonatomic) UIImage *imagem;
@property (nonatomic) NSString *categoria;
@property (nonatomic) NSNumber *tempoDePreparacao;
@property (nonatomic) NSNumber *porcoes;
@property (nonatomic) NSMutableArray *ingredientes;
@property (nonatomic) NSMutableArray *procedimentos;
@property (nonatomic) BOOL favorito;

@property (nonatomic) NSInteger posicao;

-(id) initWithNome: (NSString *) nomeINS Categoria: (NSString *) categoriaINS TempoPrep: (NSNumber *) tempoINS Porcoes: (NSNumber *) porcoesINS Ingredientes: (NSMutableArray *) ingredientesINS Procedimentos: (NSMutableArray *) procedimentosINS Favorito: (BOOL) favoritoINS Imagem: (UIImage *) imagemINS;

@end