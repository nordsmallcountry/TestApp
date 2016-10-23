//
//  ASLoginViewController.m
//  APITest
//
//  Created by Антон  Смирнов on 23.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "ASLoginViewController.h"
#import "ASAccessToken.h"

@interface ASLoginViewController () <UIWebViewDelegate>

@property (copy, nonatomic) ASLoginCompletionBlock completionBlock;

@property (weak, nonatomic) UIWebView* webView;

@end

@implementation ASLoginViewController

- (id) initWithCompletionBlock:(ASLoginCompletionBlock) completionBlock; {
    
    self = [super init];
    if (self) {

        self.completionBlock = completionBlock;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect r = self.view.bounds;
    
    r.origin = CGPointZero;
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:r];
    
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                         target:self
                                                                         action:@selector(actionCancel:)];
    [self.navigationItem setRightBarButtonItem:item animated:NO];
    
    self.navigationItem.title = @"Login";
    
    
    NSString* urlString =@"https://oauth.vk.com/authorize?"
    "client_id=5675670&"
    "scope=139286&"
    "redirect_uri=hello.there&"
    "display=mobile&"
    "V=5.59&"
    "response_type=token&revoke=1" ;
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionCancel:(UIBarButtonItem*) item {
    
    if (self.completionBlock){
        
        self.completionBlock(nil);
        
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void) dealloc {
    self.webView.delegate = nil;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[[request URL] host] isEqualToString:@"hello.there"]) {
        
        ASAccessToken* token = [[ASAccessToken alloc] init];
        
        NSString* query = [[request URL] description];
        
        NSArray* array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        
        
        NSArray* pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString* pair in pairs) {
            
            NSArray* values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                
                NSString* key = [values firstObject];
                if ([key isEqualToString:@"access_token"]) {
                    token.token = [values lastObject];
                    
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    
                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                } else if ([key isEqualToString:@"user_id"]) {
                    
                    token.userID = [values lastObject];
                    //userGlobalID = [values lastObject];
                }
                
            }
        }
        
        self.webView.delegate = nil;
        
        if (self.completionBlock){
            
            self.completionBlock(token);
            
        }
        
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
        
        
        return NO;
        
    }
    return YES;
}



@end
