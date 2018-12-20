//
//  DatePickerCollectionViewData.m
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import "DatePickerCollectionViewData.h"
#import "DatePickerCollectionView.h"
#import "DatePickerCollectionViewCell.h"

@interface DatePickerCollectionViewData ()
{
    NSUInteger month;
    NSArray<NSString *> *months;
}

@end

@implementation DatePickerCollectionViewData

@synthesize days = _days;

- (void)setDays:(NSUInteger)days
{
    _days = days;
}

- (NSUInteger)days
{
    return self->_days;
}

static NSString * const reuseIdentifier = @"DatePickerCollectionViewCell";

- (void)awakeFromNib
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super awakeFromNib];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    months = [dateFormatter shortMonthSymbols];
}

- (nonnull __kindof DatePickerCollectionViewCell *)collectionView:(nonnull DatePickerCollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DatePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    switch ((DatePickerCollectionViewType)collectionView.tag) {
        case DatePickerCollectionViewTypeMonth:
        {
            [cell setString:[months objectAtIndex:indexPath.item]];
            break;
        }
        case DatePickerCollectionViewTypeDay:
        {
            [cell setString:[NSString stringWithFormat:@"%lu", 1 + indexPath.item]];
            break;
        }
        case DatePickerCollectionViewTypeYear:
        {
            [cell setString:[NSString stringWithFormat:@"%lu", 2001 + indexPath.item]];
            break;
        }
        case DatePickerCollectionViewTypeHour:
        {
            [cell setString:[NSString stringWithFormat:@"%lu", indexPath.item]];
            break;
        }
        case DatePickerCollectionViewTypeMinute:
        {
            [cell setString:[NSString stringWithFormat:@"%lu", indexPath.item]];
            break;
        }
        case DatePickerCollectionViewTypeSecond:
        {
            [cell setString:[NSString stringWithFormat:@"%lu", indexPath.item]];
            break;
        }
        default:
        {
            
            break;
        }
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch ((DatePickerCollectionViewType)collectionView.tag) {
        case DatePickerCollectionViewTypeMonth:
        {
            return 12;
            break;
        }
        case DatePickerCollectionViewTypeDay:
        {
            return self->_days;
            break;
        }
        case DatePickerCollectionViewTypeYear:
        {
            return 60;
            break;
        }
        case DatePickerCollectionViewTypeHour:
        {
            return 24;
            break;
        }
        case DatePickerCollectionViewTypeMinute:
        {
            return 60;
            break;
        }
        case DatePickerCollectionViewTypeSecond:
        {
            return 60;
            break;
        }
        default:
        {
            return 0;
            break;
        }
    }
}

@end


