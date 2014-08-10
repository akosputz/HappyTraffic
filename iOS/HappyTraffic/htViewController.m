//
//  htViewController.m
//  HappyTraffic
//
//  Created by Akos Putz on 8/9/14.
//  Copyright (c) 2014 Haxe. All rights reserved.
//

#import <Venmo-iOS-SDK/Venmo.h>
#import "htViewController.h"

@interface htViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *_webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *_progressView;

@end

//static NSString *kUrl = @"http://happytraffic.meteor.com";
static NSString *kUrl = @"http://happytraffic.meteor.com/pay?email=peter.perlay@gmail.com";
//static const NSString *kUrl = @"http://localhost:3000";

@implementation htViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._webView.delegate = self;
    [self._webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kUrl]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self._progressView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self._progressView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // maybe some error that it failed
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.path isEqualToString:@"/pay"]) {
        NSString *query = request.URL.query;
        NSLog(@"query: %@", query);
        NSString *email = [query substringFromIndex:6];
        NSLog(@"email: %@", email);
        [self payToUser:email];
        return NO;
    }
    return YES;
}

#pragma mark Logic

- (void)payToUser:(NSString*)user
{
    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments/*, VENPermissionAccessProfile*/]
                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 [[Venmo sharedInstance] sendPaymentTo:user
                                                                amount:100
                                                                  note:@"Sent by Honk"
                                                              audience:VENTransactionAudiencePrivate 
                                                     completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                                                         if (success) {
                                                             NSLog(@"Transaction succeeded!");
                                                         }
                                                         else {
                                                             NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                                                         }
                                                     }];
                             }
                             else {
                                 return;
                             }
                         }];
    
    }

@end
