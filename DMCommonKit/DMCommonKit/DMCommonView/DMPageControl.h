//
//  DMPageControl.h
//  DMCommonKit
//
//  Created by JackZ86 on 2024/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMPageControl : UIView

//  总数 默认为0
@property (nonatomic, assign) NSInteger numberOfPages;

//  当前页 默认为0
@property (nonatomic, assign) NSInteger currentPage;

//  未选中颜色
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

//  选中颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

//  未选中宽度
@property (nonatomic, assign) CGFloat pageWidth;

//  选中宽度
@property (nonatomic, assign) CGFloat currentPageWidth;

//  圆角半径
@property (nonatomic, assign) CGFloat cornerRadius;

//  高度
@property (nonatomic, assign) CGFloat pageHeight;

//  间隙
@property (nonatomic, assign) CGFloat pageSpace;

@end

NS_ASSUME_NONNULL_END
