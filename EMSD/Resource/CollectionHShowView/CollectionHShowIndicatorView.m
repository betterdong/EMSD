//
//  CollectionHengView.m
//  EasyWedding
//
//  Created by wangliang on 16/10/27.
//  Copyright © 2016年 com.jinyouapp. All rights reserved.
//

#import "CollectionHShowIndicatorView.h"

#import "Masonry.h"

//#import "AdsModel.h"
//#import "ShopSelectedCell.h"
//#import "ShopCaseCell.h"

@interface CollectionHShowIndicatorView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  只能有一种 cell
 */
@property (copy, nonatomic)  NSString * nibCellName;
@property (copy, nonatomic)  NSString * classCellName;
@property (copy, nonatomic)  NSString * modelName;
@property(nonatomic,strong)NSIndexPath* defaultSelectIndexPath;
@property (nonatomic ,strong) UICollectionViewFlowLayout * layout;

@property(strong,nonatomic) UIScrollView *scrollView;


@end

@implementation CollectionHShowIndicatorView

- (void)setDefaultSelectIndexPath:(NSIndexPath *)defaultSelectIndexPath{
    NSLog(@"defaultSelectIndexPath.item = %zd",defaultSelectIndexPath.item);
    _defaultSelectIndexPath  = defaultSelectIndexPath;
    if (self.dataSource.count>defaultSelectIndexPath.item) {
        
        [self.collectionView selectItemAtIndexPath:defaultSelectIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];

    }
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.collectionView reloadData];
    if (_defaultSelectIndexPath && (self.dataSource.count>_defaultSelectIndexPath.item)) {
        
        [self.collectionView selectItemAtIndexPath:_defaultSelectIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
        
    }
//    [self setUpScrollView];
}

- (instancetype)initWithClassCell:(NSString *)classCellName modelName:(NSString *)modelName cellSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.classCellName = classCellName;
        self.modelName = modelName?modelName:classCellName;
        self.cellSize = size;
        [self otherInit];
    }
    return self;
}

- (instancetype)initWithClassCell:(NSString *)classCellName modelName:(NSString *)modelName layout:(UICollectionViewFlowLayout *)layout{
    self = [super init];
    if (self) {
        self.classCellName = classCellName;
        self.modelName = modelName?modelName:classCellName;
        self.cellSize = layout.itemSize;
        self.layout = layout;
        [self otherInit];
    }
    return self;
}

- (instancetype)initWithNibCell:(NSString *)nibCellName modelName:(NSString *)modelName cellSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.nibCellName = nibCellName;
        self.modelName = modelName?modelName:nibCellName;
        self.cellSize = size;
        [self otherInit];
    }
    return self;
}

- (void)resetWithCellSize:(CGSize)cellSize{
    self.cellSize = cellSize;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self otherInit];
    [self.collectionView reloadData];
}


- (void)setUpScrollView{
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat width = self.cellSize.width * self.dataSource.count;
    
    if (width>self.width) {
        
        UIView * contentView = [UIView new];
        [_scrollView addSubview:contentView];
        WS(weakSelf)
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(3.5);
            make.bottom.mas_equalTo(3.5);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(6);
            make.width.mas_equalTo(weakSelf.scrollView.mas_width).multipliedBy(2).offset(-67);
        }];
        contentView.backgroundColor = [UIColor colorWithHexString:@"535975"];
        
        UIView * scrView = [UIView new];
        [contentView addSubview:scrView];
        [scrView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.mas_equalTo(67);
            make.height.mas_equalTo(13);
        }];
        scrView.backgroundColor = [UIColor colorWithHexString:@"535975"];
        scrView.layer.cornerRadius = 5;
        scrView.layer.masksToBounds = YES;
    }
}

- (void)otherInit{
    
    UIScrollView * scrollView = [UIScrollView new];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    _scrollView = scrollView;
    
    
    
    
    
    WS(weakself);
    UICollectionViewFlowLayout * layout = self.layout;
    if (!layout) {
        layout =[[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.cellSize;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself);
        make.right.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself).offset(0);
        make.bottom.mas_equalTo(scrollView.mas_top);
//        make.bottom.mas_equalTo(weakself);
    }];
    
    if (self.classCellName) {
        [_collectionView registerClass:NSClassFromString(self.classCellName) forCellWithReuseIdentifier:self.modelName];
    }
    if (self.nibCellName) {
        [_collectionView registerNib:[UINib nibWithNibName:self.nibCellName bundle:nil] forCellWithReuseIdentifier:self.modelName];
    }

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = YES;
    [_collectionView reloadData];
    
    _collectionView.showsHorizontalScrollIndicator = YES;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id model = _dataSource[indexPath.item];
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.modelName forIndexPath:indexPath];
    //    [cell setDataWithModel:model];
    if ([cell respondsToSelector:@selector(setDataWithModel:)]) {
        [cell performSelector:@selector(setDataWithModel:) withObject:model];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(hShowIndicatorView:didSelectedItemAtIndexPath:)]) {
        [self.delegate hShowIndicatorView:self didSelectedItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(hShowIndicatorView:sizeForItemAtIndexPath:)]) {
        return [self.delegate hShowIndicatorView:self sizeForItemAtIndexPath:indexPath];
    }
    return self.cellSize;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = 0;
    if (self.collectionView) {
        index = (scrollView.contentOffset.x+scrollView.frame.size.width/2.0)/scrollView.frame.size.width;
    }else{
        index = (scrollView.contentOffset.y+scrollView.frame.size.height/2.0)/scrollView.frame.size.height;
    }

    if ([self.delegate respondsToSelector:@selector(hShowIndicatorView:didChangeCurrentShowIndex:)]) {
        [self.delegate hShowIndicatorView:self didChangeCurrentShowIndex:index];
    }
    if ([self.scorllDelegate respondsToSelector:@selector(hShowIndicatorViewDidScroll:)]) {
        [self.scorllDelegate hShowIndicatorViewDidScroll:self];
    }
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSLog(@"offsetX = %f",offsetX);
    if ([scrollView isEqual:_scrollView]) {
        CGFloat offsetCollectionView = self.collectionView.contentSize.width * offsetX/self.scrollView.contentSize.width;
//        CGFloat canOffsetX = self.collectionView.contentSize.width;
        self.collectionView.contentOffset = CGPointMake(offsetCollectionView, 0);
        
    }else{
        CGFloat offsetCollectionView = self.scrollView.contentSize.width * offsetX/self.collectionView.contentSize.width;
        self.scrollView.contentOffset = CGPointMake(offsetCollectionView, 0);
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = 0;
    if (self.collectionView) {
        index = (scrollView.contentOffset.x+scrollView.frame.size.width/2.0)/scrollView.frame.size.width;
    }else{
        index = (scrollView.contentOffset.y+scrollView.frame.size.height/2.0)/scrollView.frame.size.height;
    }
    
    if ([self.delegate respondsToSelector:@selector(hShowIndicatorView:didDidEndDeceleratingCurrentShowIndex:)]) {
        [self.delegate hShowIndicatorView:self didDidEndDeceleratingCurrentShowIndex:index];
    }
}

@end
