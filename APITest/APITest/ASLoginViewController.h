//
//  ASLoginViewController.h
//  APITest
//
//  Created by Антон  Смирнов on 23.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASServerManager.h"

@class ASAccessToken;

typedef void(^ASLoginCompletionBlock)(ASAccessToken* token);

@interface ASLoginViewController : UIViewController

- (id) initWithCompletionBlock:(ASLoginCompletionBlock) completionBlock;

@end
