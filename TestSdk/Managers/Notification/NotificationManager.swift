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
        identifier: String,
        soundName: String,
        timeInterval: TimeInterval
    ) {
        let content = UNMutableNotificationContent()

        content.title = "Alarm"
        content.body = "Wake up!"
        content.sound = UNNotificationSound.init(named:UNNotificationSoundName(rawValue: soundName))

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: timeInterval,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: identifier,
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
