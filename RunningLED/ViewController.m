//
//  ViewController.m
//  RunningLED
//
//  Created by student on 11/3/15.
//  Copyright © 2015 Techmaster. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) CGFloat margin;
@property (assign, nonatomic) CGFloat space;
@property (assign, nonatomic) CGFloat ballDiameter;
@property (assign, nonatomic) int maxBallPerRow;
@property (assign, nonatomic) int numberOfBall;
@property (assign, nonatomic) float lastOnLED;
@property (assign, nonatomic) int currentRow;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.margin = 40.0;
    self.ballDiameter = 24;
    self.currentRow = 1;
    self.maxBallPerRow = 9;
    self.numberOfBall = 9;
    self.lastOnLED = -1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED) userInfo:nil repeats:true];
    //[self placeGreyBallAtX:100 andY:100 withTag:1];
    [self checkSizeOfApp];
    [self numberOfBallvsSpace];
    [self drawRowOfBalls:self.numberOfBall];
    
}

-(void) placeGreyBallAtX: (CGFloat) x
                    andY: (CGFloat) y
                 withTag: (int)tag

{
    UIImageView* ball = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Soccer.png"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    NSLog(@"w=%3.0f, h=%3.0f", ball.bounds.size.width, ball.bounds.size.height);
}
- (CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) n {
    return (self.view.bounds.size.width - 2*self.margin)/(n-1);
}
- (void) numberOfBallvsSpace {
    bool stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown: n];
        if (space < self.ballDiameter) {
            stop = true;
        } else {
            NSLog(@"Number of ball %d, space between ball center %3.0f", n, space);
        }
        
        n++;
    }
}

- (void) drawRowOfBalls: (int) numberBalls {
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:self.maxBallPerRow];
    for (int i = 0; i< numberBalls; i++) {
        [self placeGreyBallAtX:self.margin + (i % self.maxBallPerRow) * space
                          andY: 140 + 50 * (self.currentRow - 1)
                       withTag:i+100];
        if (i+1 == self.currentRow * self.maxBallPerRow) {
            self.currentRow++;
        }
    }
    
}

- (void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %3.0f, height = %3.0f", size.width, size.height);
}

- (void) runningLED {
    if (self.lastOnLED != -1) {
        [self turnOFFLed:self.lastOnLED];
    }
    if (self.lastOnLED != self.numberOfBall -1) {
        self.lastOnLED++;
    } else {
        self.lastOnLED = 0;
    }
    [self turnONLed:self.lastOnLED];
}

- (void) turnONLed: (int) index {
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"Soccer"];
    }
    
}

- (void) turnOFFLed: (int) index {
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"Baseball"];
    }
}

@end
