//
//  SecondViewController.m
//  navigation
//
//  Created by Антон  Смирнов on 06.10.16.
//  Copyright © 2016 Anton Smirnov. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize webView;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"Authorization";
    
    NSString* authString = @"http://oauth.vk.com/authorize?client_id=5675670&scope=audio&redirect_uri=http://oath.vk.com/blank.html&display=touch&response_type=token";
    
    NSURL* authURL = [NSURL URLWithString:authString];
    NSURLRequest* request = [NSURLRequest requestWithURL:authURL];
    [self.webView loadRequest:request];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"shouldStartLoadWithRequest %@", [request debugDescription]);
    
    NSURL *URL = [request URL]; //If user will choose "cancel" button
    if ([[URL absoluteString] isEqualToString:@"http://oauth.vk.com/blank.html#error=access_denied&error_reason=user_denied&error_description=User%20denied%20your%20request"]) {
        //[super dismissModalViewControllerAnimated:YES];
        return NO;
    }
    NSLog(@"Request: %@", [URL absoluteString]);
    return YES;
};



- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidStartLoad");
    
    [self.indicator startAnimating];
    
};


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
  
    NSLog(@"webViewDidFinishLoad");
    
    
    [self.indicator stopAnimating];
    
    if ([webView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound) {
    NSString* accessToken = [self stringBetweenString:@"access_token="
                                                andString:@"&"
                                              innerString:[[[webView request] URL] absoluteString]];
    
    
        NSLog(@"%@", accessToken);
    
    }
};


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"didFailLoadWithError %@", [error localizedDescription]);
    
    [self.indicator stopAnimating];

    
};



#pragma mark - Methods

- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str
{
    NSScanner* scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}



@end
