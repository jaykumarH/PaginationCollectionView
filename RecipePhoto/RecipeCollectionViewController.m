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
    UIImageView *leftSlider;
    UIImageView *rightSlider;
    NSTimer *timer;
    UILabel *recipeLabel;
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
    self.collectionViewObj.userInteractionEnabled=YES;
    [self setUpPageControl];
    [self setUpSliderArrows];
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
    rightSlider=[[UIImageView alloc] initWithFrame:CGRectMake(self.collectionViewObj.frame.size.width-30, self.collectionViewObj.frame.size.height/2, 30, 30)];
    rightSlider.image=[UIImage imageNamed:@"right.png"];
    rightSlider.userInteractionEnabled=YES;
    UITapGestureRecognizer *rightTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightSliderTapped)];
    [rightSlider addGestureRecognizer:rightTap];
    [self.view addSubview:rightSlider];
    leftSlider=[[UIImageView alloc] initWithFrame:CGRectMake(5, self.collectionViewObj.frame.size.height/2, 30, 30)];
    leftSlider.image=[UIImage imageNamed:@"left.png"];
    leftSlider.userInteractionEnabled=YES;
    UITapGestureRecognizer *leftTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftSliderTapped)];
    [leftSlider addGestureRecognizer:leftTap];
    [self.view addSubview:leftSlider];
    leftSlider.hidden=YES;
    rightSlider.hidden=YES;
    leftSlider.alpha=0;
    rightSlider.alpha=0;
    
    // add recipe label
    recipeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.collectionViewObj.frame.size.height/2-130, self.collectionViewObj.frame.size.width, 30)];
    recipeLabel.textAlignment=NSTextAlignmentCenter;
    recipeLabel.textColor=[UIColor darkGrayColor];
    recipeLabel.backgroundColor=[UIColor orangeColor];
    recipeLabel.text=[recipeImages objectAtIndex:0];
    [self.view addSubview:recipeLabel];
    
}

- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.collectionViewObj.frame.size.width;
    pageCount=(int)pageControl.currentPage;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage,self.collectionViewObj.contentOffset.y);
    [self.collectionViewObj setContentOffset:scrollTo animated:YES];
    recipeLabel.text=[recipeImages objectAtIndex:self.pageControl.currentPage];

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
    recipeLabel.text=[recipeImages objectAtIndex:self.pageControl.currentPage];

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
    recipeLabel.text=[recipeImages objectAtIndex:self.pageControl.currentPage];

}

#pragma mark -Scroll view delegates
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionViewObj.frame.size.width;
    self.pageControl.currentPage = self.collectionViewObj.contentOffset.x / pageWidth;
    pageCount=(int)self.pageControl.currentPage;
    if (leftSlider.hidden==YES && rightSlider.hidden==YES) {

        [UIView animateWithDuration:1.0 animations:^{
            leftSlider.hidden=NO;
            rightSlider.hidden=NO;
            leftSlider.alpha=1.0;
            rightSlider.alpha=1.0;
        } completion:nil];
    }
    recipeLabel.text=[recipeImages objectAtIndex:self.pageControl.currentPage];
  }
@end
