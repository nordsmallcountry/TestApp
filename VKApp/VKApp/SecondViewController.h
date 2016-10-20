//
//  SecondViewController.h
//  navigation
//
//  Created by Антон  Смирнов on 06.10.16.
//  Copyright © 2016 Anton Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView* webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* indicator;

- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str;

@end
