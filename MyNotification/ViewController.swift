//
//  ViewController.swift
//  MyNotification
//
//  Created by Fikri on 22/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if granted {
            print("Mendapatkan izin dari pengguna untuk local notifications")
        } else {
            print("Tidak mendapatkan izin dari pengguna untuk local notifications")
        }
      }
    }

    @IBAction func scheduledNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Submission anda telah diterima!"
        content.body = "Selamat anda telah menyelesaikan kelas belajar fundamental aplikasi iOS."
        content.sound = .default
        content.userInfo = ["value" : "Data dengan local notification"]
        
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(10))
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "message", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "Terjadi kesalahan dalam local notification")")
            }
        }
    }
    
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UserInfo yang terkait dengan notifikasi == \(response.notification.request.content.userInfo)")
        
        completionHandler()
    }
}

