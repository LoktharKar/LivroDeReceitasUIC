//
//  SGProtocols.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 08/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGReceita.h"

@protocol SGProtocolsADD_EDIT_REMOVE

-(void) editarReceita: (SGReceita *) receita;
-(void) adicionarReceita: (SGReceita *) receita;
-(void) apagarReceita: (SGReceita *) receita;

@end

@protocol SGProtocolsADD_ING_PROC

-(void) adicionarIngrediente: (NSString *) ingrediente naPosicao: (NSIndexPath *)indexPath;
-(void) adicionarProcedimento: (NSString *) procedimento naPosicao: (NSIndexPath *)indexPath;;

@end

@interface SGProtocols : UIViewController

@end
