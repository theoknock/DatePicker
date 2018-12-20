//
//  DatePickerCollectionViewData.h
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DatePickerCollectionViewType) {
    DatePickerCollectionViewTypeMonth,
    DatePickerCollectionViewTypeDay,
    DatePickerCollectionViewTypeYear,
    DatePickerCollectionViewTypeHour,
    DatePickerCollectionViewTypeMinute,
    DatePickerCollectionViewTypeSecond
};

@interface DatePickerCollectionViewData : NSObject <UICollectionViewDataSource>

@property(nonatomic, readonly, copy) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
