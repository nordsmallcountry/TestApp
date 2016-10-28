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
#import "IndexPath.h"
#import "ASUser.h"
@interface ASFriendsPhotos ()
@property (strong, nonatomic) NSMutableArray* photosArray;

@property (assign, nonatomic) NSInteger itemCount;

@end

@implementation ASFriendsPhotos
static int im = 0;

static NSString * const reuseIdentifier = @"FriendsPhotosCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemCount = 0;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    

    
    self.photosArray = [NSMutableArray array];
   [self getPhotosFromServer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getPhotosFromServer {
    [[ASServerManager sharedManager]
     getPhotosWithOffset:[self.photosArray count]
     count:900
     onSuccess:^(NSArray* photos)
     {
         
         [self.photosArray addObjectsFromArray:photos];
        
         NSMutableArray* newPaths = [NSMutableArray array];
         
             
         for (int i = (int)[self.photosArray count] - (int)[photos count] ; i < [self.photosArray count];i++) { //FIX
             
                 [newPaths addObject: [NSIndexPath indexPathForItem:i inSection:1]];
             
             }
        // NSIndexPath* cruser = [[NSIndexPath alloc]init];
         //NSArray* contentCruser = [NSArray arrayWithObjects:cruser, nil];
         
             //[self.collectionView insertItemsAtIndexPaths:newPaths];
        
         //@catch (NSException *exception) {}
         
         //[self.collectionView insertItemsAtIndexPaths: contentCruser];

         [self.collectionView reloadData];
   
         //[self.collectionView reloadItemsAtIndexPaths:newPaths];
         
         
         
             
     }
     
       
     
     
     onFailure:^(NSError *error, NSInteger statusCode) {
         
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }
    
     ];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    NSLog(@"%ld",  (long)[self.photosArray count]);
    return [self.photosArray count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
     CustomImageCell* cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath
];
    
    ASUser* photo1 = [self.photosArray objectAtIndex:indexPath.item];
    NSLog(@"%ld", (long)im);
    NSLog(@"%@", photo1.imageURL);
    //self.itemCount++;
    im++;
    
    
    //[cell1 setCustomImageCellWith:photo1];
    
    
    return cell1;
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
