//
//  DynamicIslandModule.swift
//  ReactNativeDynamicIslandUet
//
//  Created by Sern Duck on 18/12/2022.
//

import Foundation
import UIKit
import AVFoundation
import ActivityKit

@objc(DynamicIslandModule)
class DynamicIslandModule: NSObject {
  var currentCourseReminderState: CourseReminderAttributes.ContentState?
  
  func areActivitiesEnabled() -> Bool {
    if #available(iOS 16.1, *) {
      return ActivityAuthorizationInfo.init().areActivitiesEnabled
    } else {
      return false
    }
  }
  
  // WIDGET Course Reminder
  @objc(startCourseReminderActivity:withMessage:)
  public func startCourseReminderActivity(notiText: String, notiTime: String) -> Void {
    if #available(iOS 16.1, *) {
      let initialContentState = CourseReminderAttributes.ContentState(notiText: notiText, notiTime: notiTime)
      let activityAttributes = CourseReminderAttributes(name: notiText)
      self.currentCourseReminderState = initialContentState
      
      do {
        _ = try Activity.request(attributes: activityAttributes, contentState: initialContentState)
        print("Requested a motification Live Activity.")
      } catch (let error) {
        print("Error requesting motification delivery Live Activity \(error.localizedDescription).")
      }
    }
  }
  
  @objc(updateCourseReminderActivity:withMessage:)
  public func updateCourseReminderActivity(notiText: String, notiTime: String) -> Void {
    if #available(iOS 16.1, *) {
      
      let notificationStatus = CourseReminderAttributes.ContentState(notiText: notiText, notiTime: notiTime)
      self.currentCourseReminderState = notificationStatus
      let alertConfiguration = AlertConfiguration(title: "Notification Update", body: "Notification update.", sound: .default)
      
      Task {
        for activity in Activity<CourseReminderAttributes>.activities {
          await activity.update(using: notificationStatus, alertConfiguration: alertConfiguration)
        }
      }
    }
  }
  
  @objc
  public func endCourseReminderActivty() -> Void {
    if #available(iOS 16.1, *) {
      guard let currentCourseReminderState = currentCourseReminderState else { return }
      let notificationStatus = CourseReminderAttributes.ContentState(notiText: currentCourseReminderState.notiText, notiTime: currentCourseReminderState.notiTime)
      
      
      Task {
        for activity in Activity<CourseReminderAttributes>.activities {
          await activity.end(using:notificationStatus, dismissalPolicy: .default)
        }
      }
    }
  }
  
}

