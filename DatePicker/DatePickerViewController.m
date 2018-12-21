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
        [collectionView setDelegate:(id<UICollectionViewDelegate> _Nullable)self];
        [collectionView setDecelerationRate:UIScrollViewDecelerationRateFast];
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
//        for (int index = 0; index < [self.monthCollectionView numberOfItemsInSection:0]; index++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//            DatePickerCollectionViewCell *cell = (DatePickerCollectionViewCell *)[self.monthCollectionView cellForItemAtIndexPath:indexPath];
//            [cell.contentView setBackgroundColor:[UIColor lightGrayColor]];
//        }
//        for (int index = 0; index < [self.dayCollectionView numberOfItemsInSection:0]; index++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//            DatePickerCollectionViewCell *cell = (DatePickerCollectionViewCell *)[self.dayCollectionView cellForItemAtIndexPath:indexPath];
//            [cell.contentView setBackgroundColor:[UIColor lightGrayColor]];
//        }
        
        NSCalendar *calendar         = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year              = [self indexPathForItemAtCenterOfCollectionView:self.yearCollectionView  contentOffset:scrollView.contentOffset].item + 2001;
        components.month             = [self indexPathForItemAtCenterOfCollectionView:self.monthCollectionView contentOffset:scrollView.contentOffset].item + 1;
        components.day               = [self indexPathForItemAtCenterOfCollectionView:self.dayCollectionView   contentOffset:scrollView.contentOffset].item + 1;
        components.hour              = 0;
        components.minute            = 0;
        components.second            = 0;
        NSDate *date = [calendar dateFromComponents:components];
        NSRange rangeOfDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        
        NSInteger currentDays = [self.datePickerCollectionViewDataSource days];
        [self.datePickerCollectionViewDataSource setDays:rangeOfDays.length];
        [self.dayCollectionView reloadData];
        if (currentDays != rangeOfDays.length)
        {
            NSLog(@"Number of days between previous and current months are unequal...");
            if (components.day > rangeOfDays.length)
            {
                // scroll to indexPath based on difference
                NSInteger diff = rangeOfDays.length - components.day;
                NSLog(@"Current day (%lu) is outside the range of the number of days in current month (%lu) by %lu days", components.day, rangeOfDays.length, diff);
                // mod sum of diff and current index using currentDays.length
                NSInteger index = components.day - diff;
                NSLog(@"The new day is %lu", index);
                [self.dayCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:TRUE];
            } else {
                NSLog(@"Current day (%lu) is inside the range of the number of days in current month (%lu)", components.day, rangeOfDays.length);
            }
        }
        
        
        // if the current index path of centered item of the day collection view is outside of the range of days,
        // then scroll to the nearest adjacent item
//        NSIndexPath *indexPathForLastItemOfDayCollectionView = [NSIndexPath indexPathForItem:(rangeOfDays.length - 1) inSection:0];
//        NSIndexPath *indexPathForItemAtCenterOfDayCollectionView = [self indexPathForItemAtCenterOfCollectionView:self.dayCollectionView contentOffset:scrollView.contentOffset];
//        if ([indexPathForLastItemOfDayCollectionView compare:indexPathForItemAtCenterOfDayCollectionView] == NSOrderedSame)
//            [self.dayCollectionView scrollToItemAtIndexPath:indexPathForItemAtCenterOfDayCollectionView atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:TRUE];
        
        // change background color of centered cells
//        DatePickerCollectionViewCell *cellAtCenterOfMonthCollectionView = (DatePickerCollectionViewCell *)[self.monthCollectionView cellForItemAtIndexPath:indexPathForItemAtCenter];
//        DatePickerCollectionViewCell *cellAtCenterOfDayCollectionView   = (DatePickerCollectionViewCell *)[self.dayCollectionView   cellForItemAtIndexPath:indexPathForItemAtCenterOfDayCollectionView];
//        [cellAtCenterOfMonthCollectionView.contentView setBackgroundColor:[UIColor darkGrayColor]];
//        [cellAtCenterOfDayCollectionView.contentView setBackgroundColor:[UIColor darkGrayColor]];
    }
}

- (NSIndexPath *)indexPathForItemAtCenterOfCollectionView:(DatePickerCollectionView *)collectionView contentOffset:(CGPoint)contentOffset
{
   CGPoint centerPoint = CGPointMake(collectionView.center.x + contentOffset.x,
                                      collectionView.center.y + contentOffset.y);
    CGRect centerRect = CGRectMake(collectionView.center.x - 25.0, collectionView.center.y - 25.0, 50.0, 50.0);
    NSIndexPath *indexPath = [collectionView indexPathForItemAtPoint:centerPoint];
    dispatch_async(dispatch_get_main_queue(), ^{
        CATextLayer *layer = [CATextLayer new];
        [layer setFrame:CGRectOffset(centerRect, contentOffset.x, contentOffset.y)];
        [layer setBackgroundColor:[UIColor redColor].CGColor];
        [layer setString:[NSString stringWithFormat:@"%lu", indexPath.item]];
        [collectionView.layer addSublayer:layer];
    });
    
    return indexPath;
}

@end
