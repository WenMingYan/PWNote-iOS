//
//  TYAlertViewController.m
//  TYLibrary
//
//  Created by Lucca on 2019/1/17.
//

#import "TYAlertViewController.h"

@interface TYAlertViewController ()
@property (strong, nonatomic) TYAlertView *alertView;
@end

@implementation TYAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (nonnull instancetype)initWithAlertView:(nonnull TYAlertView *)alertView view:(nonnull UIView *)view {
    self = [super init];
    if (self) {
        self.alertView = alertView;
        
        self.view.backgroundColor = UIColor.clearColor;
        [self.view addSubview:view];
    }
    return self;
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
