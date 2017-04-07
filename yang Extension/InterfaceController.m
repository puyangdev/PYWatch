//
//  InterfaceController.m
//  yang Extension
//
//  Created by PodiMac on 2017/4/7.
//  Copyright © 2017年 于浦洋. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController ()<WCSessionDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *sendBtn;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *tipLabel;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    [self configiWatchOS];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}
-(void)configiWatchOS
{
    if ([WCSession isSupported])
    {
        [[WCSession defaultSession] setDelegate:self];
        [[WCSession defaultSession] activateSession];
    }
}
- (IBAction)sendMsgToiOS
{
    [[WCSession defaultSession] sendMessage:@{@"watch":@"i come from watch"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
//
       
        
    } errorHandler:^(NSError * _Nonnull error)
     {
         
     }];
}
-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    NSString *msg=[NSString stringWithFormat:@"%@",[message valueForKey:@"ios"]];
     [self.tipLabel setText:msg];
    if (replyHandler) {
        replyHandler(@{@"WATCH":@"WATCH"});
    }
}
-(void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error
{
   
}
- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



