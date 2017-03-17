//
//  ViewController.m
//  WJKit
//
//  Created by XHJ on 2017/3/6.
//  Copyright © 2017年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+WJAdd.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *foo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[self.view className]);
    _foo = @"asbsd";
    [self addObserver:self forKeyPath:@"foo" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@",_foo);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.foo = @"foo";
}

@end
