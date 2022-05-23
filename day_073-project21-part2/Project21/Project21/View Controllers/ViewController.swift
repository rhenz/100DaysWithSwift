//
//  ViewController.swift
//  Project21
//
//  Created by John Salvador on 5/22/22.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    // MARK: -
    enum NotificationActionID: String {
        case show
        case remindMeLater
        
        var title: String {
            switch self {
            case .show:
                return "Tell me more..."
            case .remindMeLater:
                return "Remind me later"
            }
        }
    }
    
    // MARK: - Properties
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Helper Methods
    @objc private func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc private func scheduleLocal(remindIn24Hours: Bool = false) {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let t = remindIn24Hours ? 86400 : 5
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(t), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    private func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: NotificationActionID.show.rawValue,
                                        title: NotificationActionID.show.title,
                                        options: .foreground)
        let remindMeLater = UNNotificationAction(identifier: NotificationActionID.remindMeLater.rawValue,
                                                 title: NotificationActionID.remindMeLater.title,
                                                 options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remindMeLater], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    // Challenge #1
    private func showAlert(with title: String = "Local Notification", message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void)
    {
        // Pull out the buried unserInfo dictionary
        let userInfo = response.notification.request.content.userInfo
        if let _ = userInfo["customData"] as? String {
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                showAlert(message: "The user swiped the notification to unlock")
            case NotificationActionID.show.rawValue:
                showAlert(message: "The user tapped 'Show more info...'")
            case NotificationActionID.remindMeLater.rawValue:
                // Challenge #2
                scheduleLocal(remindIn24Hours: true)
            default:
                showAlert(message: response.actionIdentifier)
            }
        }
        
        // You must call the completion handler when you are done
        completionHandler()
    }
}

