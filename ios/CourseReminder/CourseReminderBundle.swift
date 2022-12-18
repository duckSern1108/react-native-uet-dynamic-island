//
//  CourseReminderBundle.swift
//  CourseReminder
//
//  Created by Sern Duck on 18/12/2022.
//

import WidgetKit
import SwiftUI

@main
struct CourseReminderBundle: WidgetBundle {
    var body: some Widget {
        CourseReminder()
        CourseReminderLiveActivity()
    }
}
