//
//  ViewController.m
//  APITest
//
//  Created by Антон  Смирнов on 21.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "ViewController.h"
#import "ASServerManager.h"
#import "ASUser.h"
#import "UIImageView+AFNetworking.h"
#import "CustomCell.h"
#import "UIImageView+WebCache.h"
#import "ID.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* friendsArray;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

static NSString* identifierCell = @"CustomCell";

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.friendsArray = [NSMutableArray array];
    
    self.firstTimeAppear = YES;
    
    [self configTable];
}


- (void) configTable {
    
    [self.tableView registerNib:[UINib nibWithNibName:identifierCell bundle:nil] forCellReuseIdentifier:identifierCell];
    self.tableView.tableFooterView = [UIView new];
}

//- (void) configCollection {
    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated ];
    
    if (self.firstTimeAppear) {
        self.firstTimeAppear = NO;
        
        [[ASServerManager sharedManager] authorizeUser:^(ASUser *user) {
            NSLog(@"AUTHORIZED");
            NSLog(@"%@ %@", user.firstName, user.lastName);
            [self getFriendsFromServer];
            
            //
        }];
    }
    
}




#pragma mark - API

-(void) getFriendsFromServer {
    
    [[ASServerManager sharedManager]
     getFriendsWithOffset:0
     count:0
     onSuccess:^(NSArray *friends) { //мы получили аргумент friends и используем его в исполнении блока, в случае успеха 

         
         [self.friendsArray addObjectsFromArray:friends];
         
         
         NSMutableArray* newPaths = [NSMutableArray array];
         
         for (int i = (int)[self.friendsArray count] - (int)[friends count] ;i < [self.friendsArray count] ; i++) { //FIX
             
            [newPaths addObject: [NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         [self.tableView beginUpdates];
         
         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
         
         [self.tableView endUpdates];
                                                    
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
             
               NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];
     
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return [self.friendsArray count];
   }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    
    
    
    CustomCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifierCell ];
    }
    
    ASUser* friend = [self.friendsArray objectAtIndex:indexPath.row];
    NSLog(@"%@", friend.firstName);
    NSLog(@"%@", friend.user_id);
    
    

    [cell setCustomCellWith:friend];
    
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"SegueToCollectionView" sender:self];
    //NSLog(@"YOR ROW IS %ld", (long)indexPath.row);
    ASUser* friend = [self.friendsArray objectAtIndex:indexPath.row];
    //NSLog(@"%@", friend.firstName);
    //NSLog(@"%@", friend.user_id);
    [ID sharedID].idToCollection = friend.user_id;

}

@end
