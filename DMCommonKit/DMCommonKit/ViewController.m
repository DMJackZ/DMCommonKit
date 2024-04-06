//
//  ViewController.m
//  DMCommonKit
//
//  Created by JackZ86 on 2024/4/6.
//

#import "ViewController.h"
#import "DMPageControl.h"

@interface ViewController ()

@property (nonatomic, strong) DMPageControl *mPageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat tmpWidth = [UIScreen mainScreen].bounds.size.width;
    [self.view addSubview:self.mPageControl];
    self.mPageControl.frame = CGRectMake((tmpWidth - 150) / 2.0, 200, 150, 6);
    
    self.mPageControl.currentPage = 0;
    self.mPageControl.numberOfPages = 5;
}

- (DMPageControl *)mPageControl {
    if (_mPageControl == nil) {
        _mPageControl = [[DMPageControl alloc] initWithFrame:CGRectMake(0, 0, 150, 6)];
        _mPageControl.pageWidth = 6;
        _mPageControl.currentPageWidth = 16;
        _mPageControl.pageSpace = 5;
        _mPageControl.cornerRadius = 3;
        _mPageControl.pageHeight = 6;
        _mPageControl.pageIndicatorTintColor = [UIColor purpleColor];
        _mPageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    }
    return _mPageControl;
}

@end
