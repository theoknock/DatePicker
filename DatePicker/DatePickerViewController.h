//
//  DatePickerViewController.h
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerCollectionViewData.h"

NS_ASSUME_NONNULL_BEGIN

@class DatePickerCollectionView, DatePickerCollectionViewData;

@interface DatePickerViewController : UIViewController <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet DatePickerCollectionView *monthCollectionView;
@property (weak, nonatomic) IBOutlet DatePickerCollectionView *dayCollectionView;
@property (weak, nonatomic) IBOutlet DatePickerCollectionView *yearCollectionView;
@property (weak, nonatomic) IBOutlet DatePickerCollectionView *hourCollectionView;
@property (weak, nonatomic) IBOutlet DatePickerCollectionView *minuteCollectionView;
@property (weak, nonatomic) IBOutlet DatePickerCollectionView *secondCollectionView;
@property (strong, nonatomic) IBOutletCollection(DatePickerCollectionView) NSArray *datePickerCollectionViews;
@property (strong, nonatomic) IBOutlet DatePickerCollectionViewData *datePickerCollectionViewDataSource;

@end

NS_ASSUME_NONNULL_END
