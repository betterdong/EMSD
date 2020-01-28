//
//  CollectionHengView.h
//  EasyWedding
//
//  Created by wangliang on 16/10/27.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CollectionHShowIndicatorView;
@protocol CollectionHShowIndicatorViewProcotol <NSObject>
@optional

- (CGSize)hShowIndicatorView:( CollectionHShowIndicatorView *)hShowIndicatorView sizeForItemAtIndexPath:( NSIndexPath *)indexPath;
/**
 用户点击了cell
 */
- (void)hShowIndicatorView:(CollectionHShowIndicatorView *)hView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 collectionView.pagingEnabled=YES 时起作用,返回当前页码
 */
- (void)hShowIndicatorView:(CollectionHShowIndicatorView *)hView didChangeCurrentShowIndex:(NSInteger)index;

/**
 collectionView.pagingEnabled=YES 时起作用,在滑动停止时回调
 */
- (void)hShowIndicatorView:(CollectionHShowIndicatorView *)hView didDidEndDeceleratingCurrentShowIndex:(NSInteger)index;

/**
 view滑动时回调
 */
- (void)hShowIndicatorViewDidScroll:(CollectionHShowIndicatorView *)hShowIndicatorView;
@end

@interface CollectionHShowIndicatorView : UIView

@property (nonatomic ,weak) id<CollectionHShowIndicatorViewProcotol> delegate;
@property (nonatomic ,weak) id<CollectionHShowIndicatorViewProcotol> scorllDelegate;

@property (strong, nonatomic)  UICollectionView *collectionView;

@property (assign, nonatomic)  CGSize cellSize;


/**
 *  collectionView 数据源
 */
@property (strong, nonatomic)  NSArray *dataSource;

/**
 *  只能有一种 cell
 */
- (instancetype)initWithClassCell:(NSString *)classCellName modelName:(NSString *)modelName cellSize:(CGSize)size;
- (instancetype)initWithClassCell:(NSString *)classCellName modelName:(NSString *)modelName layout:(UICollectionViewFlowLayout *)layout;
- (instancetype)initWithNibCell:(NSString *)nibCellName modelName:(NSString *)modelName cellSize:(CGSize)size;

//- (void)setData:(NSArray *)dataArray;
- (void)setDefaultSelectIndexPath:(NSIndexPath *)defaultSelectIndexPath;


/**
 用于子类继承

 @param scrollView collectionView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)resetWithCellSize:(CGSize)cellSize;

@end
