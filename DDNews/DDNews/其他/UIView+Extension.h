//
//  UIView+Extension.h
//
//

#import <UIKit/UIKit.h>

#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height


@interface UIView (Extension)

/** UIView 的坐标X点 */
@property (nonatomic, assign) CGFloat x;
/** UIView 的坐标Y点 */
@property (nonatomic, assign) CGFloat y;

/** UIView 的中心点X值 */
@property (nonatomic, assign) CGFloat centerX;
/** UIView 的中心点Y值 */
@property (nonatomic, assign) CGFloat centerY;

/** UIView的最大X值 */
@property (assign, nonatomic) CGFloat maxX;
/** UIView的最大Y值 */
@property (assign, nonatomic) CGFloat maxY;

/** UIView 的宽度 */
@property (nonatomic, assign) CGFloat width;
/** UIView 的高度 */
@property (nonatomic, assign) CGFloat height;

/** UIView 的 size */
@property (nonatomic, assign) CGSize size;
/** UIView 的坐标 */
@property (nonatomic, assign) CGPoint origin;

/** UIView 的宽度 bounds */
@property (nonatomic, assign) CGFloat boundsWidth;

/** UIView 的高度 bounds */
@property (nonatomic, assign) CGFloat boundsHeight;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;


@end
