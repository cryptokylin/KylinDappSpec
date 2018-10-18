//
//  ViewController.m
//  KylinSDK
//
//  Created by Rick on 2018/8/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import "KylinSDK.h"
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusForTransfering;
@property (weak, nonatomic) IBOutlet UILabel *statusForPushing;
@property (weak, nonatomic) IBOutlet UILabel *statusForSignature;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak ViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"wallet/login" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *res = note.object;
        NSInteger code = [res[@"code"] integerValue];
        NSString *msg = res[@"msg"];
        NSDictionary *accountInfo = res[@"accountinfo"];
        if (0 == code) {
            weakSelf.accountNameLabel.text = accountInfo[@"accountname"];
        } else {
            weakSelf.accountNameLabel.text = msg;
        }
    }];
//
    [[NSNotificationCenter defaultCenter] addObserverForName:@"pay" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *res = note.object;
//        NSInteger code = [res[@"code"] integerValue];
//        NSString *txid = res[@"txid"];
//        NSString *actionid = res[@"actionid"];
        NSString *msg = res[@"msg"];
        weakSelf.statusForTransfering.text = msg;
    }];
//
    [[NSNotificationCenter defaultCenter] addObserverForName:@"contract" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *res = note.object;
//        NSInteger code = [res[@"code"] integerValue];
//        NSString *txid = res[@"txid"];
//        NSString *actionid = res[@"actionid"];
        NSString *msg = res[@"msg"];;
        weakSelf.statusForPushing.text = msg;
    }];
//
    [[NSNotificationCenter defaultCenter] addObserverForName:@"wallet/sign" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *res = note.object;
//        NSInteger code = [res[@"code"] integerValue];
//        NSString *sign = res[@"sign"];
        NSString *msg = res[@"msg"];
        weakSelf.statusForSignature.text = msg;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getEOSAccount:(id)sender {
    [KylinSDK loginWithTokenID:@"eos" walletScheme:nil completionHandler:^(BOOL success) {
        ;
    }];
}

- (IBAction)transfer:(id)sender {
    [KylinSDK payToken:@"eos"
                  from:nil
                    to:@"eosaccount12"
                number:0.0001
                  memo:@"Just for Test"
              actionID:nil
                userID:nil
               message:@"EOS TO THE MOON !!!"
          walletScheme:nil
     completionHandler:^(BOOL success) {
         ;
     }];
}

- (IBAction)pushActions:(id)sender {
    [KylinSDK executeTokenContract:@"eos"
                           account:@"eosaccount11"
                           address:@"EOS5FSY7uwixFNF1mbvESmZ1w2mNgb3GhXUvdvS6GwdurYxXZqLSn"
                           actions:@[@{@"account":@"eosio.token",@"name":@"transfer",@"authorization":@[@{@"actor":@"eosaccount11",@"permission":@"active"}],@"data":@{@"from":@"eosaccount11",@"to":@"eosaccount12",@"quantity":@"0.0001 EOS",@"memo":@"sdk test"}}]
                           options:@{@"broadcast":@(YES)}
                          actionID:nil
                           message:@"EOS TO THE MOON !!!"
                      walletScheme:nil
                 completionHandler:^(BOOL success) {
                     ;
                 }];
}

- (IBAction)requestCustomSignature:(id)sender {
    [KylinSDK requestSignatureWithTokenID:@"eos" walletAccountName:@"eosaccount11" customData:@"for test" message:@"EOS TO THE MOON !!!" walletScheme:nil completionHandler:^(BOOL success) {
        ;
    }];
}


@end
