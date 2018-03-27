//
//  WKWebView+ScrollViewDelegate.m
//  ShanbayNews
//
//  Created by Zheng Wu on 2018/3/26.
//  Copyright © 2018年 Shanbay.com. All rights reserved.
//

#import "WKWebView+ScrollViewDelegate.h"
#import <objc/runtime.h>

@interface wks_WeakObjectContainer : NSObject
@property (nonatomic, readonly, weak) id object;
@end

@implementation wks_WeakObjectContainer
- (instancetype)initWithObject:(id)object
{
    if (!(self = [super init]))
        return nil;
    _object = object;
    return self;
}
@end

@implementation WKWebView (ScrollViewDelegate)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method scrollViewDidScroll = class_getInstanceMethod(self, @selector(scrollViewDidScroll:));
        Method hook_scrollViewDidScroll = class_getInstanceMethod(self, @selector(hook_scrollViewDidScroll:));
        method_exchangeImplementations(scrollViewDidScroll, hook_scrollViewDidScroll);
        
        Method scrollViewDidZoom = class_getInstanceMethod(self, @selector(scrollViewDidZoom:));
        Method hook_scrollViewDidZoom = class_getInstanceMethod(self, @selector(hook_scrollViewDidZoom:));
        method_exchangeImplementations(scrollViewDidZoom, hook_scrollViewDidZoom);
        
        Method scrollViewWillBeginDragging = class_getInstanceMethod(self, @selector(scrollViewWillBeginDragging:));
        Method hook_scrollViewWillBeginDragging = class_getInstanceMethod(self, @selector(hook_scrollViewWillBeginDragging:));
        method_exchangeImplementations(scrollViewWillBeginDragging, hook_scrollViewWillBeginDragging);
        
        Method scrollViewWillEndDragging = class_getInstanceMethod(self, @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:));
        Method hook_scrollViewWillEndDragging = class_getInstanceMethod(self, @selector(hook_scrollViewWillEndDragging:withVelocity:targetContentOffset:));
        method_exchangeImplementations(scrollViewWillEndDragging, hook_scrollViewWillEndDragging);
        
        Method scrollViewDidEndDragging = class_getInstanceMethod(self, @selector(scrollViewDidEndDragging:willDecelerate:));
        Method hook_scrollViewDidEndDragging = class_getInstanceMethod(self, @selector(hook_scrollViewDidEndDragging:willDecelerate:));
        method_exchangeImplementations(scrollViewDidEndDragging, hook_scrollViewDidEndDragging);
        
        Method scrollViewWillBeginDecelerating = class_getInstanceMethod(self, @selector(scrollViewWillBeginDecelerating:));
        Method hook_scrollViewWillBeginDecelerating = class_getInstanceMethod(self, @selector(hook_scrollViewWillBeginDecelerating:));
        method_exchangeImplementations(scrollViewWillBeginDecelerating, hook_scrollViewWillBeginDecelerating);
        
        Method scrollViewDidEndDecelerating = class_getInstanceMethod(self, @selector(scrollViewDidEndDecelerating:));
        Method hook_scrollViewDidEndDecelerating = class_getInstanceMethod(self, @selector(hook_scrollViewDidEndDecelerating:));
        method_exchangeImplementations(scrollViewDidEndDecelerating, hook_scrollViewDidEndDecelerating);
        
        Method scrollViewDidEndScrollingAnimation = class_getInstanceMethod(self, @selector(scrollViewDidEndScrollingAnimation:));
        Method hook_scrollViewDidEndScrollingAnimation = class_getInstanceMethod(self, @selector(hook_scrollViewDidEndScrollingAnimation:));
        method_exchangeImplementations(scrollViewDidEndScrollingAnimation, hook_scrollViewDidEndScrollingAnimation);
        
        Method viewForZoomingInScrollView = class_getInstanceMethod(self, @selector(viewForZoomingInScrollView:));
        Method hook_viewForZoomingInScrollView = class_getInstanceMethod(self, @selector(hook_viewForZoomingInScrollView:));
        method_exchangeImplementations(viewForZoomingInScrollView, hook_viewForZoomingInScrollView);
        
        Method scrollViewWillBeginZooming = class_getInstanceMethod(self, @selector(scrollViewWillBeginZooming:withView:));
        Method hook_scrollViewWillBeginZooming = class_getInstanceMethod(self, @selector(hook_scrollViewWillBeginZooming:withView:));
        method_exchangeImplementations(scrollViewWillBeginZooming, hook_scrollViewWillBeginZooming);
        
        Method scrollViewDidEndZooming = class_getInstanceMethod(self, @selector(scrollViewDidEndZooming:withView:atScale:));
        Method hook_scrollViewDidEndZooming = class_getInstanceMethod(self, @selector(hook_scrollViewDidEndZooming:withView:atScale:));
        method_exchangeImplementations(scrollViewDidEndZooming, hook_scrollViewDidEndZooming);
        
        Method scrollViewShouldScrollToTop = class_getInstanceMethod(self, @selector(scrollViewShouldScrollToTop:));
        Method hook_scrollViewShouldScrollToTop = class_getInstanceMethod(self, @selector(hook_scrollViewShouldScrollToTop:));
        method_exchangeImplementations(scrollViewShouldScrollToTop, hook_scrollViewShouldScrollToTop);
        
        Method scrollViewDidScrollToTop = class_getInstanceMethod(self, @selector(scrollViewDidScrollToTop:));
        Method hook_scrollViewDidScrollToTop = class_getInstanceMethod(self, @selector(hook_scrollViewDidScrollToTop:));
        method_exchangeImplementations(scrollViewDidScrollToTop, hook_scrollViewDidScrollToTop);
        
        Method scrollViewDidChangeAdjustedContentInset = class_getInstanceMethod(self, @selector(scrollViewDidChangeAdjustedContentInset:));
        Method hook_scrollViewDidChangeAdjustedContentInset = class_getInstanceMethod(self, @selector(hook_scrollViewDidChangeAdjustedContentInset:));
        method_exchangeImplementations(scrollViewDidChangeAdjustedContentInset, hook_scrollViewDidChangeAdjustedContentInset);
        
    });
}

