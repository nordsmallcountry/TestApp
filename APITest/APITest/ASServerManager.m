//
//  ASServerManager.m
//  APITest
//
//  Created by Антон  Смирнов on 21.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "ASServerManager.h"
#import "AFNetworking.h"
#import "ASUser.h"
#import "ASLoginViewController.h"
#import "ASAccessToken.h"
#import "ViewController.h"
#import "ID.h"
#import "ASAccessToken.h"
#import "Photo.h"

static NSString* userGlobalID = @"123";

@interface ASServerManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;
@property (strong, nonatomic) ASAccessToken* accessToken;

@end

@implementation ASServerManager

+ (ASServerManager*) sharedManager {
    
    
    static ASServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASServerManager alloc] init];
    });
    
    return manager;
}

- (id) init{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}



-(void) authorizeUser: (void(^)(ASUser* user)) completion {
    
    
    ASLoginViewController* vc =
     [[ASLoginViewController alloc] initWithCompletionBlock:^(ASAccessToken *token) {
         self.accessToken  = token;
         
         if (token) {
             
             
             [self getUser:self.accessToken.userID
                 onSuccess:^(ASUser *user) {
                     if(completion) {
                         completion(nil);
                     }
                 }
                 onFailure:^(NSError *error, NSInteger statusCode) {
                     if(completion) {
                         completion(nil);
                     }
                 }];
             
         } else if(completion) {
             completion(nil);
         }
     }];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIViewController* mainVC = [[[UIApplication sharedApplication] windows] firstObject].rootViewController;
    
    [mainVC presentViewController:nav
                         animated:YES
                       completion:nil];
    
}


- (void) getUser: (NSString*) userID
       onSuccess: (void(^)(ASUser* user)) success
       onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     userID, @"user_ids",
     @"photo_100", @"fields",nil];
    
    userGlobalID = params[@"user_ids"];
    
    
    [self.requestOperationManager GET:@"users.get" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary*  responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray* dictsArray = [responseObject objectForKey:@"response"];
        
        if ([dictsArray count] > 0 ) {
            ASUser* user = [[ASUser alloc]initWithServerResponse:[dictsArray firstObject]];
            if (success) {
                success(user);
            }
            
        } else {
            if(failure) {
                failure(nil, operation.response.statusCode);
            }

        }
        

        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        
        if(failure) {
            failure(error, operation.response.statusCode);
        }
    }];

    
}

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess: (void(^)(NSArray* friends)) success
                    onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure {
    
   NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     userGlobalID, @"user_id",
     @"name", @"order",
     @(count), @"count",
     @(offset), @"offset",
     @"photo_50, online", @"fields",
     [ASAccessToken sharedToken].token, @"access_token",nil];
    
   
    [self.requestOperationManager GET:@"friends.get" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary*  responseObject) {
        NSLog(@"JSON: %@", responseObject);
       // NSLog(@"THIS IS USER ID!!!!%@", [responseObject objectForKey:@"first_name"]);
        
        NSArray* dictsArray = [responseObject objectForKey:@"response"];
        
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* dict in dictsArray) {
            
            ASUser* user = [[ASUser alloc]initWithServerResponse:dict];
            [objectsArray addObject:user];
        }
        
        if(success) {
            success(objectsArray);//отправляем массив юзеров на уровень выше, таким образом сообщая, что программа выполнилась
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        
        if(failure) {
            failure(error, operation.response.statusCode);
        }
    }];
    
}








- (void) getPhotosWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess: (void(^)(NSArray* photos)) success
                    onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [ID sharedID].idToCollection, @"owner_id",
     @"0", @"extended",
     @(offset), @"offset",
     @(count), @"count",
     @"0", @"photo_sizes",
     @"0", @"no_service_albums",
     @"0", @"need_hidden",
     @"1", @"skip_hidden",
     [ASAccessToken sharedToken].token, @"access_token",nil];
    
    
    [self.requestOperationManager GET:@"photos.getAll" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary*  responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //NSString* dataString = [NSString stringWithFormat:@"%@",responseObject];
        //NSString* jsonString = [dataString stringByReplacingOccurrencesOfString:@"response =     (                                3," withString:@"("];
        
        //NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        //NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
        
        NSArray* dictResponse = [responseObject objectForKey:@"response"];
        
        NSMutableArray* resp = [NSMutableArray arrayWithArray:dictResponse];
        [resp removeObjectAtIndex:0];
        
        
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* dict in resp) {
            
            Photo* photo = [[Photo alloc]initWithPhotoResponse:dict];
            [objectsArray addObject:photo];
        }
        
        if(success) {
            success(objectsArray);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        
        if(failure) {
            failure(error, operation.response.statusCode);
        }
    }];
    
}

@end
