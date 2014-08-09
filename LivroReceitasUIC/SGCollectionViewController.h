//
//  SGCollectionViewController.h
//  LivroReceitasUIC
//
//  Created by Shinigami on 27/07/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGProtocols.h"

@interface SGCollectionViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource, SGProtocolsADD_EDIT_REMOVE>

@property (nonatomic) NSMutableArray* livroDeReceitas;

- (IBAction)addReceita:(id)sender;

@property (nonatomic) id delegate;

@end
