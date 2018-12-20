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
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    DatePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    switch ((DatePickerCollectionViewType)collectionView.tag) {
        case DatePickerCollectionViewTypeMonth:
        {
            [cell setString:[months objectAtIndex:indexPath.item]];
            break;
        }
        case DatePickerCollectionViewTypeDay:
        {
            
            break;
        }
        case DatePickerCollectionViewTypeYear:
        {
            
            break;
        }
        case DatePickerCollectionViewTypeHour:
        {
            
            break;
        }
        case DatePickerCollectionViewTypeMinute:
        {
            
            break;
        }
        case DatePickerCollectionViewTypeSecond:
        {
            
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
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    switch ((DatePickerCollectionViewType)collectionView.tag) {
        case DatePickerCollectionViewTypeMonth:
        {
            return 12;
            break;
        }
        case DatePickerCollectionViewTypeDay:
        {
            NSCalendar *calendar         = [NSCalendar currentCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.year              = 2018;
            components.day               = 1;
            components.month             = (month > 31) ? 0 : month;
            components.hour              = 0;
            components.minute            = 0;
            components.second            = 0;
            NSDate *date = [calendar dateFromComponents:components];
            NSRange rangeOfDays  = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
            NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:rangeOfDays.length];
            for (NSUInteger day = 0; day < rangeOfDays.length; day++)
                [days addObject:[NSNumber numberWithUnsignedInteger:day]];
            
            return days.count;
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


