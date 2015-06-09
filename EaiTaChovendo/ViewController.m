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

@property (nonatomic) NSMutableDictionary * zonaNorteData;
@property (nonatomic) NSMutableDictionary * zonaSulData;
@property (nonatomic) NSMutableDictionary * zonaLesteData;
@property (nonatomic) NSMutableDictionary * zonaOesteData;

@property (nonatomic) NSArray * resultados;
@property (nonatomic) NSError * error;

@property (nonatomic,retain) CLLocationManager *locationManager;
@property CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
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
