//
//  DatePickerCollectionViewCell.h
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>


NS_ASSUME_NONNULL_BEGIN

@interface DatePickerCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic, setter=setString:) __block NSString *string;

@end

NS_ASSUME_NONNULL_END
