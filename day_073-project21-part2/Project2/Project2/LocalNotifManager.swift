//
//  LocalNotifManager.swift
//  Project2
//
//  Created by John Salvador on 5/23/22.
//

import Foundation
import UserNotifications


class LocalNotifManager {
    
    // MARK: - Shared Instance
    static let shared = LocalNotifManager()
    
    // MARK: - Properties
    private let center = UNUserNotificationCenter.current()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Helper Methods
    public func registerLocalNotif() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    public func scheduleLocalNotif() {
        // remove pending if there's any
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Let's play again!"
        content.body = "Consistency is the key!"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    public func removeAllPendingNotifRequest() {
        center.removeAllPendingNotificationRequests()
    }
    
    public func checkNotificationsAuthorizationStatus(completionHandler: @escaping (UNAuthorizationStatus) -> Void){
        center.getNotificationSettings { (notificationSettings) in
            completionHandler(notificationSettings.authorizationStatus)
        }
    }
}
