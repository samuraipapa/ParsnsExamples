//
//  MyScene.m
//  VoiceSynAndContactDetection
//
//  Created by YG on 3/4/14.
//  Copyright (c) 2014 YuryGitman. All rights reserved.
//

#import "MyScene.h"
@import AVFoundation;

//  Category BitMasks
static const uint32_t REDCATEGORY = 0x1 << 0;
static const uint32_t BLUECATEGORY = 0x1 << 1;
static const uint32_t GREENCATEGORY = 0x1 << 2;
static const uint32_t SCREENEDGECATEGORY = 0x1 << 3;


@interface MyScene()<SKPhysicsContactDelegate>
@property    SKSpriteNode* redSquare;
@property   SKSpriteNode* blueSquare;
@property   SKSpriteNode* greenSquare;

@end

@implementation MyScene

-(void) didBeginContact:(SKPhysicsContact *)contact{
   // NSLog(@"Entered didBeginContact");
    
    if ((contact.bodyA.categoryBitMask == REDCATEGORY) ||
        (contact.bodyB.categoryBitMask == REDCATEGORY) ) {
        NSLog(@"red hit something");
    }
    
    if ((contact.bodyA.categoryBitMask == GREENCATEGORY) &&
        (contact.bodyB.categoryBitMask == REDCATEGORY) ) {
        NSLog(@"Green Touched Red");
        [contact.bodyA.node.physicsBody applyImpulse:CGVectorMake(-1, 20)];
    }
 
    if ((contact.bodyA.categoryBitMask == REDCATEGORY) &&
        (contact.bodyB.categoryBitMask == GREENCATEGORY) ) {
        NSLog(@"RED Touched GREEN");
        [contact.bodyB.node.physicsBody applyImpulse:CGVectorMake(-1, 20)];
    }
    
    if ((contact.bodyA.categoryBitMask == GREENCATEGORY) &&
        (contact.bodyB.categoryBitMask == BLUECATEGORY) ) {
        NSLog(@"Green Touched BLUE");
        [contact.bodyA.node removeFromParent];
    }
    
    if ((contact.bodyA.categoryBitMask == BLUECATEGORY) &&
        (contact.bodyB.categoryBitMask == GREENCATEGORY) ) {
        NSLog(@"RED Touched BLUE");
        [contact.bodyB.node removeFromParent];
        
    }

    
 }
-(void) speakThisString: (NSString*) myLocalString {
    AVSpeechSynthesizer*  mySyn = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance* myUtterance = [[AVSpeechUtterance alloc] initWithString:myLocalString];
    [mySyn speakUtterance:myUtterance];
}

-(void) screenSettings{
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
  //  [self.physicsBody setRestitution:1.2];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
    //    [self speakThisString:@"I just started up!"];
        self.physicsWorld.contactDelegate = self;

        [self screenSettings];
        [self spawnRedSquare];
        [self spawnBlueSquare];
        [self spawnGreenSquare];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    [_redSquare setPosition:touchLocation];

}




-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void) spawnGreenSquare{
   
    for (int i = 0; i < 60; i++) {
    _greenSquare = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(18, 18)];
    _greenSquare.position = CGPointMake(100, 400);
    _greenSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_greenSquare.size];
       
        _greenSquare.physicsBody.categoryBitMask = GREENCATEGORY;
        _greenSquare.physicsBody.contactTestBitMask = REDCATEGORY | BLUECATEGORY;
       // _greenSquare.physicsBody.collisionBitMask = REDCATEGORY | BLUECATEGORY;

    [self addChild:_greenSquare];
    }
 [self speakThisString:@"green"];
}

-(void) spawnRedSquare{
    [self speakThisString:@"red"];
    _redSquare = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
    _redSquare.position = CGPointMake(100, 100);
    _redSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_redSquare.size];
 
    // contact bitMasks
    _redSquare.physicsBody.categoryBitMask = REDCATEGORY;
    [_redSquare.physicsBody setContactTestBitMask:GREENCATEGORY | BLUECATEGORY];
   // _redSquare.physicsBody.collisionBitMask = GREENCATEGORY | BLUECATEGORY;

    
    [self addChild:_redSquare];
}

-(void) spawnBlueSquare{
    [self speakThisString:@"blue"];
    _blueSquare = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(50, 50)];
    _blueSquare.position = CGPointMake(100, 100);
    _blueSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_blueSquare.size];
    //
    _blueSquare.physicsBody.categoryBitMask = BLUECATEGORY;
    _blueSquare.physicsBody.contactTestBitMask = REDCATEGORY | GREENCATEGORY;
    [self addChild:_blueSquare];

}








@end
