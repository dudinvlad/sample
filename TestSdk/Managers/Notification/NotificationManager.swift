//
//  NotificationManager.swift
//  TestSdk
//
//  Created by macuser on 11/3/21.
//

import Foundation
import UserNotifications

class NotificationManager {
	private let notificationCenter = UNUserNotificationCenter.current()

    func scheduleNotification(
        dateTime: Date
    ) {
        let content = UNMutableNotificationContent()

        content.title = "Alarm"
        content.body = "Wake up!"
        content.sound = UNNotificationSound(named:UNNotificationSoundName(rawValue: "local_push.mp3"))

        let dateComponents = Calendar.current.dateComponents([.hour,.minute], from: dateTime)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }

    }
}
