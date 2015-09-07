//
//  MyScrollView.m
//  My Own Scrollview
//
//  Created by asu on 2015-09-07.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "SVMyScrollView.h"

@interface SVMyScrollView()
@property (strong, nonatomic) UIPanGestureRecognizer *panning;
@property (assign, nonatomic) CGPoint panStart;
@end

@implementation SVMyScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _contentSize = CGSizeMake(0.0f, 0.0f);
        _panStart = CGPointMake(0.0f, 0.0f);
      
        _panning = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
        _panning.minimumNumberOfTouches = 1;
        [self addGestureRecognizer:_panning];
    }
    return self;
}

-(void)panDetected:(UIPanGestureRecognizer*)sender{
    CGPoint translation = [sender translationInView:self];
    CGPoint panStartPosition = [sender locationInView:self];

    NSLog(@"%d", sender.state);
    NSLog(@"FRAME x=%f, y=%f", self.frame.origin.x, self.frame.origin.y);
    NSLog(@"BOUNDS x=%f, y=%f", self.bounds.origin.x, self.bounds.origin.y);
    NSLog(@"START x=%f, y=%f", panStartPosition.x, panStartPosition.y);
    NSLog(@"DELTA x=%f, y=%f", translation.x, translation.y);

    
    if (sender.state == UIGestureRecognizerStateBegan){
        self.panStart = self.bounds.origin;
    } else if (sender.state == UIGestureRecognizerStateChanged){
		[self setBounds:CGRectMake(self.panStart.x - translation.x, self.panStart.y - translation.y,
                                   self.bounds.size.width, self.bounds.size.height)];
    }

}

-(void)addSubview:(UIView *)view{
    [super addSubview:view];

    self.contentSize = CGSizeMake(fmax(self.contentSize.width, view.bounds.size.width), fmax(self.contentSize.height, view.bounds.size.width));
    
}

@end
