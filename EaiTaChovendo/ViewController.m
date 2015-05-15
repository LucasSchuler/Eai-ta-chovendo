//
//  ViewController.m
//  EaiTaChovendo
//
//  Created by Lucas Fraga Schuler on 05/05/15.
//  Copyright (c) 2015 Lucas Fraga Schuler. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (nonatomic) UIButton * zonaNorte;
@property (nonatomic) UIButton * zonaSul;
@property (nonatomic) UIButton * zonaLeste;
@property (nonatomic) UIButton * zonaOeste;

@property (nonatomic) UIImageView * zonaNorteChuva;
@property (nonatomic) UIImageView * zonaSulChuva;
@property (nonatomic) UIImageView * zonaLesteChuva;
@property (nonatomic) UIImageView * zonaOesteChuva;

@property (nonatomic) UIImageView * elipseSul;
@property (nonatomic) UIImageView * elipseNorte;
@property (nonatomic) UIImageView * elipseOeste;
@property (nonatomic) UIImageView * elipseLeste;

@property (nonatomic) UIButton * oldLady;

@property (nonatomic) NSMutableDictionary * zonaNorteData;
@property (nonatomic) NSMutableDictionary * zonaSulData;
@property (nonatomic) NSMutableDictionary * zonaLesteData;
@property (nonatomic) NSMutableDictionary * zonaOesteData;

@property (nonatomic) NSArray * resultados;
@property (nonatomic) NSError * error;

@property (nonatomic) UIVisualEffectView * blureffectview2;

@property (nonatomic,retain) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [background setImage:[UIImage imageNamed:@"map"]];
    [self.view addSubview:background];
    
    // Faz conexão e recebe dados do DataPOA
    //NSString *url = [NSString stringWithFormat:@"http://metroclima.procempa.com.br/dados_json.php"];
    NSString *url = [NSString stringWithFormat:@"https://metroclimaestacoes.procempa.com.br/metroclima/seam/resource/rest/externalRest/ultimaLeitura"];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError * error = self.error;
    self.resultados = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers error:&error];
    
    // Elementos avulsos da tela
    [self criaElementosFlutuantes];
    
    // Aloca dados recebidos nos parâmentros
    [self alocaDados];
    
    // Cria os botões iniciais da tela
    [self criaMapa];
    
    UIBlurEffect *blureffect1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blureffectview2 = [[UIVisualEffectView alloc] initWithEffect:blureffect1];
    [self.blureffectview2 setFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.blureffectview2 setAlpha:0];
    [self.view addSubview:self.blureffectview2];
}

-(void)alocaDados
{
    for (int i = 0; i < self.resultados.count; i++) {
        if(!self.error) {
            NSMutableDictionary *aux = self.resultados[i];
            long ident =  [[aux objectForKey:@"id"] integerValue];
            NSLog(@"%d", i);
            if (ident == 4)
            {
                self.zonaNorteData = aux;
            }
            if (ident == 6)
            {
                self.zonaLesteData = aux;
            }
            if (ident == 1)
            {
                self.zonaOesteData = aux;
            }
            if (ident == 2)
            {
                self.zonaSulData = aux;
            }
            NSLog(@"%@", [aux objectForKey:@"temperaturaExterna"]);
        }
    }
}

