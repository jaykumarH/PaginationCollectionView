//
//  RecipeCollectionViewController.m
//  RecipePhoto
//
//  Created by Simon on 13/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RecipeCollectionViewController.h"

@interface RecipeCollectionViewController () {
    NSArray *recipeImages;
    int pageCount;
}

@end

@implementation RecipeCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize recipe image array
    self.title=@"Recipe Photo";

    recipeImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
    pageCount=0;
    [self setUpPageControl];
    [self setUpSliderArrows];
 //   [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer:) userInfo:self.pageControl repeats:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Collection View Data source and delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return recipeImages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    
    return cell;
}
#pragma mark -Custom Methods
-(void)setUpPageControl
{
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    // Set up the page control
    CGRect frame = CGRectMake(0, h - 20, w, 20);
    self.pageControl = [[UIPageControl alloc]
                        initWithFrame:frame
                        ];
    self.pageControl.backgroundColor=[UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor=[UIColor darkGrayColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor blackColor];
    [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    self.pageControl.numberOfPages = [recipeImages count];
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pageControl];
   
}
-(void)setUpSliderArrows
{
    UIImageView *rightSlider=[[UIImageView alloc] initWithFrame:CGRectMake(self.collectionViewObj.frame.size.width-30, self.collectionViewObj.frame.size.height/2, 30, 30)];
    rightSlider.image=[UIImage imageNamed:@"right.png"];
    rightSlider.userInteractionEnabled=YES;
    UITapGestureRecognizer *rightTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightSliderTapped)];
    [rightSlider addGestureRecognizer:rightTap];
    [self.view addSubview:rightSlider];
    UIImageView *leftSlider=[[UIImageView alloc] initWithFrame:CGRectMake(5, self.collectionViewObj.frame.size.height/2, 30, 30)];
    leftSlider.userInteractionEnabled=YES;
    UITapGestureRecognizer *leftTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftSliderTapped)];
    [leftSlider addGestureRecognizer:leftTap];
    leftSlider.image=[UIImage imageNamed:@"left.png"];
    [self.view addSubview:leftSlider];
    
}
- (void)handleTimer:(NSTimer*)theTimer {
    
    NSLog (@"Got the string: %@", (NSString*)[theTimer userInfo]);
    [self pageControlChanged:[theTimer userInfo]];
    
}
- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.collectionViewObj.frame.size.width;
    pageCount=(int)pageControl.currentPage;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage,self.collectionViewObj.contentOffset.y);
    [self.collectionViewObj setContentOffset:scrollTo animated:YES];
}
-(void)rightSliderTapped
{
    CGFloat pageWidth = self.collectionViewObj.frame.size.width;
    pageCount++;
    if (pageCount!=recipeImages.count) {
        self.pageControl.currentPage =pageCount;
        CGPoint scrollTo = CGPointMake(pageWidth * self.pageControl.currentPage,self.collectionViewObj.contentOffset.y);
        [self.collectionViewObj setContentOffset:scrollTo animated:YES];
    }
}
-(void)leftSliderTapped
{
    CGFloat pageWidth = self.collectionViewObj.frame.size.width;
    
    if (pageCount!=0) {
        pageCount--;
        self.pageControl.currentPage =pageCount;
        CGPoint scrollTo = CGPointMake(pageWidth * self.pageControl.currentPage,self.collectionViewObj.contentOffset.y);
        [self.collectionViewObj setContentOffset:scrollTo animated:YES];
    }
}
#pragma mark -Scroll view delegates
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionViewObj.frame.size.width;
    self.pageControl.currentPage = self.collectionViewObj.contentOffset.x / pageWidth;
    pageCount=(int)self.pageControl.currentPage;
}
@end
