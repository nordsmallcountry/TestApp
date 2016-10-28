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
    
    CGRect r = self.view.bounds;  //bounds - зона самого view, r - объект с возможностью задания границ
    
    r.origin = CGPointMake(0, 0);
    
    UIWebView* webView1 = [[UIWebView alloc] initWithFrame:r]; //объявляем объект webview с заданными границами
    
    webView1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:webView1]; //добавляем в зону view элемент webView
    
    self.webView = webView1; //Н.О устанавливаем значение property webView текущего класса равным новоиспеченному объекту
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                         target:self
                                                                         action:@selector(actionCancel:)];
    //объявляем инициализируем объект для создания кнопки cancel  и при нажатии на эту кнопку вызываем метод actionCancel, который убирает текущий viewcontroller и Н. О обнуляет CompletionBlock
    
    [self.navigationItem setRightBarButtonItem:item animated:NO]; //на панели навигации uinavigationcontroller устанавливаем нашу кнопку cancel
    
    self.navigationItem.title = @"Login";
    
    
    NSString* urlString =@"https://oauth.vk.com/authorize?"
    "client_id=5675670&"
    "scope=139286&"
    "redirect_uri=hello.there&"
    "display=mobile&"
    "V=5.59&"
    "response_type=token&revoke=1" ; //переменная с запросом для получения токена
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [webView1 loadRequest:request]; //выполняет добавление webview данными согласно запросу
    
     webView1.delegate = self; //передает управление методу в протоколе uiwebviewdelegate - реализует показ самого webview
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Actions

- (void) actionCancel:(UIBarButtonItem*) item {
    
    /*
    if (self.completionBlock){
        
        self.completionBlock(nil);
        
    }
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void) dealloc {
    self.webView.delegate = nil;
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType { //стартовый экран и дальнейшие действия
    
        if ([[[request URL] host] isEqualToString:@"hello.there"]) { //если редирект  равен hello.there
        
       // ASAccessToken* token = [[ASAccessToken alloc] init]; //объявляем объект token класса ACAcess.., у которого есть три properties
        
        NSString* query = [[request URL] description];
        
        NSArray* array = [query componentsSeparatedByString:@"#"]; //инициализируем массив array и заполняем его элементами, разделенными знаком #
        
        if ([array count] > 1) { //если элементов в массиве больше одного
          query = [array lastObject]; // присваеваем объекту query значение последнего элемента массива array
        }
        
        
        NSArray* pairs = [query componentsSeparatedByString:@"&"]; //заполняем массив элементами,разделенными знаком &
        
        
        
        for (NSString* pair in pairs) {//строку pair, до этого разделенную знаком &
            
            NSArray* values = [pair componentsSeparatedByString:@"="];//разделяем ее знаком = и заносим в массив разделенные элементы
            
            if ([values count] == 2) { //если таких элементов в массиве ровно 2
                
                NSString* key = [values firstObject];//копируем первый элемент
                if ([key isEqualToString:@"access_token"]) {//и если он равен "access_token"
                    [ASAccessToken sharedToken].token = [values lastObject];//сохраняем токен
                    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!       !!!!!!   !!!%@", [ASAccessToken sharedToken].token);
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];//
                    
                    [ASAccessToken sharedToken].expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];//сохраняем время действия токена
                } else if ([key isEqualToString:@"user_id"]) {
                    
                    [ASAccessToken sharedToken].userID = [values lastObject];//сохраняем ID пользователя
                    
                }
                
             }
         }
        
        self.webView.delegate = nil;//останавливает передачу управления по делегату
        
        if (self.completionBlock){
            
            self.completionBlock([ASAccessToken sharedToken]);
            
        }
        
        [self dismissViewControllerAnimated:YES
                                 completion:nil]; //убирает asloginviewcontroller
        
        
         //return NO;
            
        }
    return YES;
}



@end