-(void)criaMapa
{
    self.zonaNorte = [[UIButton alloc] initWithFrame:CGRectMake(68, 40, 190, 170)];
    [self.zonaNorte addTarget:self action:@selector(zonaNorteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zonaNorte];
    
    self.elipseNorte = [[UIImageView alloc] initWithFrame:CGRectMake(70, 40, 70, 70)];
    [self.elipseNorte setImage:[UIImage imageNamed:@"elipse"]];
    [self.zonaNorte addSubview:self.elipseNorte];
    
    UILabel * temperaturaNorte = [[UILabel alloc] initWithFrame:CGRectMake(17, 30, 40, 40)];
    [temperaturaNorte setText:[NSString stringWithFormat:@"%@º", [[self.zonaNorteData objectForKey:@"temperaturaExterna"]stringValue]]];
    [temperaturaNorte setFont:[UIFont fontWithName:FONTE size:15]];
    [temperaturaNorte setTextColor:[UIColor whiteColor]];
    [temperaturaNorte setTextAlignment:NSTextAlignmentCenter];
    [self.elipseNorte addSubview:temperaturaNorte];
    
    self.zonaNorteChuva = [[UIImageView alloc] initWithFrame:CGRectMake(28, 8, 15, 30)];
    [self.zonaNorteChuva setImage:[UIImage imageNamed:@"chuvaOff"]];
    [self.elipseNorte addSubview:self.zonaNorteChuva];
    
    // ------------------------------------------------------------------------

    self.zonaSul = [[UIButton alloc] initWithFrame:CGRectMake(107, 342, 225, 172)];
    [self.zonaSul addTarget:self action:@selector(zonaSulAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zonaSul];
    
    self.elipseSul = [[UIImageView alloc] initWithFrame:CGRectMake(70, 55, 70, 70)];
    [self.elipseSul setImage:[UIImage imageNamed:@"elipse"]];
    [self.zonaSul addSubview:self.elipseSul];
    
    UILabel * temperaturaSul = [[UILabel alloc] initWithFrame:CGRectMake(17, 30, 40, 40)];
    [temperaturaSul setText:[NSString stringWithFormat:@"%@º", [[self.zonaSulData objectForKey:@"temperaturaExterna"]stringValue]]];
    [temperaturaSul setFont:[UIFont fontWithName:FONTE size:15]];
    [temperaturaSul setTextColor:[UIColor whiteColor]];
    [temperaturaSul setTextAlignment:NSTextAlignmentCenter];
    [self.elipseSul addSubview:temperaturaSul];
    
    self.zonaSulChuva = [[UIImageView alloc] initWithFrame:CGRectMake(28, 8, 15, 30)];
    [self.zonaSulChuva setImage:[UIImage imageNamed:@"chuvaOff"]];
    [self.elipseSul addSubview:self.zonaSulChuva];
    
    // ------------------------------------------------------------------------

    self.zonaLeste = [[UIButton alloc] initWithFrame:CGRectMake(147, 190, 135, 200)];
    [self.zonaLeste addTarget:self action:@selector(zonaLesteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zonaLeste];
    
    self.elipseLeste = [[UIImageView alloc] initWithFrame:CGRectMake(23, 75, 60, 60)];
    [self.elipseLeste setImage:[UIImage imageNamed:@"elipse"]];
    [self.zonaLeste addSubview:self.elipseLeste];
    
    UILabel * temperaturaLeste = [[UILabel alloc] initWithFrame:CGRectMake(11, 27, 40, 40)];
    [temperaturaLeste setText:[NSString stringWithFormat:@"%@º", [[self.zonaLesteData objectForKey:@"temperaturaExterna"]stringValue]]];
    [temperaturaLeste setFont:[UIFont fontWithName:FONTE size:14]];
    [temperaturaLeste setTextColor:[UIColor whiteColor]];
    [temperaturaLeste setTextAlignment:NSTextAlignmentCenter];
    [self.elipseLeste addSubview:temperaturaLeste];
    
    self.zonaLesteChuva = [[UIImageView alloc] initWithFrame:CGRectMake(25, 8, 15, 30)];
    [self.zonaLesteChuva setImage:[UIImage imageNamed:@"chuvaOff"]];
    [self.elipseLeste addSubview:self.zonaLesteChuva];
    
    // ------------------------------------------------------------------------
    
    self.zonaOeste = [[UIButton alloc] initWithFrame:CGRectMake(44, 175, 121, 220)];
    [self.zonaOeste addTarget:self action:@selector(zonaOesteAction) forControlEvents:UIControlEventTouchUpInside];
    //[self.zonaOeste setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:self.zonaOeste];
    
    self.elipseOeste = [[UIImageView alloc] initWithFrame:CGRectMake(35, 70, 70, 70)];
    [self.elipseOeste setImage:[UIImage imageNamed:@"elipse"]];
    [self.zonaOeste addSubview:self.elipseOeste];
    
    UILabel * temperaturaOeste = [[UILabel alloc] initWithFrame:CGRectMake(17, 30, 40, 40)];
    [temperaturaOeste setText:[NSString stringWithFormat:@"%@º", [[self.zonaSulData objectForKey:@"temperaturaExterna"]stringValue]]];
    [temperaturaOeste setFont:[UIFont fontWithName:FONTE size:15]];
    [temperaturaOeste setTextColor:[UIColor whiteColor]];
    [temperaturaOeste setTextAlignment:NSTextAlignmentCenter];
    [self.elipseOeste addSubview:temperaturaOeste];
    
    self.zonaOesteChuva = [[UIImageView alloc] initWithFrame:CGRectMake(28, 8, 15, 30)];
    [self.zonaOesteChuva setImage:[UIImage imageNamed:@"chuvaOff"]];
    [self.elipseOeste addSubview:self.zonaOesteChuva];
    
    // ------------------------------------------------------------------------

}

-(void)criaElementosFlutuantes
{
    
    self.oldLady = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 54, 88)];
    [self.oldLady setBackgroundImage:[UIImage imageNamed:@"vo"] forState:UIControlStateNormal];
    [self.oldLady setCenter:CGPointMake(SCREEN_WIDTH*0.11, SCREEN_HEIGHT-43)];
    [self.view addSubview:self.oldLady];
    
    UIImageView * barco1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barco1"]];
    [barco1 setFrame:CGRectMake(100, 500, 40, 22.5)];
    [self.view addSubview:barco1];
    
    UIImageView * barco2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barco2"]];
    [barco2 setFrame:CGRectMake(180, 520, 57, 30)];
    [self.view addSubview:barco2];
    
    UIImageView * barco3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barco3"]];
    [barco3 setFrame:CGRectMake(40, 420, 65, 37)];
    [self.view addSubview:barco3];
    
    UIImageView * rosa = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rosa"]];
    [rosa setFrame:CGRectMake(255, 100, 56, 57.5)];
    [self.view addSubview:rosa];
    
    UIImageView * barra = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barra"]];
    [barra setFrame:CGRectMake(10, 25, 300, 38.5)];
    [self.view addSubview:barra];
}

-(void)zonaNorteAction
{
    if (self.zonaNorte.currentBackgroundImage == NULL)
    {
        [self.zonaNorte setBackgroundImage:[UIImage imageNamed:@"norte"] forState:UIControlStateNormal];
        [self.zonaSul setBackgroundImage:NULL forState:UIControlStateNormal];
        [self.zonaOeste setBackgroundImage:NULL forState:UIControlStateNormal];
        [self.zonaLeste setBackgroundImage:NULL forState:UIControlStateNormal];
    }
    else
    {
        [self.zonaNorte setBackgroundImage:NULL forState:UIControlStateNormal];
    }
}

-(void)zonaSulAction
{
    if (self.zonaSul.currentBackgroundImage == NULL)
    {
        [self.zonaSul setBackgroundImage:[UIImage imageNamed:@"sul"] forState:UIControlStateNormal];
        [self.zonaNorte setBackgroundImage:NULL forState:UIControlStateNormal];
        [self.zonaOeste setBackgroundImage:NULL forState:UIControlStateNormal];
        [self.zonaLeste setBackgroundImage:NULL forState:UIControlStateNormal];
    }
    else
    {
        [self.zonaSul setBackgroundImage:NULL forState:UIControlStateNormal];
    }
}

-(void)zonaOesteAction
{
    UIImageView * box = [[UIImageView alloc] init];
    
    if (self.zonaOeste.currentBackgroundImage == NULL)
    {
        [self.view bringSubviewToFront:self.zonaOeste];
        [UIView animateWithDuration:0.0001 animations:^{
            [self.zonaOeste setBackgroundImage:[UIImage imageNamed:@"oeste"] forState:UIControlStateNormal];
            [self.zonaOeste setFrame:CGRectMake(44, 175, 121, 220)];
            [self.zonaNorte setBackgroundImage:NULL forState:UIControlStateNormal];
            [self.zonaSul setBackgroundImage:NULL forState:UIControlStateNormal];
            [self.zonaLeste setBackgroundImage:NULL forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.zonaOeste setFrame:CGRectMake(self.zonaOeste.frame.origin.x, self.zonaOeste.frame.origin.y, self.zonaOeste.frame.size.width+(self.zonaOeste.frame.size.width*0.5), self.zonaOeste.frame.size.height+(self.zonaOeste.frame.size.height*0.5))];
                [self.zonaOeste setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/3)];
                [self.elipseOeste setAlpha:0];
                [self.blureffectview2 setAlpha:1];
                
                [box setFrame:CGRectMake(0, 0, 200, 160)];
                [box setCenter:CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT+(SCREEN_HEIGHT/1.5))/2)];
                [box setImage:[UIImage imageNamed:@"boxDados"]];
                [self.blureffectview2 addSubview:box];
            }];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self.zonaOeste setFrame:CGRectMake(self.zonaOeste.frame.origin.x, self.zonaOeste.frame.origin.y, self.zonaOeste.frame.size.width-(self.zonaOeste.frame.size.width*0.9), self.zonaOeste.frame.size.height-(self.zonaOeste.frame.size.height*0.9))];
            [self.zonaOeste setFrame:CGRectMake(44, 175, 121, 220)];
            [self.elipseOeste setAlpha:1];
            [self.blureffectview2 setAlpha:0];
            
            [box removeFromSuperview];
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.zonaOeste setBackgroundImage:NULL forState:UIControlStateNormal];
            }];
        }];
        
    }
}

-(void)zonaLesteAction
{
    if (self.zonaLeste.currentBackgroundImage != NULL)
    {
        [self.zonaLeste setBackgroundImage:[UIImage imageNamed:@"leste"] forState:UIControlStateNormal];
        [self.zonaNorte setBackgroundImage:NULL forState:UIControlStateNormal];
        [self.zonaSul setBackgroundImage:NULL forState:UIControlStateNormal];
        [self.zonaOeste setBackgroundImage:NULL forState:UIControlStateNormal];
    }
    else
    {
        [self.zonaLeste setBackgroundImage:NULL forState:UIControlStateNormal];
    }
}

- (NSString *)deviceLocation
{
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    return theLocation;
}

@end
