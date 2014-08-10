//
//  SGAddProcedimentoViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 10/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGAddProcedimentoViewController.h"
#import "SGAddViewController.h"

@interface SGAddProcedimentoViewController ()

@end

@implementation SGAddProcedimentoViewController

@synthesize procedimentoField;
@synthesize indexPath;
@synthesize tituloField;

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
}

-(void)viewWillAppear:(BOOL)animated{
    // para eliminar a cor por trás
    self.view.superview.backgroundColor = [UIColor clearColor];
    
    // para definir os limites do screen
    CGRect screen = self.view.superview.bounds;
    
    // para definir a frame a mostrar
    CGRect frame = CGRectMake(0, 0, 400, 300);
    float x = (screen.size.width - frame.size.width)*.5f;
    float y = (screen.size.height - frame.size.height)*.5f;
    
    // para definir a frame
    frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    self.view.frame = frame;
    
    // para mudar o titulo
    if(!indexPath){
        tituloField.text = @"Adiconar Procedimento";
    }else{
        tituloField.text = @"Editar Procedimento";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelarButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)guardarButton:(id)sender {
    NSString *procedimento = [[NSString alloc] init];
    procedimento = [procedimento stringByAppendingString:@"- "];
    procedimento = [procedimento stringByAppendingString:procedimentoField.text];
    
    if([[self delegate] respondsToSelector:@selector(adicionarProcedimento:naPosicao:)]){
        [[self delegate] adicionarProcedimento:procedimento naPosicao:indexPath];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
