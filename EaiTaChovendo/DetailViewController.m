//
//  DetailViewController.m
//  EaiTaChovendo
//
//  Created by Lucas Fraga Schuler on 08/06/15.
//  Copyright (c) 2015 Lucas Fraga Schuler. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *sensacao;
@property (weak, nonatomic) IBOutlet UILabel *umidade;
@property (weak, nonatomic) IBOutlet UILabel *velocidadeVento;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _temp.text = [[_valores objectForKey:@"temperaturaExterna"] stringValue];
  //  _sensacao.text = [[_valores objectForKey:@"sensacaoTermica"] stringValue];
    _umidade.text = [[_valores objectForKey:@"umidadeExterna"] stringValue];
  //  _velocidadeVento.text = [[_valores objectForKey:@"velocidadeVento"] stringValue];
    _imagem.image = [UIImage imageNamed:_imageName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self performSegueWithIdentifier:@"backToMaster" sender:nil];
}

@end
