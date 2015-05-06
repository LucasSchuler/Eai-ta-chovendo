//
//  ViewController.m
//  EaiTaChovendo
//
//  Created by Lucas Fraga Schuler on 05/05/15.
//  Copyright (c) 2015 Lucas Fraga Schuler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSString *url = [NSString stringWithFormat:@"http://metroclima.procempa.com.br/dados_json.php"];
    NSString *url = [NSString stringWithFormat:@"https://metroclimaestacoes.procempa.com.br/metroclima/seam/resource/rest/externalRest/ultimaLeitura"];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSArray *resultados = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers error:&error];
    
    for (int i = 0; i < resultados.count; i++) {
        if(!error) {
            NSMutableDictionary *aux = resultados[i];
            NSString *ident =  [aux objectForKey:@"id"];
            NSString *bairro = [aux objectForKey:@"bairro"];
            NSString *estacao = [aux objectForKey:@"estacao"];
            NSString *chuva = [aux objectForKey:@"chuvaDiaria"];
            NSLog(@"ID: %@, ESTAÇÃO: %@, CHUVA: %@, BAIRRO: %@", ident, estacao, chuva, bairro);
            if(chuva != NULL)
            {
              
            }
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
