//
//  ViewController.m
//  LLPasswordView
//
//  Created by zdy on 2017/2/10.
//  Copyright © 2017年 lianlian. All rights reserved.
//

#import "ViewController.h"
#import "LLPasswordView.h"

@interface ViewController ()<LLPasswordViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LLPasswordView *codeView = [[LLPasswordView alloc] initWithFrame:CGRectMake(12, 40, CGRectGetWidth(self.view.bounds)-24, 44)];
    codeView.number = 6;
    codeView.delegate = self;
    codeView.normalBorderColor = [UIColor grayColor];
    codeView.selectedBorderColor = [UIColor redColor];
    [codeView becomeFirstResponder];
    [self.view addSubview:codeView];
}


-(void)passwordViewDidChange:(LLPasswordView *)passwordView {
    
}

- (void)passwordViewCompleteInput:(LLPasswordView *)passwordView {
    
}
@end
