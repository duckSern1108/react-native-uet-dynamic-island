//
//  DynamicIslandModuleBridge.m
//  ReactNativeDynamicIslandUet
//
//  Created by Sern Duck on 18/12/2022.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(DynamicIslandModule, NSObject)

// FoodOrder
RCT_EXTERN_METHOD(startCourseReminderActivity:(NSString *) title withMessage:(NSString *))
RCT_EXTERN_METHOD(updateCourseReminderActivity:(NSString *) message withMessage:(NSString *))
RCT_EXTERN_METHOD(endCourseReminderActivty)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
