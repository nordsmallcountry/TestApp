//
//  ASFriendsPhotos.m
//  APITest
//
//  Created by Антон  Смирнов on 27.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "ASFriendsPhotos.h"
#import "ASServerManager.h"
#import "ID.h"
#import "CustomImageCell.h"
#import "Photo.h"
@interface ASFriendsPhotos ()
@property (strong, nonatomic) NSMutableArray* photosArray;

@end


@implementation ASFriendsPhotos

static NSString*  reuseIdentifier = @"CustomImageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    //self.clearsSelectionOnViewWillAppear = NO;
    
    
    [self.collectionView registerClass:[CustomImageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    

    
    self.photosArray = [NSMutableArray array];
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self getPhotosFromServer];
}


-(void) getPhotosFromServer {
    [[ASServerManager sharedManager]
     getPhotosWithOffset:[self.photosArray count]
     count:150
     onSuccess:^(NSArray* photos)
     {
         [self.photosArray addObjectsFromArray:photos];

         [self.collectionView reloadData];
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    //NSLog(@"%ld",  (long)[self.photosArray count]);
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self.photosArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     CustomImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath
];
    Photo* photo1 = [self.photosArray objectAtIndex:indexPath.item];
    NSLog(@"%ld", (long)indexPath.item);
    NSLog(@"%@", photo1.imageURL);
    
   
    
    
        [cell setCustomCellWith:photo1];
    

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */


     

@end
