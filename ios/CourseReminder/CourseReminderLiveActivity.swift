//
//  CourseReminderLiveActivity.swift
//  CourseReminder
//
//  Created by Sern Duck on 18/12/2022.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct CourseReminderLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: CourseReminderAttributes.self) { context in
      // Lock screen/banner UI goes here
      HStack(alignment: .center, spacing: 8) {
        Image("UetLogo")
        VStack(alignment: .leading, spacing: 4) {
          Text(context.state.notiText)
            .font(.system(size: 14))
          Text(context.state.notiTime)
            .font(.system(size: 12))
            .foregroundColor(.gray)
        }
      }
      .activityBackgroundTint(Color.cyan)
      .activitySystemActionForegroundColor(Color.black)
      
    } dynamicIsland: { context in
      DynamicIsland {
        // Expanded UI goes here.  Compose the expanded UI through
        // various regions, like leading/trailing/center/bottom
        DynamicIslandExpandedRegion(.leading) {
          Image("UetLogo")
        }
        DynamicIslandExpandedRegion(.trailing) {
          Image(systemName: "bell.fill")
        }
        DynamicIslandExpandedRegion(.bottom) {
          VStack(alignment: .leading, spacing: 4) {
            Label(context.state.notiText, systemImage: "book")
              .font(.system(size: 16))
            Label(context.state.notiTime, systemImage: "clock")
              .font(.system(size: 14))
              .foregroundColor(.gray)
          }
          // more content
        }
      } compactLeading: {
        Image("UetLogo")
      } compactTrailing: {
        Image(systemName: "bell.fill")
      } minimal: {
        Image("UetLogo")
      }
      .widgetURL(URL(string: "http://www.apple.com"))
      .keylineTint(Color.red)
    }
  }
}

struct CourseReminderLiveActivity_Previews: PreviewProvider {
  static let attributes = CourseReminderAttributes(name: "Me")
  static let contentState = CourseReminderAttributes.ContentState(notiText: "Xyz", notiTime: "23:59")
  
  static var previews: some View {
    attributes
      .previewContext(contentState, viewKind: .dynamicIsland(.compact))
      .previewDisplayName("Island Compact")
    attributes
      .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
      .previewDisplayName("Island Expanded")
    attributes
      .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
      .previewDisplayName("Minimal")
    attributes
      .previewContext(contentState, viewKind: .content)
      .previewDisplayName("Notification")
  }
}
