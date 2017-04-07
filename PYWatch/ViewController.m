//
//  ViewController.m
//  PYWatch
//
//  Created by PodiMac on 2017/4/7.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import "ViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>
@interface ViewController ()<WCSessionDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configiWatchOS];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[WCSession defaultSession] sendMessage:@{@"ios":@"i come from ios"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    
    } errorHandler:^(NSError * _Nonnull error)
    {
        
    }];
}
-(void)configiWatchOS
{
    if ([WCSession isSupported])
    {
        [[WCSession defaultSession] setDelegate:self];
        [[WCSession defaultSession] activateSession];
    }
}
-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    NSString *msg=[NSString stringWithFormat:@"%@",[message valueForKey:@"watch"]];
    [self.tipLabel setText:msg];
    if (replyHandler) {
        replyHandler(@{@"IOS":@"IOS"});
    }
}
-(void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error
{
    
}
-(void)sessionDidDeactivate:(WCSession *)session
{
    
}
-(void)sessionDidBecomeInactive:(WCSession *)session
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
