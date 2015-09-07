//
//  ViewController.m
//  My Own Scrollview
//
//  Created by asu on 2015-09-07.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "SVMainViewController.h"
#import "SVMyScrollView.h"

@interface SVMainViewController ()
@property (weak, nonatomic) IBOutlet SVMyScrollView *containerView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation SVMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"%@", self.containerView);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[self.containerView setBounds:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)];
    
    
}
@end
