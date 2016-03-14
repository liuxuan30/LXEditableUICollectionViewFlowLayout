//The MIT License (MIT)
//
//Copyright (c) 2015 Xuan
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

#import "UICollectionViewDemoCell.h"

@implementation UICollectionViewDemoCell

-(void)awakeFromNib {
    if (self) {
        _deleteButton = [self buildDeleteButton];
        _deleteButton.hidden = YES;
        [self.contentView addSubview:self.deleteButton];
    }
}

-(void)deleteCellHandler:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userWantsDeleteCell:)]) {
        [self.delegate userWantsDeleteCell:self];
    }
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[LXEditableFlowLayoutAttributes class]]) {
        CGFloat x = CGRectGetWidth(self.bounds) - BADGE_SIZE/2;
        CGFloat y = BADGE_SIZE/2;
        self.deleteButton.center = CGPointMake(x - BUTTON_MARGIN, y + BUTTON_MARGIN);
        [self.deleteButton setHidden:((LXEditableFlowLayoutAttributes *) layoutAttributes).setDeleteButtonHidden];
        
        // Due to Apple's patent, we cannot shake in public app, just a demo
        ((LXEditableFlowLayoutAttributes *) layoutAttributes).setDeleteButtonHidden ? [self stopShaking] : [self startShaking];
    }
}

#pragma mark - shaking animations
-(void)startShaking {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    float startAngle = (-2) * M_PI/180.0;
    float stopAngle = -startAngle;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:startAngle];
    shakeAnimation.toValue = [NSNumber numberWithFloat:stopAngle];
    shakeAnimation.autoreverses = YES;
    shakeAnimation.duration = 0.2;
    shakeAnimation.repeatCount = HUGE_VALF;
    shakeAnimation.timeOffset = (float)(arc4random() % 100) / 100 - 0.5;
    [self.layer addAnimation:shakeAnimation forKey:@"shaking"];
}

-(void)stopShaking {
    [self.layer removeAnimationForKey:@"shaking"];
}

@end