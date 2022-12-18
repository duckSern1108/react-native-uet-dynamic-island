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
  
  func areActivitiesEnabled() -> Bool {
    if #available(iOS 16.1, *) {
      return ActivityAuthorizationInfo.init().areActivitiesEnabled
    } else {
      return false
    }
  }
  
  // WIDGET Course Reminder
  @objc(startCourseReminderActivity:withMessage:withImage:)
  public func startCourseReminderActivity(title: String, message: String, image: String) -> Void {
    if #available(iOS 16.1, *) {
      let initialContentState = CourseReminderAttributes.ContentState(notiText: "Nộp báo cáo môn Dự án công nghệ", notiTime: "23:59 18/12/2022")
      let activityAttributes = CourseReminderAttributes(name: "Son")
      
      do {
        _ = try Activity.request(attributes: activityAttributes, contentState: initialContentState)
        print("Requested a motification Live Activity.")
      } catch (let error) {
        print("Error requesting motification delivery Live Activity \(error.localizedDescription).")
      }
    }
  }
  
  @objc(updateCourseReminderActivity:)
  public func updateCourseReminderActivity(message: String) -> Void {
    if #available(iOS 16.1, *) {
      
      let notificationStatus = CourseReminderAttributes.ContentState(notiText: "Còn 1 tiếng đẻ nộp báo cáo môn dự án công nghệ", notiTime: "23:59 18/12/2022")
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
      let notificationStatus = CourseReminderAttributes.ContentState(notiText: "Còn 1 tiếng đẻ nộp báo cáo môn dự án công nghệ", notiTime: "23:59 18/12/2022")
      
      
      Task {
        for activity in Activity<CourseReminderAttributes>.activities {
          await activity.end(using:notificationStatus, dismissalPolicy: .default)
        }
      }
    }
  }
  
}

