//
//  NotificationCenter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 12/02/24.
//

import Foundation
import UIKit

protocol NotificationManagerDelegate: AnyObject {
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillShow info: NotificationManager.Info)
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillHide info: NotificationManager.Info)
}

class NotificationManager: NSObject {
    
    unowned let notificationManagerDelegate: NotificationManagerDelegate
    
    init(notificationManagerDelegate: NotificationManagerDelegate) {
        self.notificationManagerDelegate = notificationManagerDelegate
    }
    
    func registerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(_ :)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func removeObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func hideKeyboard(_ notification: Notification){
        let info: Info = Info(info: notification.userInfo)
        self.notificationManagerDelegate.NotificationManagerDelegate(self, keyboardWillHide: info)
    }
    
    @objc func showKeyboard(_ notification: Notification){
        let info: Info = Info(info: notification.userInfo)
        self.notificationManagerDelegate.NotificationManagerDelegate(self, keyboardWillShow: info)
    }
}

extension NotificationManager {
    struct Info {
        let frame: CGRect
        let animation: Double
        
        init(info: [AnyHashable: Any]?){
            self.frame = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            self.animation = info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 1
        }
    }
}
