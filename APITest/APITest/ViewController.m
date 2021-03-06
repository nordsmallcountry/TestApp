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

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* friendsArray;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.friendsArray = [NSMutableArray array];
    
    //
    self.firstTimeAppear = YES;
}


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
     getFriendsWithOffset:[self.friendsArray count]
     count:0
     onSuccess:^(NSArray *friends) {

         
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
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier ];
    }
    
    ASUser* friend = [self.friendsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", friend.firstName, friend.lastName, friend.online];
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:friend.imageURL];
    

     __weak UITableViewCell* weakCell = cell;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage: nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageView.image = image;
                                       [weakCell layoutSubviews];
                                       weakCell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2.0;
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                     
                                   }];
    
    return cell;
}

@end
