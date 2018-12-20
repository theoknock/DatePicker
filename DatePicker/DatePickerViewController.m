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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.monthCollectionView])
    {
        // set the background color of all remaining cells back to light gray...
        for (int index = 0; index < [self.monthCollectionView numberOfItemsInSection:0]; index++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            DatePickerCollectionViewCell *cell = (DatePickerCollectionViewCell *)[self.monthCollectionView cellForItemAtIndexPath:indexPath];
            [cell.contentView setBackgroundColor:[UIColor lightGrayColor]];
        }
        for (int index = 0; index < [self.dayCollectionView numberOfItemsInSection:0]; index++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            DatePickerCollectionViewCell *cell = (DatePickerCollectionViewCell *)[self.dayCollectionView cellForItemAtIndexPath:indexPath];
            [cell.contentView setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        NSCalendar *calendar         = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year              = 2018;
        components.day               = 1;
        
        CGPoint centerPoint = CGPointMake((CGRectGetWidth(self.monthCollectionView.frame)  / 2.0) + scrollView.contentOffset.x,
                                          (CGRectGetHeight(self.monthCollectionView.frame) / 2.0) + scrollView.contentOffset.y);
        NSIndexPath *indexPathForItemAtCenter = [self.monthCollectionView indexPathForItemAtPoint:centerPoint];
        [self.monthCollectionView scrollToItemAtIndexPath:indexPathForItemAtCenter atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:TRUE];
        NSLog(@"x\t%f\t\ty\t%f\t\titem\t%lu", centerPoint.x, centerPoint.y, indexPathForItemAtCenter.item);
        components.month = indexPathForItemAtCenter.item;
        components.hour              = 0;
        components.minute            = 0;
        components.second            = 0;
        NSDate *date = [calendar dateFromComponents:components];
        NSRange rangeOfDays  = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        
        NSLog(@"month\t%lu\t\trangeOfDays.length\t%lu", components.month, rangeOfDays.length);
        [self.datePickerCollectionViewDataSource setDays:rangeOfDays.length];
        [self.dayCollectionView reloadData];
        
        // if index path of centered item of the day collection view is last day of the month...
        NSIndexPath *indexPathForLastItemOfDayCollectionView = [NSIndexPath indexPathForItem:(rangeOfDays.length - 1) inSection:0];
        CGPoint centerPointOfDayCollectionView = CGPointMake((CGRectGetWidth(self.dayCollectionView.frame)  / 2.0) + CGRectGetWidth(self.monthCollectionView.frame) + scrollView.contentOffset.x,
                                                             (CGRectGetHeight(self.dayCollectionView.frame) / 2.0) + scrollView.contentOffset.y);
        NSIndexPath *indexPathForItemAtCenterOfDayCollectionView = [self.dayCollectionView indexPathForItemAtPoint:centerPointOfDayCollectionView];
        if ([indexPathForLastItemOfDayCollectionView compare:indexPathForItemAtCenterOfDayCollectionView] == NSOrderedSame)
            [self.dayCollectionView scrollToItemAtIndexPath:indexPathForItemAtCenterOfDayCollectionView atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:TRUE];
        
        // change background color of centered cells
        DatePickerCollectionViewCell *cellAtCenterOfMonthCollectionView = (DatePickerCollectionViewCell *)[self.monthCollectionView cellForItemAtIndexPath:indexPathForItemAtCenter];
        DatePickerCollectionViewCell *cellAtCenterOfDayCollectionView   = (DatePickerCollectionViewCell *)[self.dayCollectionView   cellForItemAtIndexPath:indexPathForItemAtCenterOfDayCollectionView];
        [cellAtCenterOfMonthCollectionView.contentView setBackgroundColor:[UIColor darkGrayColor]];
        [cellAtCenterOfDayCollectionView.contentView setBackgroundColor:[UIColor darkGrayColor]];
    }
}

@end
