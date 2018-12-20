//
//  DatePickerCollectionViewCell.m
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import "DatePickerCollectionViewCell.h"

@implementation DatePickerCollectionViewCell

@synthesize string = _string;

- (void)prepareForReuse
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.contentView.layer.sublayers = nil;
    });
}

- (NSString *)string
{
    return _string;
}

- (void)setString:(NSString *)string
{
    self->_string = string;
    
    CATextLayer *textLayer = [CATextLayer layer];
    NSMutableParagraphStyle *rightAlignedParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    rightAlignedParagraphStyle.alignment                = NSTextAlignmentLeft;
    NSDictionary *rightAlignedTextAttributes            = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                                            NSFontAttributeName:[UIFont systemFontOfSize:16.0],
                                                            NSParagraphStyleAttributeName:rightAlignedParagraphStyle};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string
                                                                           attributes:rightAlignedTextAttributes];
    dispatch_async(dispatch_get_main_queue(), ^{
        __block CGFloat textLayerFrameY = CGRectGetMinY(self.contentView.bounds);
        [textLayer setOpaque:FALSE];
        [textLayer setAlignmentMode:kCAAlignmentLeft];
        textLayer.string = attributedString;
        
        CGSize textLayerframeSize = [self suggestFrameSizeWithConstraints:self.contentView.bounds.size forAttributedString:attributedString];
        CGRect frame = CGRectMake(CGRectGetMinX(self.contentView.bounds), (CGRectGetMinY(self.contentView.bounds) + textLayerFrameY), textLayerframeSize.width, textLayerframeSize.height);
        textLayer.frame = frame;
        textLayerFrameY += textLayerframeSize.height;
        
        [self.contentView.layer addSublayer:textLayer];
    });
    
}

- (CGSize)suggestFrameSizeWithConstraints:(CGSize)size forAttributedString:(NSAttributedString *)attributedString
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    CFRange attributedStringRange = CFRangeMake(0, attributedString.length);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, attributedStringRange, NULL, size, NULL);
    CFRelease(framesetter);
    
    return suggestedSize;
}

@end

