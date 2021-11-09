//
//  NotificationManager.swift
//  TestSdk
//
//  Created by macuser on 11/3/21.
//

import Foundation
import UserNotifications

enum NotificationName: String {
    case alarmIsOn = "alarmIsOn"
    case alarmIsOff = "alaemIsOff"

    var notification: Notification.Name  {
        return Notification.Name(rawValue: self.rawValue )
    }
}

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

    func removeAllPendingNotificationRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
    }

    func getPendingNotifications(complition: ((String?) -> ())?) {
        notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                guard let trigger = request.trigger as? UNCalendarNotificationTrigger, let nextTriggerDate = trigger.nextTriggerDate() else { return }

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                complition?(dateFormatter.string(from: nextTriggerDate)
)
            }
        })
    }
}
