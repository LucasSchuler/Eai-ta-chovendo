//
//  DetailViewController.m
//  EaiTaChovendo
//
//  Created by Lucas Fraga Schuler on 08/06/15.
//  Copyright (c) 2015 Lucas Fraga Schuler. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tempMax;
@property (weak, nonatomic) IBOutlet UILabel *tempMin;
@property (weak, nonatomic) IBOutlet UILabel *umidade;
@property (weak, nonatomic) IBOutlet UILabel *velocidadeVento;
@property (weak, nonatomic) IBOutlet UILabel *chuva;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *temperatura;
@property (weak, nonatomic) IBOutlet UILabel *nomeRegiao;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imagem.image = [UIImage imageNamed:_imageName];
    _nomeRegiao.text = [[@"Zona " stringByAppendingString:_imageName] capitalizedString];
    
    if ([_valores objectForKey:@"temperaturaExterna"] != (id)[NSNull null])
    {
        _temperatura.text = [NSString stringWithFormat:@"%@°",[[_valores objectForKey:@"temperaturaExterna"] stringValue]];
    }else{ _temperatura.text = @"-";}
    
    if ([_valores objectForKey:@"temperaturaMaximaPrevisao"] != (id)[NSNull null])
    {
        _tempMax.text = [NSString stringWithFormat:@"%@°", [[_valores objectForKey:@"temperaturaMaximaPrevisao"] stringValue]];
    }
    else
    {
        _tempMax.text = @"-";
    }
    if ([_valores objectForKey:@"temperaturaMinimaPrevisao"] != (id)[NSNull null])
    {
        _tempMin.text = [NSString stringWithFormat:@"%@°",[[_valores objectForKey:@"temperaturaMinimaPrevisao"] stringValue]];
    }
    else
    {
        _tempMin.text = @"-";
    }
    if ([_valores objectForKey:@"umidadeExterna"] != (id)[NSNull null])
    {
        _umidade.text = [NSString stringWithFormat:@"%@%%",[[_valores objectForKey:@"umidadeExterna"] stringValue]];
    }
    else
    {
        _umidade.text = @"-";
    }
    if ([_valores objectForKey:@"velocidadeVento"] != (id)[NSNull null])
    {
        _velocidadeVento.text = [NSString stringWithFormat:@"%@km",[[_valores objectForKey:@"velocidadeVento"] stringValue]];
    }
    else
    {
        _velocidadeVento.text = @"-";
    }
    if ([_valores objectForKey:@"chuvaDiaria"] != (id)[NSNull null])
    {
        _chuva.text = [NSString stringWithFormat:@"%@ml",[[_valores objectForKey:@"chuvaDiaria"] stringValue]];
    }
    else
    {
        _chuva.text = @"-";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self performSegueWithIdentifier:@"backToMaster" sender:nil];
}

@end