- (NSObject *)scrollViewDelegate {
    return [objc_getAssociatedObject(self, @selector(scrollViewDelegate)) object];
}

- (void)setScrollViewDelegate:(NSObject *)delegate {
    objc_setAssociatedObject(self, @selector(scrollViewDelegate), [[wks_WeakObjectContainer alloc] initWithObject:delegate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hook_scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
    [self hook_scrollViewDidScroll:scrollView];
}

- (void)hook_scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.scrollViewDelegate scrollViewDidZoom:scrollView];
    }
    [self hook_scrollViewDidZoom:scrollView];
}

- (void)hook_scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.scrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
    [self hook_scrollViewWillBeginDragging:scrollView];
}

- (void)hook_scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.scrollViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
    [self hook_scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)hook_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    [self hook_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)hook_scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.scrollViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
    [self hook_scrollViewWillBeginDecelerating:scrollView];
}

- (void)hook_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
    [self hook_scrollViewDidEndDecelerating:scrollView];
}

- (void)hook_scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.scrollViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
    [self hook_scrollViewDidEndScrollingAnimation:scrollView];
}

- (UIView *)hook_viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.scrollViewDelegate viewForZoomingInScrollView:scrollView];
    }
    return [self hook_viewForZoomingInScrollView:scrollView];
}

- (void)hook_scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.scrollViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
    [self hook_scrollViewWillBeginZooming:scrollView withView:view];
}

- (void)hook_scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.scrollViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
    [self hook_scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}

- (BOOL)hook_scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.scrollViewDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return [self hook_scrollViewShouldScrollToTop:scrollView];
}

- (void)hook_scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.scrollViewDelegate scrollViewDidScrollToTop:scrollView];
    }
    [self hook_scrollViewDidScrollToTop:scrollView];
}

- (void)hook_scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        if (@available(iOS 11.0, *)) {
            [self.scrollViewDelegate scrollViewDidChangeAdjustedContentInset:scrollView];
        } else {
            // Fallback on earlier versions
        }
    }
    [self hook_scrollViewDidChangeAdjustedContentInset:scrollView];
}

@end
