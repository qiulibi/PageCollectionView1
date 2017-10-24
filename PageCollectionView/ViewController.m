//
//  ViewController.m
//  PageCollectionView
//
//  Created by qiulibi on 17/3/8.
//  Copyright © 2017年 qiulibi. All rights reserved.
//

//随机色
#define LWLRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DemoCollectionView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet DemoCollectionView *collectionView;
@property(nonatomic, assign) NSUInteger pageCount;

@property (nonatomic, assign) NSInteger pageAllNum;//一页的总个数
@property (nonatomic, assign) NSInteger lineOfNumber;//几行
@property (nonatomic, assign) NSInteger numOfRow;//一行的个数
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    _pageAllNum = 8;
    _lineOfNumber = 2;
    _numOfRow = _pageAllNum/_lineOfNumber;
    
    _pageCount = 14;
    
    //一排显示四个,两排就是八个
    while (_pageCount % 8 != 0) {
        ++_pageCount;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _pageCount;
}


/*******************公式推导过程********************/
/**
 横向滑动时，如果能放两行的位置，一行有四个，那么其第一页放的实际位置是如下：
 0 ｜ 2 ｜ 4 ｜ 6
 1 ｜ 3 ｜ 5 ｜ 7
 我们需要的位置摆放如下：
 0 ｜ 1 ｜ 2 ｜ 3
 4 ｜ 5 ｜ 6 ｜ 7
 
 我们将实际位置和所需位置看作是一种函数关系，即x是实际位置，y是我们需要的位置，则他们对应的函数关系为：
 f(0)=0,
 f(1)=4,
 f(2)=1,
 f(3)=5,
 f(4)=2,
 f(5)=6,
 f(6)=3,
 f(7)=7,
 发现当x为偶数的时候，y总是为x／2，当为奇数的时候y总是为（x/2）+4，
 于是可以得到f(x)=x/2 + 4*(x%2)
 那么第2页与第1页实际也是有如此的类似的关系，只是比第一页对应的数多了一页的总个数
 所以第二页的就是第一页的总个数再套用对应的公式，也就是将x又从0开始，并且标记当前的总数
 于是推出第2页的函数关系为f(x)=（x-8）/2 + 4*（(x-8）%2) + 8
 所以第n页的函数关系为:设X=x-8*(x/8)  f(x)=X/2 + 4 * (X%2) + 8 * (x/8）
 假如放三行，一行还是四个，那么实际位置与需要的位置分别如下
 
     实际位置                                           需要位置
 0 ｜ 3 ｜ 6 ｜ 9                                  0 ｜ 1 ｜ 2  ｜ 3
 1 ｜ 4 ｜ 7 ｜ 10                                 4 ｜ 5 ｜ 6  ｜ 7
 2 ｜ 5 ｜ 8 ｜ 11                                 8 ｜ 9 ｜ 10 ｜ 11
 
 对应的函数关系为：
 f(0)=0, f(3)=1, f(6)=2, f(9)=3
 f(1)=4, f(4)=5, f(7)=6, f(10)=7
 f(2)=8, f(5)=9, f(8)=10,f(11)=10
 发现第一行y总是为x/3，以下的两行总是比上一行的结果多4，
 所以得到结论f(x)=x/3 + 4*(x%3)
 那么第n页的情况与一页两行的类似，只是对应的位置比第一行多12
 所以与前例类似得出如下结论
 设X=x-12*(x/12)  f(x)=X/3 + 4*(X%3) + 12*(x/12)
 
 与两行的结论相比，发现他们有共通之处，差别就在行数的多少
 于是可以得出一页有m行的情况，f(x)=x/m+4*(x%m)
 在这个结论上推到第n页的情况，设X=x - (m*4)*(x/(m*4)) 有f(x)=X/m + 4*(X%m) + (m*4)*(x/(m*4))，注意4*m是一页的总个数
 在该表达式中还有一个常数4，4代表的是一行的个数，所以，一行有多个也能推出对应的表达式，
 用a、b、c分别表示一页有几行、一行有几个及一页的总个数，其中c＝a*b;
 设X = x - c*(x/c)
 f(x)=X/a + b*(X%a) + c*(x/c)
 **/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"CollectionCell";
    
    CollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell
                                                     forIndexPath:indexPath];
    

    NSInteger row = indexPath.row;
    NSInteger X = row - _pageAllNum*(row/_pageAllNum);
    NSInteger currentRow = X/_lineOfNumber + _numOfRow*(X%_lineOfNumber) + _pageAllNum*(row/_pageAllNum);
//    if (currentRow < 14) {
        cell.title.text =
        [NSString stringWithFormat:@"第%ld个礼物", currentRow];
//    }
//    else {
//        cell.title.text = @"";
//    }
    return cell;
}




@end
