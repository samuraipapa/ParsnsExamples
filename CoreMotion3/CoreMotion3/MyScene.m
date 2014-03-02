//
//  MyScene.m
//  CoreMotion3
//
//  Created by YG on 3/2/14.
//  Copyright (c) 2014 YuryGitman. All rights reserved.
//

#import "MyScene.h"

@interface MyScene()

@property SKLabelNode *myLabel;
@property SKLabelNode *myLabel2;
@property SKLabelNode *myLabel3;
@property int counterUp;
@property int counterDown;



@end

@implementation MyScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        _counterUp = 0;
        _counterDown = 0;
        
        
        _motionManager= [[CMMotionManager alloc]init];
        _motionManager.accelerometerUpdateInterval = 0.05;
        [_motionManager startAccelerometerUpdates];
        _motionManager.gyroUpdateInterval = 0.05;
        [_motionManager startGyroUpdates];
        
        
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        _myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel.text = @"Hello, World!";
        _myLabel.fontSize = 18;
        _myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame));
        
        _myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel2.text = @"Hello, World!";
        _myLabel2.fontSize = 18;
        _myLabel2.position = CGPointMake(CGRectGetMidX(self.frame)-20,
                                         CGRectGetMidY(self.frame)+30);
        
        _myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel3.text = @"Hello, World!";
        _myLabel3.fontSize = 18;
        _myLabel3.position = CGPointMake(CGRectGetMidX(self.frame)+20,
                                         CGRectGetMidY(self.frame)+30);
        
        
        [self addChild:_myLabel];
        [self addChild:_myLabel2];
        [self addChild:_myLabel3];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
    }
}

-(void) checkGesture
{
    
    
    if (_motionManager.gyroData.rotationRate.y > 1) {
        _counterUp ++;
    }
    
    if (_motionManager.gyroData.rotationRate.y < 1  && _counterUp == 1 ) {
        _counterDown ++;
    }
    
    if (_motionManager.gyroData.rotationRate.y > 1  && _counterUp == 1  && _counterDown == 1 ) {
        _counterUp  ++;
    }
    
    if (_motionManager.gyroData.rotationRate.y > 1  && _counterUp == 2  && _counterDown == 1 ) {
        _counterDown  ++;
    }
    
    
    
    
    
    
    
}



-(void)update:(CFTimeInterval)currentTime {
    //     NSLog(@"accelerometer x: %.1f,  y: %.1f, z: %.1f",
    //           _motionManager.accelerometerData.acceleration.x,
    //           _motionManager.accelerometerData.acceleration.y,
    //           _motionManager.accelerometerData.acceleration.z);
    
    //    [_myLabel setText:[NSString stringWithFormat:@"x: %.2f,  y: %.2f, z: %.2f",
    //                       _motionManager.accelerometerData.acceleration.x,
    //                       _motionManager.accelerometerData.acceleration.y,
    //                       _motionManager.accelerometerData.acceleration.z]];
    
    [self checkGesture];
    
    
    NSLog(@"rotationRate x: %.1f,  y: %.1f, z: %.1f",
          _motionManager.gyroData.rotationRate.x,
          _motionManager.gyroData.rotationRate.y,
          _motionManager.gyroData.rotationRate.z);
    
    [_myLabel setText:[NSString stringWithFormat:@"x: %.2f,  y: %.2f, z: %.2f",
                       _motionManager.gyroData.rotationRate.x,
                       _motionManager.gyroData.rotationRate.y,
                       _motionManager.gyroData.rotationRate.z]];
    
    [_myLabel2 setText:[NSString stringWithFormat:@"counter: %i",_counterUp]];
    
    
    /* Called before each frame is rendered */
}

-(void) dealloc{
    [_motionManager stopAccelerometerUpdates];
    _motionManager = nil;
    
}

@end
