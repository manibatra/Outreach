//
//  RateView.h
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//


#import <UIKit/UIKit.h>

@class RateView;


@protocol RateViewDelegate

-(void) rateView:(RateView*)rateView ratingDidChange:(float)rating;

@end

@interface RateView : UIView

@property(strong, nonatomic) UIImage *notSelectedImage;
@property(strong, nonatomic) UIImage *halfSelectedImage;
@property(strong, nonatomic) UIImage *fullSelectedImage;
@property(assign, nonatomic) float rating;
@property(assign) BOOL editable;
@property(strong) NSMutableArray *imageViews;
@property(assign, nonatomic) int maxRating;
@property(assign) int midMargin;
@property(assign) int leftMargin;
@property(assign) CGSize minImageSize;
@property(assign) id<RateViewDelegate> delegate;

@end