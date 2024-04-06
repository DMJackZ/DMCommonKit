//
//  DMPageControl.m
//  DMCommonKit
//
//  Created by JackZ86 on 2024/4/6.
//

#import "DMPageControl.h"

@interface DMPageControl ()

@property (nonatomic, strong) NSMutableArray *mPageArray;

@property (nonatomic, assign) BOOL isInitializing;

@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation DMPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUI];
}

- (void)updateUI {
    if (self.numberOfPages == 0) {
        return;
    }
    if (self.isInitializing == YES) {
        self.isInitializing = NO;
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        CGFloat totalPageWidth = 0.0;
        CGFloat originX = 0.0;
        CGFloat originY = (height - self.pageHeight) / 2.0;
        
        if (self.numberOfPages == 1) {
            totalPageWidth = self.currentPageWidth;
            originX = (width - totalPageWidth) / 2.0;
        } else {
            totalPageWidth = self.currentPageWidth + (self.numberOfPages - 1) * self.pageWidth + (self.numberOfPages - 2) * self.pageSpace;
            originX = (width - totalPageWidth) / 2.0;
        }
        
        // 更新page 位置
        for (NSInteger i = 0; i < self.numberOfPages; i++) {
            UIView *page = [self.mPageArray objectAtIndex:i];
            CGFloat curWidth = self.pageWidth;
            if (i == self.currentPage) {
                curWidth = self.currentPageWidth;
                page.backgroundColor = self.currentPageIndicatorTintColor;
            } else {
                page.backgroundColor = self.pageIndicatorTintColor;
            }
            page.frame = CGRectMake(originX, originY, curWidth, self.pageHeight);
            originX = originX + curWidth + self.pageSpace;
        }
        
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    self.isInitializing = NO;
    for (UIView *page in self.mPageArray) {
        [page removeFromSuperview];
    }
    [self.mPageArray removeAllObjects];
    for (NSInteger i = 0; i < numberOfPages; i++) {
        UIView *page = [[UIView alloc] initWithFrame:CGRectZero];
        page.clipsToBounds = YES;
        page.layer.cornerRadius = self.cornerRadius;
        [self.mPageArray addObject:page];
        [self addSubview:page];
    }
    self.isInitializing = YES;
    [self setNeedsLayout];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (self.currentPage == currentPage || self.isAnimating == YES || self.numberOfPages == 0) {
        return;
    }
    self.isAnimating = YES;
    NSInteger oldPageIndex = self.currentPage;
    _currentPage = currentPage;
    UIView *oldPageView = [self.mPageArray objectAtIndex:oldPageIndex];
    [self bringSubviewToFront:oldPageView];
    
    //  动画结束时,需要移动page的起始oringX、需要移动page的起始下标index、需要移动page的结束下标index
    CGFloat pageOriginX = 0.0;
    NSInteger movePageStartIndex = 0;
    NSInteger movePageEndIndex = 0;
    CGFloat tmpWidth = self.currentPageWidth;
    CGFloat tmpHeight = oldPageView.bounds.size.height;
    CGFloat originX = oldPageView.frame.origin.x;
    CGFloat originY = oldPageView.frame.origin.y;
    //  // 动画结束时,currentPage的起始oringX
    CGFloat finalCurrentPageOriginX = 0.0f;
    if (self.currentPage > oldPageIndex) {
        // 向右滑动
        movePageStartIndex = oldPageIndex;
        movePageEndIndex = self.currentPage - 1;
        pageOriginX = originX;
        tmpWidth = tmpWidth + (self.currentPage - oldPageIndex) * (self.pageWidth + self.pageSpace);
        finalCurrentPageOriginX = originX + (self.currentPage - oldPageIndex) * (self.pageWidth + self.pageSpace);
    } else if (self.currentPage < oldPageIndex) {
        // 向左滑动
        movePageStartIndex = self.currentPage + 1;
        movePageEndIndex = oldPageIndex;
        tmpWidth = tmpWidth + (oldPageIndex - self.currentPage) * (self.pageWidth + self.pageSpace);
        originX = originX - (oldPageIndex - self.currentPage) * (self.pageWidth + self.pageSpace);
        pageOriginX = originX + self.pageSpace + self.currentPageWidth;
        finalCurrentPageOriginX = originX;
    }
    
    [UIView animateWithDuration:0.01 animations:^{
        oldPageView.frame = CGRectMake(originX, originY, tmpWidth, tmpHeight);
    } completion:^(BOOL finished) {
        // 移动page
        CGFloat tmpPageOriginX = pageOriginX;
        for (NSInteger i = movePageStartIndex; i <= movePageEndIndex; i++) {
            UIView *oldPageView = [self.mPageArray objectAtIndex:i];
            oldPageView.frame = CGRectMake(tmpPageOriginX, oldPageView.frame.origin.y, self.pageWidth, self.pageHeight);
            tmpPageOriginX = tmpPageOriginX + self.pageWidth + self.pageSpace;
            oldPageView.backgroundColor = self.pageIndicatorTintColor;
        }

        // 移动currentPage
        UIView *pageView = [self.mPageArray objectAtIndex:self.currentPage];
        pageView.backgroundColor = self.currentPageIndicatorTintColor;
        [UIView animateWithDuration:0.01 animations:^{
            pageView.frame = CGRectMake(finalCurrentPageOriginX, pageView.frame.origin.y, self.currentPageWidth, self.pageHeight);
        } completion:^(BOOL finished) {
            self.isAnimating = NO;
        }];
    }];
}

#pragma mark - getter and setter
- (NSMutableArray *)mPageArray {
    if (_mPageArray == nil) {
        _mPageArray = [[NSMutableArray alloc] init];
    }
    return _mPageArray;
}


@end
