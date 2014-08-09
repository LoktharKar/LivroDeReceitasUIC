//
//  SGAddIngredienteViewController.m
//  LivroReceitasUIC
//
//  Created by Shinigami on 09/08/14.
//  Copyright (c) 2014 Shinigami. All rights reserved.
//

#import "SGAddIngredienteViewController.h"
#import "SGAddViewController.h"

@interface SGAddIngredienteViewController ()

@end

@implementation SGAddIngredienteViewController

@synthesize nomeField;
@synthesize quantidadeField;

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
    CGRect frame = CGRectMake(0, 0, 400, 200);
    float x = (screen.size.width - frame.size.width)*.5f;
    float y = (screen.size.height - frame.size.height)*.5f;
    
    // para definir a frame
    frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    self.view.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guardarButton:(id)sender {
    NSString *ingrediente = [[NSString alloc] init];
    ingrediente = [ingrediente stringByAppendingString:quantidadeField.text];
    ingrediente = [ingrediente stringByAppendingString:@" "];
    ingrediente = [ingrediente stringByAppendingString:nomeField.text];

    if([[self delegate] respondsToSelector:@selector(adicionarIngrediente:)]){
        [[self delegate] adicionarIngrediente:ingrediente];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelarButton:(id)sender {
    // para fazer o dismiss das pagesform e sheetform
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
