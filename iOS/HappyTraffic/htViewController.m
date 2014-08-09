//
//  htViewController.m
//  HappyTraffic
//
//  Created by Akos Putz on 8/9/14.
//  Copyright (c) 2014 Haxe. All rights reserved.
//

#import "htViewController.h"

@interface htViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *_webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *_progressView;

@end

@implementation htViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._webView.delegate = self;
    [self._webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://happytraffic.meteor.com"]]];
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

@end
