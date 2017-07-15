//
//  YIDComingFromTopViewController.m
//  YIDSlideCollectionView
//
//  Created by ShannonChen on 16/8/15.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "YIDComingFromTopViewController.h"
#import "YIDCollectionViewCell.h"
#import "YIDComingFromTopFlowLayout.h"

NSString * const YIDUserInfoNameKey = @"YIDUserInfoNameKey";
NSString * const YIDUserInfoImageURLKey = @"YIDUserInfoImageURLKey";

static NSString * const kYIDCollectionViewCell = @"kYIDCollectionViewCell";
static const CGFloat kCellSizeCoef = .8f;

@interface YIDComingFromTopViewController () <UICollectionViewDataSource, UICollectionViewDelegate, YIDComingFromTopFlowLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray <NSDictionary *> *userInfoList;

@end

@implementation YIDComingFromTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfoList = @[
                          @{YIDUserInfoNameKey : @"Hellen",
                            YIDUserInfoImageURLKey : @"http://desktop.kole8.com/desktop/desk_file-11/4/22/2014/12/201412151334009_view.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Hannah",
                            YIDUserInfoImageURLKey : @"http://img14.poco.cn/mypoco/myphoto/20130217/21/52042291201302172143413872109164213_012.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Emily",
                            YIDUserInfoImageURLKey : @"http://images6.fanpop.com/image/photos/32600000/Love-Story-Lyrics-taylor-swift-32663031-1280-960.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Linsey",
                            YIDUserInfoImageURLKey : @"http://img.taopic.com/uploads/allimg/110319/9113-11031Z0332769.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Tape",
                            YIDUserInfoImageURLKey : @"http://img.taopic.com/uploads/allimg/130411/240472-1304110G15851.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Lisa",
                            YIDUserInfoImageURLKey : @"http://img01.taopic.com/141108/240479-14110QA33280.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Hellen",
                            YIDUserInfoImageURLKey : @"http://desktop.kole8.com/desktop/desk_file-11/4/22/2014/12/201412151334009_view.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Hannah",
                            YIDUserInfoImageURLKey : @"http://img14.poco.cn/mypoco/myphoto/20130217/21/5204229120130217214364213_012.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Emily",
                            YIDUserInfoImageURLKey : @"http://images6.fanpop.com/image/photos/32600000/Love-Story-Lyrics-taylor-swift-32663031-1280-960.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Linsey",
                            YIDUserInfoImageURLKey : @"http://img.taopic.com/uploads/allimg/110319/9113-11031Z0332769.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Tape",
                            YIDUserInfoImageURLKey : @"http://img.taopic.com/uploads/allimg/130411/240472-1304110G15851.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Lisa",
                            YIDUserInfoImageURLKey : @"http://img01.taopic.com/141108/240479-14110QA33280.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Hellen",
                            YIDUserInfoImageURLKey : @"http://desktop.kole8.com/desktop/desk_file-11/4/22/2014/12/201412151334009_view.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Hannah",
                            YIDUserInfoImageURLKey : @"http://img14.poco.cn/mypoco/myphoto/20130217/21/52042291201302172143413872109164213_012.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Emily",
                            YIDUserInfoImageURLKey : @"http://images6.fanpop.com/image/photos/32600000/Love-Story-Lyrics-taylor-swift-32663031-1280-960.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Linsey",
                            YIDUserInfoImageURLKey : @"http://img.taopic.com/uploads/allimg/110319/9113-11031Z0332769.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Tape",
                            YIDUserInfoImageURLKey : @"http://img.taopic.com/uploads/allimg/130411/240472-1304110G15851.jpg"},
                          
                          @{YIDUserInfoNameKey : @"Lisa",
                            YIDUserInfoImageURLKey : @"http://img01.taopic.com/141108/240479-14110QA33280.jpg"}

                          ];
    
    YIDComingFromTopFlowLayout *comingFromTopLayout = (YIDComingFromTopFlowLayout *)self.collectionView.collectionViewLayout;
    comingFromTopLayout.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark -=CollectionView datasource=-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userInfoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YIDCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kYIDCollectionViewCell forIndexPath:indexPath];
    
    NSDictionary *userInfo = self.userInfoList[indexPath.row];
    cell.imageURL = userInfo[YIDUserInfoImageURLKey];
    cell.nikeName = userInfo[YIDUserInfoNameKey];
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark -=CollectionView layout=-
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemHeight = indexPath.row % 2 ? 970 / 2 : 910 / 2;
    return CGSizeMake(CGRectGetWidth(self.view.bounds), itemHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.userInfoList.count - 1) {
        CGFloat cellHeight = [self collectionView:collectionView layout:collectionView.collectionViewLayout sizeForItemAtIndexPath:indexPath].height;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, collectionView.bounds.size.height - cellHeight, 0);
    }
}

#pragma mark -=YIDComingFromTopFlowLayoutDelegate=-
- (void)collectionViewFlowLayout:(YIDComingFromTopFlowLayout *)flowLayout didUpdateCellLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes withProposedFrame:(CGRect)frame {
    if (attributes.indexPath.item == 1) {
        NSLog(@"==========%g, %g, %g, %g, %g", frame.origin.y , self.collectionView.contentOffset.y, frame.origin.y + frame.size.height, self.collectionView.contentOffset.y - frame.origin.y, frame.size.height);
    }
    // if (contentOffset 大于 cell 的原点 y && contentOffset 小于 cell 的原点 y + cell 高度)
    // (contentOffset - cell 的原点 y) / cell 的高度
    
    NSIndexPath *indexPath = attributes.indexPath;
    YIDCollectionViewCell *cell = (YIDCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (self.collectionView.contentOffset.y > frame.origin.y &&
        self.collectionView.contentOffset.y < frame.origin.y + frame.size.height) {
        CGFloat ratio = (self.collectionView.contentOffset.y - frame.origin.y) / frame.size.height; // 0 ~ 1
        
        cell.cover.alpha = ratio;
    } else {
        cell.cover.alpha = 0;
    }
}

#pragma mark -=Action=-
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
