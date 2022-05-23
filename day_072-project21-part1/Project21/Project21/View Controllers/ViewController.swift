//
//  ViewController.swift
//  Project21
//
//  Created by John Salvador on 5/22/22.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    // MARK: - Helper Methods
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let remind = UNNotificationAction(identifier: "remind", title: "Remind me", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
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
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // The user swiped to unlock
                print("Default identifier")
                infoLabel.text = "User swiped notification to unlock"
                
            case "show":
                // The user tapped our "Show more info.." button
                print("Show more information...")
                infoLabel.text = "User tapped 'Tell me more...' button"
                
            default:
                break
            }
        }
        
        // You must call the completion handler when you are done
        completionHandler()
    }
}

