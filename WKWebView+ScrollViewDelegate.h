//
//  WKWebView+ScrollViewDelegate.h
//  ShanbayNews
//
//  Created by Zheng Wu on 2018/3/26.
//  Copyright © 2018年 Shanbay.com. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (ScrollViewDelegate)

@property (nonatomic, weak) id<UIScrollViewDelegate> scrollViewDelegate;

@end
