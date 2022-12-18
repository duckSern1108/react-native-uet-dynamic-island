//
//  LiveActivityAttributes.swift
//  ReactNativeDynamicIslandUet
//
//  Created by Sern Duck on 18/12/2022.
//

import Foundation
import ActivityKit

struct CourseReminderAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    // Dynamic stateful properties about your activity go here!    
    var notiText: String
    var notiTime: String
  }
  
  // Fixed non-changing properties about your activity go here!
  var name: String
}
