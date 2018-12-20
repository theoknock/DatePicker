//
//  DatePickerCollectionViewFlowLayout.m
//  DatePicker
//
//  Created by Xcode Developer on 12/19/18.
//  Copyright © 2018 The Life of a Demoniac. All rights reserved.
//

#import "DatePickerCollectionViewFlowLayout.h"

#define ACTIVE_DISTANCE         10
#define TRANSLATE_DISTANCE      10
#define ZOOM_FACTOR             0.2f
#define FLOW_OFFSET             40
#define INACTIVE_GREY_VALUE     0.6f

@implementation DatePickerCollectionViewFlowLayout

- (instancetype)initWithCollectionViewFrame:(CGRect)frame
{
    if (self == [super init])
    {
        self.scrollDirection         = UICollectionViewScrollDirectionVertical;
        self.itemSize                = CGSizeMake(50.0, 50.0);
        CGFloat topInset             = CGRectGetMidY(frame);
        CGFloat bottomInset          = CGRectGetMidY(frame);
        self.sectionInset            = UIEdgeInsetsMake(topInset, 0.0, bottomInset, 0.0);
        self.minimumLineSpacing      = 10.0;
        self.minimumInteritemSpacing = 10.0;
    }
    
    return [self init];
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attributes = (UICollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
//
//    // We're going to calculate the rect of the collection view visible to the user.
//    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
//
//    [self applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:visibleRect];
//
//    return attributes;
//}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // Returns a point where we want the collection view to stop scrolling at.
    
    // First, calculate the proposed center of the collection view once the collection view has stopped
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat verticalCenter = proposedContentOffset.y + (CGRectGetHeight(self.collectionView.bounds) / 2.0);
    // Use the center to find the proposed visible rect.
    CGRect proposedRect = CGRectMake(0.0, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    // Get the attributes for the cells in that rect.
    NSArray<UICollectionViewLayoutAttributes *> *array = (NSArray<UICollectionViewLayoutAttributes *> *)[super layoutAttributesForElementsInRect:proposedRect];
    
    // This loop will find the closest cell to proposed center of the collection view
    for (UICollectionViewLayoutAttributes *layoutAttributes in array)
    {
        // We want to skip supplementary views
        if (layoutAttributes.representedElementCategory != UICollectionElementCategoryCell)
            continue;
        
        // Determine if this layout attribute's cell is closer than the closest we have so far
        CGFloat itemVerticalCenter = layoutAttributes.center.y;
        if (fabs(itemVerticalCenter - verticalCenter) < fabs(offsetAdjustment))
        {
            offsetAdjustment = itemVerticalCenter - verticalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x, proposedContentOffset.y + offsetAdjustment);
}

+ (Class)layoutAttributesClass
{
    return [UICollectionViewLayoutAttributes class];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray<UICollectionViewLayoutAttributes *> *layoutAttributesArray = (NSArray<UICollectionViewLayoutAttributes *> *)[super layoutAttributesForElementsInRect:rect];
//
//    // We're going to calculate the rect of the collection view visible to the user.
//    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
//
//    for (UICollectionViewLayoutAttributes *attributes in layoutAttributesArray)
//    {
//        // We're going to calculate the rect of the collection view visible to the user.
//        // That way, we can avoid laying out cells that are not visible.
//        if (CGRectIntersectsRect(attributes.frame, rect))
//        {
//            [self applyLayoutAttributes:attributes forVisibleRect:visibleRect];
//        }
//    }
//
//    return layoutAttributesArray;
//}
//
//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect
//{
//    // Applies the cover flow effect to the given layout attributes.
//
//    // We want to skip supplementary views.
//    if (attributes.representedElementKind) return;
//
//    // Calculate the distance from the center of the visible rect to the center of the attributes.
//    // Then normalize it so we can compare them all. This way, all items further away than the
//    // active get the same transform.
//    CGFloat distanceFromVisibleRectToItem = CGRectGetMidY(visibleRect) - attributes.center.y;
//    CGFloat normalizedDistance = distanceFromVisibleRectToItem / ACTIVE_DISTANCE;
//    BOOL isLeft = distanceFromVisibleRectToItem > 0;
//    CATransform3D transform = CATransform3DIdentity;
//
//    CGFloat maskAlpha = 0.0f;
//
//    if (fabs(distanceFromVisibleRectToItem) < ACTIVE_DISTANCE)
//    {
//        // We're close enough to apply the transform in relation to
//        // how far away from the center we are.
//
//        transform = CATransform3DTranslate(CATransform3DIdentity, (isLeft? - FLOW_OFFSET : FLOW_OFFSET)*ABS(distanceFromVisibleRectToItem/TRANSLATE_DISTANCE), 0, (1 - fabs(normalizedDistance)) * 40000 + (isLeft? 200 : 0));
//
//        // Set the perspective of the transform.
//        transform.m34 = -1/(4.6777 * self.itemSize.width);
//
//        // Set the zoom factor.
//        CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
//        transform = CATransform3DRotate(transform, (isLeft? 1 : -1) * fabs(normalizedDistance) * 45 * M_PI / 180, 0, 1, 0);
//        transform = CATransform3DScale(transform, zoom, zoom, 1);
//        attributes.zIndex = 1;
//
//        CGFloat ratioToCenter = (ACTIVE_DISTANCE - fabs(distanceFromVisibleRectToItem)) / ACTIVE_DISTANCE;
//        // Interpolate between 0.0f and INACTIVE_GREY_VALUE
//        maskAlpha = INACTIVE_GREY_VALUE + ratioToCenter * (-INACTIVE_GREY_VALUE);
//    }
//    else
//    {
//        // We're too far away - just apply a standard perspective transform.
//        transform.m34 = -1/(4.6777 * self.itemSize.height);
//        transform = CATransform3DTranslate(transform, isLeft? -FLOW_OFFSET : FLOW_OFFSET, 0, 0);
//        transform = CATransform3DRotate(transform, (isLeft? 1 : -1) * 45 * M_PI / 180, 0, 1, 0);
//        attributes.zIndex = 0;
//
//        maskAlpha = INACTIVE_GREY_VALUE;
//    }
//
//    attributes.transform3D = transform;
//}
//
//-(BOOL)indexPathIsCentered:(NSIndexPath *)indexPath
//{
//    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
//
//    UICollectionViewLayoutAttributes *attributes = (UICollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
//
//    CGFloat distanceFromVisibleRectToItem = CGRectGetMidY(visibleRect) - attributes.center.y;
//
//    return fabs(distanceFromVisibleRectToItem) < 1;
//}
//

@end
