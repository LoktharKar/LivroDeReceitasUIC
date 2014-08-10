//
//  SGReceita.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 27/07/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGReceita.h"

@implementation SGReceita

// criação dos métodos get/set automaticos
@synthesize nome;
@synthesize imagem;
@synthesize categoria;
@synthesize tempoDePreparacao;
@synthesize porcoes;
@synthesize ingredientes;
@synthesize procedimentos;
@synthesize favorito;

@synthesize posicao;

// criacao das key para usar na gravacao dos dados no userdefaults (devia-se usar o CoreData)
static NSString* nomeKey = @"SGnomeKey";
static NSString* imageKey = @"SGImagemKey";
static NSString* categoriaKey = @"SGcategoriaKey";
static NSString* tempoDePreparacaoKey = @"SGtempoDePreparacaoKey";
static NSString* porcoesKey = @"SGporcoesKey";
static NSString* ingredientesKey = @"SGingredientesKey";
static NSString* procedimentosKey = @"SGprocedimentosKey";
static NSString* favoritoKey = @"SGfavoritoKey";

-(id) initWithNome: (NSString *) nomeINS Categoria: (NSString *) categoriaINS TempoPrep: (NSNumber *) tempoINS Porcoes: (NSNumber *) porcoesINS Ingredientes: (NSMutableArray *) ingredientesINS Procedimentos: (NSMutableArray *) procedimentosINS Favorito:(BOOL)favoritoINS Imagem: (UIImage *) imagemINS{
    
    self = [super init];
    
    if(self){
        self.nome = nomeINS;
        self.categoria = categoriaINS;
        self.tempoDePreparacao = tempoINS;
        self.porcoes = porcoesINS;
        self.ingredientes = ingredientesINS;
        self.procedimentos = procedimentosINS;
        self.favorito = favoritoINS;
        self.imagem = imagemINS;
    }
    
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    self.nome = [aDecoder decodeObjectForKey:nomeKey];
    self.categoria = [aDecoder decodeObjectForKey:categoriaKey];
    self.tempoDePreparacao = [aDecoder decodeObjectForKey:tempoDePreparacaoKey];
    self.porcoes = [aDecoder decodeObjectForKey:porcoesKey];
    self.ingredientes = [aDecoder decodeObjectForKey:ingredientesKey];
    self.procedimentos = [aDecoder decodeObjectForKey:procedimentosKey];
    self.favorito = [[aDecoder decodeObjectForKey:favoritoKey] boolValue];
    
    // fazer o decode da imagem
    NSData *imageData = [aDecoder decodeObjectForKey:imageKey];
    
    if(imageData){
        self.imagem = [UIImage imageWithData:imageData];
    }
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.nome forKey:nomeKey];
    [aCoder encodeObject:self.categoria forKey:categoriaKey];
    [aCoder encodeObject:self.tempoDePreparacao forKey:tempoDePreparacaoKey];
    [aCoder encodeObject:self.porcoes forKey:porcoesKey];
    [aCoder encodeObject:self.ingredientes forKey:ingredientesKey];
    [aCoder encodeObject:self.procedimentos forKey:procedimentosKey];
    [aCoder encodeObject:[NSNumber numberWithBool:self.favorito] forKey:favoritoKey];
    
    // fazer o code de uma imagem
    NSData *imageData = UIImagePNGRepresentation(self.imagem);
    [aCoder encodeObject:imageData forKey:imageKey];
}
@end