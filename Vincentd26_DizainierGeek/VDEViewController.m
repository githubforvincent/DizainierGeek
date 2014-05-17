//
//  VDEViewController.m
//  Vincentd26_DizainierGeek
//
//  Created by Utilisation on 17/05/14.
//  Copyright (c) 2014 Utilisation. All rights reserved.
//

#import "VDEViewController.h"

@interface VDEViewController ()

@end

@implementation VDEViewController

//--------------------------------------------------------------------------------------------------------
-(BOOL) shouldAutorotate {
    //--------------------------------------------------------------------------------------------------------
    return YES;
}


//--------------------------------------------------------------------------------------------------------

- (void)viewDidLoad {
    //--------------------------------------------------------------------------------------------------------
    
    [super viewDidLoad];
    vue = [[VDEMyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[self view] addSubview:vue];}

//--------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    //--------------------------------------------------------------------------------------------------------
    [super didReceiveMemoryWarning];
    NSLog(@"Alerte mémoire");
    
    
}

@end
