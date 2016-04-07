//
//  UIView+Extension.h
//
//

#import <UIKit/UIKit.h>

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

@end
