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
@property SKLabelNode *labelDebug;
@property int counterUp;
@property int counterDown;
@property BOOL done;
@property int spinLevel;



@end

@implementation MyScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        _counterUp = 0;
        _counterDown = 0;
        _done= NO;
        _spinLevel = 0;
        
        _motionManager= [[CMMotionManager alloc]init];
        _motionManager.accelerometerUpdateInterval = 0.5;
        [_motionManager startAccelerometerUpdates];
        _motionManager.gyroUpdateInterval = 0.5;
        [_motionManager startGyroUpdates];
        
        
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        _myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel.text = @"Hello, World!";
        _myLabel.fontSize = 18;
        _myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame));
        
        _myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel2.text = @"counterUp:";
        _myLabel2.fontSize = 18;
        _myLabel2.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame)+60);
        
        _myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel3.text = @"counterDown:";
        _myLabel3.fontSize = 18;
        _myLabel3.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame)+30);
   
        _labelDebug = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _labelDebug.text = @"in if: 0:";
        _labelDebug.fontSize = 18;
        _labelDebug.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMaxY(self.frame)-30);
        
        [self addChild:_myLabel];
        [self addChild:_myLabel2];
        [self addChild:_myLabel3];
        [self addChild:_labelDebug];
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
    
    
    if (_motionManager.gyroData.rotationRate.x > 1) {
        _counterUp ++;
         _labelDebug.text = @"in if: 1:";
        
    
    }
    
    if (_motionManager.gyroData.rotationRate.x < 1  && _counterUp > 1 ) {
        _counterDown ++;
         _labelDebug.text = @"in if: 2:";
        _spinLevel = 1;
        
    }
    
    if (_motionManager.gyroData.rotationRate.x > 1  && _spinLevel == 1 ) {
        _counterUp  ++;
         _labelDebug.text = @"in if: 3:";
    }
    
    if (_motionManager.gyroData.rotationRate.x > 1  && _spinLevel == 1  ) {
        _counterDown  ++;
         _labelDebug.text = @"in if: 4:";
        
        _done = YES;
        _spinLevel= 0;
        [_myLabel2 setText:@"Done!"];
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
    
    if (!_done) {
    [_myLabel2 setText:[NSString stringWithFormat:@"counterUp: %i",_counterUp]];
    [_myLabel3 setText:[NSString stringWithFormat:@"counterDown: %i",_counterDown]];
    }
    
    /* Called before each frame is rendered */
}

-(void) dealloc{
    [_motionManager stopAccelerometerUpdates];
    _motionManager = nil;
    
}

@end
