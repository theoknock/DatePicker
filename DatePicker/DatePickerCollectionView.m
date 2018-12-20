//
//  DatePickerCollectionView.m
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import "DatePickerCollectionView.h"
#import "DatePickerCollectionViewFlowLayout.h"

@implementation DatePickerCollectionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.collectionViewLayout = [[DatePickerCollectionViewFlowLayout alloc] initWithCollectionViewFrame:self.superview.frame];
}

@end
