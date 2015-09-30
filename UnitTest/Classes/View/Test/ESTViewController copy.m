//
//  ESTViewController.m
//  UnitTest
//
//  Created by Maithri VM on 09/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//
#import "ESTViewController copy.h"

@interface ESTViewController1 ()

@end

@implementation ESTViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)testLongVariableName
{
    int testLongVariableNametestLongVariableNametestLongVariableName = 10;
    NSLog(@"%d",testLongVariableNametestLongVariableNametestLongVariableName);
}

-(void)testShortVariableName
{
    int t = 10;
    NSLog(@"%d",t);
}

@end
