//
//  DemoCollectionView.m
//  PageCollectionView
//
//  Created by qiulibi on 17/3/9.
//  Copyright © 2017年 qiulibi. All rights reserved.
//

#import "DemoCollectionView.h"

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation DemoCollectionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewLayout=layout;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-5)/4, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    //    self.backgroundColor=[UIColor colorWithRed:0.9804 green:0.9804 blue:0.9804 alpha:1.0];
    
}

@end
