//
//  ViewController.m
//  EaiTaChovendo
//
//  Created by Lucas Fraga Schuler on 05/05/15.
//  Copyright (c) 2015 Lucas Fraga Schuler. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIButton *btnNorte;
@property (weak, nonatomic) IBOutlet UIButton *btnOeste;
@property (weak, nonatomic) IBOutlet UIButton *btnLeste;
@property (weak, nonatomic) IBOutlet UIButton *btnSul;

@property (weak, nonatomic) IBOutlet UIView *viewNorte;
@property (weak, nonatomic) IBOutlet UIImageView *chuvaNorte;
@property (weak, nonatomic) IBOutlet UIView *viewOeste;
@property (weak, nonatomic) IBOutlet UIImageView *chuvaOeste;
@property (weak, nonatomic) IBOutlet UIView *viewLeste;
@property (weak, nonatomic) IBOutlet UIView *viewSul;
@property (weak, nonatomic) IBOutlet UIImageView *chuvaLeste;
@property (weak, nonatomic) IBOutlet UIImageView *chuvaSul;
@property (weak, nonatomic) IBOutlet UILabel *fraseDaVo;

@property (nonatomic) NSMutableDictionary * zonaNorteData;
@property (nonatomic) NSMutableDictionary * zonaSulData;
@property (nonatomic) NSMutableDictionary * zonaLesteData;
@property (nonatomic) NSMutableDictionary * zonaOesteData;

@property (nonatomic) NSArray * resultados;
@property (nonatomic) NSError * error;

@property (nonatomic,retain) CLLocationManager *locationManager;
@property CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UIImageView *boxVovo;

@property NSArray* semchuvaMenos20;
@property NSArray* semchuvaMais20;
@property NSArray* comchuvaMenos20;
@property NSArray* comchuvaMais20;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _semchuvaMenos20 = @[@"Bota um casaquinho pra sair no sereno!",@"Não me sai sem levar um casaquinho.",@"Pega tua Japona no armário antes de sair nesse frio.", @"Vai comer umas bergamota no sol pra te esquentar."];
    _semchuvaMais20 = @[@"Hoje ta bom pra dar uma volta na redenção.",@"Sai desse computador e vai pegar um solzinho.", @"Já vai sair de novo? Leva um guarda-chuva, vai que chove!", @"Não ta chovendo agora, mas leva um guarda-chuva mesmo assim!"];
    _comchuvaMenos20 = @[@"Leva um guarda-chuva pra não te molhar!", @"Vai pegar uma pneumonia nessa chuva, não me esquece o guarda-chuva!", @"Não te esquece do guarda-chuva!", @"Vê se me põe umas lã por baixo desse casaco. E não me esquece do guarda-chuva!"];
    _comchuvaMais20 = @[@"Eu sei que ta quente, mas não me toma banho de chuva que vai gripar!", @"Não te esquece do guarda-chuva!", @"Quantas vezes já te disse? Me pega um guarda-chuva guri!"];
    
    _boxVovo.hidden=YES;
     _viewNorte.backgroundColor = [UIColor clearColor];
     _viewOeste.backgroundColor = [UIColor clearColor];
     _viewLeste.backgroundColor = [UIColor clearColor];
     _viewSul.backgroundColor = [UIColor clearColor];
        
      // Faz conexão e recebe dados do DataPOA
    NSString *url = [NSString stringWithFormat:@"https://metroclimaestacoes.procempa.com.br/metroclima/seam/resource/rest/externalRest/ultimaLeitura"];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError * error = self.error;
    self.resultados = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers error:&error];
    // Aloca dados recebidos nos parâmentros
    [self alocaDados];

}

