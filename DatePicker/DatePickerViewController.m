//
//  DatePickerViewController.m
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import "DatePickerViewController.h"
#import "DatePickerCollectionView.h"
#import "DatePickerCollectionViewCell.h"
#import "DatePickerCollectionViewData.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.datePickerCollectionViews enumerateObjectsUsingBlock:^(DatePickerCollectionView *  _Nonnull collectionView, NSUInteger tag, BOOL * _Nonnull stop) {
        [collectionView registerClass:[DatePickerCollectionViewCell class] forCellWithReuseIdentifier:self.datePickerCollectionViewDataSource.reuseIdentifier];
        [collectionView setDataSource:(id<UICollectionViewDataSource> _Nullable)self.datePickerCollectionViewDataSource];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
