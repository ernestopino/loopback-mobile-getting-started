//
//  AppDelegate.h
//  loopback-ios-multi-model
//
//  Created by Matt Schmulen on 7/24/13.
//  Copyright (c) 2013 Matt Schmulen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LoopBack/LoopBack.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+(void)showGuideMessage : ( NSString *) message;
+ (LBRESTAdapter *) adapter;

+ (void) initializeServerWithData;
+ (void) initializeStoresData;

@end

