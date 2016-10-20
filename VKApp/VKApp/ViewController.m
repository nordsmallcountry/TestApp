//
//  ViewController.m
//  navigation
//
//  Created by Антон  Смирнов on 03.10.16.
//  Copyright © 2016 Anton Smirnov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title=@"VKApp";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapBringNextPageBtn:(id)sender {
    
    [self performSegueWithIdentifier:@"SegueToNextPageBtn" sender:self];
}
@end
