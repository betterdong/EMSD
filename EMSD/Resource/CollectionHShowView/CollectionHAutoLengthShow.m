//
//  CollectionHAutoLengthShow.m
//  OSPMobile
//
//  Created by 栋 on 2018/10/25.
//  Copyright © 2018年 Pansoft. All rights reserved.
//

#import "CollectionHAutoLengthShow.h"
#import "CollectionAutoLengthCell.h"
@interface CollectionHAutoLengthShow()

@property (nonatomic ,strong) CollectionAutoLengthCell * cellCalculate;


@end

@implementation CollectionHAutoLengthShow



- (UICollectionViewCell *)cellCalculate{
    if (!_cellCalculate) {
        NSString * classCellName = [self valueForKey:@"classCellName"];
        if (classCellName) {
            Class cellClass = NSClassFromString(classCellName);
            _cellCalculate = [[cellClass alloc] init];
        }else{
            NSString * nibCellName = [self valueForKey:@"nibCellName"];
            _cellCalculate = [[[NSBundle mainBundle] loadNibNamed:nibCellName owner:nil options:nil] lastObject];
        }
    }
    return _cellCalculate;
}

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    CGSize size = [self.cellCalculate getCellSizeWithDataModel:self.dataSource[indexPath.row]];
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return self.cellSize;
    }
    return size;
}


@end
