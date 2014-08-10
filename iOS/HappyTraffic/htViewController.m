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

@property (strong, nonatomic) CAEmitterLayer *fireworksEmitter;
@end

//static NSString *kUrl = @"http://happytraffic.meteor.com";
static NSString *kUrl = @"http://localhost:3000/paymentsuccessful";
//static NSString *kUrl = @"http://happytraffic.meteor.com/pay?email=peter.perlay@gmail.com";
//static const NSString *kUrl = @"http://localhost:3000";

static NSString *kUrlTransactionSuccess = @"http://happytraffic.meteor.com/paymentsuccessful";
static NSString *kUrlTransactionFailed = @"http://happytraffic.meteor.com/paymentfailed";

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
    [self removeAnimations];
    if ([request.URL.path isEqualToString:@"/pay"]) {
        NSString *query = request.URL.query;
        NSLog(@"query: %@", query);
        NSString *email = [query substringFromIndex:6];
        NSLog(@"email: %@", email);
        [self payToUser:email];
        return NO;
    } else if ([request.URL.path isEqualToString:@"/paymentsuccessful"]) {
        [self showFireworks];
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
                                                             NSLog(@"Transaction succeeded");
                                                             [self._webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kUrlTransactionSuccess]]];
                                                         }
                                                         else {
                                                             NSLog(@"Transaction failed: %@", error);
                                                             [self._webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kUrlTransactionFailed]]];
                                                         }
                                                     }];
                             }
                             else {
                                 NSLog(@"Transaction denied: %@", error);
                                 [self._webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kUrlTransactionFailed]]];
                             }
                         }];
    
}

- (void)showFireworks
{
    // Cells spawn in the bottom, moving up
	self.fireworksEmitter = [CAEmitterLayer layer];
	CGRect viewBounds = self.view.layer.bounds;
	self.fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
	self.fireworksEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0.0);
	self.fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
	self.fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
	self.fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
	self.fireworksEmitter.seed = (arc4random()%100)+1;
	
	// Create the rocket
	CAEmitterCell* rocket = [CAEmitterCell emitterCell];
	
	rocket.birthRate		= 1.0;
	rocket.emissionRange	= 0.25 * M_PI;  // some variation in angle
	rocket.velocity			= 380;
	rocket.velocityRange	= 100;
	rocket.yAcceleration	= 75;
	rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
	
	rocket.contents			= (id) [[UIImage imageNamed:@"DazRing"] CGImage];
	rocket.scale			= 0.2;
	rocket.color			= [[UIColor redColor] CGColor];
	rocket.greenRange		= 1.0;		// different colors
	rocket.redRange			= 1.0;
	rocket.blueRange		= 1.0;
	rocket.spinRange		= M_PI;		// slow spin
	
    
	
	// the burst object cannot be seen, but will spawn the sparks
	// we change the color here, since the sparks inherit its value
	CAEmitterCell* burst = [CAEmitterCell emitterCell];
	
	burst.birthRate			= 1.0;		// at the end of travel
	burst.velocity			= 0;
	burst.scale				= 2.5;
	burst.redSpeed			=-1.5;		// shifting
	burst.blueSpeed			=+1.5;		// shifting
	burst.greenSpeed		=+1.0;		// shifting
	burst.lifetime			= 0.35;
	
	// and finally, the sparks
	CAEmitterCell* spark = [CAEmitterCell emitterCell];
	
	spark.birthRate			= 400;
	spark.velocity			= 125;
	spark.emissionRange		= 2* M_PI;	// 360 deg
	spark.yAcceleration		= 75;		// gravity
	spark.lifetime			= 3;
    
	spark.contents			= (id) [[UIImage imageNamed:@"DazRing"] CGImage];
	spark.scaleSpeed		=-0.2;
	spark.greenSpeed		=-0.1;
	spark.redSpeed			= 0.4;
	spark.blueSpeed			=-0.1;
	spark.alphaSpeed		=-0.25;
	spark.spin				= 2* M_PI;
	spark.spinRange			= 2* M_PI;
	
	// putting it together
	self.fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
	rocket.emitterCells				= [NSArray arrayWithObject:burst];
	burst.emitterCells				= [NSArray arrayWithObject:spark];
	[self._webView.layer addSublayer:self.fireworksEmitter];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fireworksEmitter setLifetime:0.0];
        //[self.fireworksEmitter setValue:[NSNumber numberWithFloat:0.0]
        //                     forKeyPath:@"emitterCells.rocket.birthRate"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fireworksEmitter removeFromSuperlayer];
        self.fireworksEmitter = nil;
    });
}

- (void)removeAnimations
{
    [self.fireworksEmitter removeFromSuperlayer];
    self.fireworksEmitter = nil;
}

@end
