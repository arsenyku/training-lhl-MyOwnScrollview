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
@property (assign, nonatomic) CGRect contentBounds;
@property (assign, nonatomic) CGPoint panStart;
@end

@implementation SVMyScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _contentBounds = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
        _panStart = CGPointMake(0.0f, 0.0f);
      
        _panning = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
        _panning.minimumNumberOfTouches = 1;
        [self addGestureRecognizer:_panning];

        for (UIView* view in self.subviews) {
            [self calculateContentBoundsWithView:view];
        }
    }
    
    return self;
}



-(void)panDetected:(UIPanGestureRecognizer*)sender{
    CGPoint translation = [sender translationInView:self];
    
    if (sender.state == UIGestureRecognizerStateBegan){
        self.panStart = self.bounds.origin;
    } else if (sender.state == UIGestureRecognizerStateChanged){
        CGRect newBounds = CGRectMake(self.panStart.x - translation.x, self.panStart.y - translation.y,
                                      self.bounds.size.width, self.bounds.size.height);
        
        float panRight = newBounds.origin.x + newBounds.size.width;
        float panBottom = newBounds.origin.y + newBounds.size.height;
        float panTop = newBounds.origin.y;
        float panLeft = newBounds.origin.x;
        
        float contentRight = self.contentBounds.origin.x + self.contentBounds.size.width;
        float contentBottom = self.contentBounds.origin.y + self.contentBounds.size.height;
        float contentTop = self.contentBounds.origin.y;
        float contentLeft = self.contentBounds.origin.x;
        
        BOOL allowPan = YES;
        // The offsets below ensure that at least a small sliver of the
        // contents always shows on screen.
		if (panLeft > contentRight - 10 ||       // too far right
            panRight < contentLeft + 30 ||       // too far left
            panBottom < contentTop + 30 ||       // too far up
            panTop > contentBottom - 10 ){       // too far down
            
            allowPan = NO;
            
        }

        if (allowPan)
	        [self setBounds:newBounds];
    }

}

-(void)calculateContentBoundsWithView:(UIView*)view{
    float left = fmin(view.frame.origin.x, self.contentBounds.origin.x);
    float top = fmin(view.frame.origin.y, self.contentBounds.origin.y);
    float right = fmax(view.frame.origin.x + view.bounds.size.width, self.contentBounds.origin.x + self.contentBounds.size.width);
    float bottom = fmax(view.frame.origin.y + view.bounds.size.height, self.contentBounds.origin.y + self.contentBounds.size.height);
    
    self.contentBounds = CGRectMake(left, top, right-left, bottom-top);
}

-(void)addSubview:(UIView *)view{
    [super addSubview:view];
    [self calculateContentBoundsWithView:view];
}

@end
