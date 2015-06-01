//
//  RecipeCollectionViewController.h
//  RecipePhoto
//
//  Created by Simon on 13/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionViewController : UICollectionViewController
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewObj;
@property(strong,nonatomic) IBOutlet UIPageControl *pageControl;
@end