-(void)alocaDados
{
    for (int i = 0; i < self.resultados.count; i++) {
        if(!self.error) {
            NSMutableDictionary *aux = self.resultados[i];
            long ident =  [[aux objectForKey:@"id"] integerValue];
            //NSLog(@"%d", i);
            if (ident == 4)
            {
                self.zonaNorteData = aux;
                if([[_zonaNorteData objectForKey:@"chuvaDiaria"]  doubleValue] > 0.0){
                    _chuvaNorte.image = [UIImage imageNamed:@"chuvaOn"];
                }else{
                    _chuvaNorte.image = [UIImage imageNamed:@"chuvaOff"];
                }
            }
            if (ident == 6)
            {
                self.zonaLesteData = aux;
                if([[_zonaLesteData objectForKey:@"chuvaDiaria"]  doubleValue] > 0.0){
                    _chuvaLeste.image = [UIImage imageNamed:@"chuvaOn"];
                }else{
                    _chuvaLeste.image = [UIImage imageNamed:@"chuvaOff"];
                }

            }
            if (ident == 1)
            {
                self.zonaOesteData = aux;
                if([[_zonaOesteData objectForKey:@"chuvaDiaria"]  doubleValue] > 0.0){
                    _chuvaOeste.image = [UIImage imageNamed:@"chuvaOn"];
                }else{
                    _chuvaOeste.image = [UIImage imageNamed:@"chuvaOff"];
                }

            }
            if (ident == 2)
            {
                self.zonaSulData = aux;
                if([[_zonaSulData objectForKey:@"chuvaDiaria"]  doubleValue] > 0.0){
                    _chuvaSul.image = [UIImage imageNamed:@"chuvaOn"];
                }else{
                    _chuvaSul.image = [UIImage imageNamed:@"chuvaOff"];
                }

            }
           // NSLog(@"%@", [aux objectForKey:@"temperaturaExterna"]);
        }
    }
}

- (IBAction)clickNorte:(id)sender {
    //[_btnNorte setBackgroundImage:[UIImage imageNamed:@"norte"]  forState:UIControlStateNormal];
    [self performSegueWithIdentifier:@"gotoDetail" sender:@"norte"];
}
- (IBAction)clickOeste:(id)sender {
    [self performSegueWithIdentifier:@"gotoDetail" sender:@"oeste"];
}
- (IBAction)clickLeste:(id)sender {
    [self performSegueWithIdentifier:@"gotoDetail" sender:@"leste"];
}
- (IBAction)clickSul:(id)sender {
    [self performSegueWithIdentifier:@"gotoDetail" sender:@"sul"];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([sender isEqual:@"norte"]){
        DetailViewController *dvc = (DetailViewController *) segue.destinationViewController;
        dvc.valores=_zonaNorteData;
        dvc.imageName = @"norte";
    }else if([sender isEqual:@"leste"]){
        DetailViewController *dvc = (DetailViewController *) segue.destinationViewController;
        dvc.valores=_zonaLesteData;
        dvc.imageName = @"leste";
    }else if([sender isEqual:@"oeste"]){
        DetailViewController *dvc = (DetailViewController *) segue.destinationViewController;
        dvc.valores=_zonaOesteData;
        dvc.imageName = @"oeste";
    }else{
        DetailViewController *dvc = (DetailViewController *) segue.destinationViewController;
        dvc.valores=_zonaSulData;
        dvc.imageName = @"sul";
    }
}

-(IBAction)backFromDetail:(UIStoryboardSegue *)segue
{
}

- (IBAction)vovo:(id)sender {
    _boxVovo.hidden=NO;
    if([[_zonaNorteData objectForKey:@"chuvaDiaria"] doubleValue] > 0.0 && [[_zonaSulData objectForKey:@"temperaturaExterna"] doubleValue] < 20)
        _fraseDaVo.text = _comchuvaMenos20[arc4random()%(4)];
    else if([[_zonaNorteData objectForKey:@"chuvaDiaria"] doubleValue] > 0.0 && [[_zonaSulData objectForKey:@"temperaturaExterna"] doubleValue] >= 20)
        _fraseDaVo.text = _comchuvaMais20[arc4random()%(3)];
    else if([[_zonaSulData objectForKey:@"chuvaDiaria"] doubleValue] == 0.0 && [[_zonaSulData objectForKey:@"temperaturaExterna"] doubleValue] < 20)
        _fraseDaVo.text = _semchuvaMenos20[arc4random()%(4)];
    else
        _fraseDaVo.text = _semchuvaMais20[arc4random()%(4)];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _boxVovo.hidden=YES;
    _fraseDaVo.text=@"";
}


- (void)deviceLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    NSLog(@" lat: %f",_locationManager.location.coordinate.latitude);
    NSLog(@" lon: %f",_locationManager.location.coordinate.longitude);
    float lat = _locationManager.location.coordinate.latitude;
    float lon = _locationManager.location.coordinate.longitude;
    if (lat >= 29.970344 && lat <= -30.045445 && lon >= -51.086679 && lon <= -51.24299964){
        NSLog(@"está na região norte");
    }
}

@end
