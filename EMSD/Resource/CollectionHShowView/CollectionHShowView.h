//
//  CollectionHengView.h
//  EasyWedding
//
//  Created by wangliang on 16/10/27.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CollectionHShowView;
@protocol CollectionHShowViewProcotol <NSObject>
@optional

- (CGSize)hShowView:( CollectionHShowView *)hShowView sizeForItemAtIndexPath:( NSIndexPath *)indexPath;
/**
 用户点击了cell
 */
- (void)hShowView:(CollectionHShowView *)hView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 collectionView.pagingEnabled=YES 时起作用,返回当前页码
 */
- (void)hShowView:(CollectionHShowView *)hView didChangeCurrentShowIndex:(NSInteger)index;

/**
 collectionView.pagingEnabled=YES 时起作用,在滑动停止时回调
 */
- (void)hShowView:(CollectionHShowView *)hView didDidEndDeceleratingCurrentShowIndex:(NSInteger)index;

/**
 view滑动时回调
 */
- (void)hShowViewDidScroll:(CollectionHShowView *)hShowView;
@end

@interface CollectionHShowView : UIView

@property (nonatomic ,weak) id<CollectionHShowViewProcotol> delegate;
@property (nonatomic ,weak) id<CollectionHShowViewProcotol> scorllDelegate;

@property (strong, nonatomic)  UICollectionView *collectionView;

@property (assign, nonatomic)  CGSize cellSize;
- (void)resetWithCellSize:(CGSize)cellSize;


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

@end
