//
//  PWViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWViewController.h"

@interface PWViewController ()



@end

@implementation PWViewController
#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)routerURL:(NSString *)routerURL withParam:(NSDictionary *)param {
    [[PWRouter sharedInstance] routerURL:routerURL param:param];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

+ (NSString *)urlName {
    NSAssert(false, @"subclass must override");
    return @"base";
}
@end
