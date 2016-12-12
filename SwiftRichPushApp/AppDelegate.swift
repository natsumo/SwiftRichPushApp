//
//  AppDelegate.swift
//  SwiftPushApp_
//
//  Created by Ikeda Natsumo on 2016/12/08.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    // payload
    var payloadKeyData: Array<String> = []
    var payloadValueData: Array<String> = []
    var payload_flag = false
    
    // APIキーの設定
    let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
    let clientkey      = "YOUR_NCMB_CLIENTKEY"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // SDKの初期化
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
        
        // デバイストークンの要求
        if #available(iOS 10.0, *){
            /** iOS10以上 **/
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) {granted, error in
                if error != nil {
                    // エラー時の処理
                    return
                }
                if granted {
                    // デバイストークンの要求
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            /** iOS8以上iOS10未満 **/
            //通知のタイプを設定したsettingを用意
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            //通知のタイプを設定
            application.registerUserNotificationSettings(setting)
            //DevoceTokenを要求
            application.registerForRemoteNotifications()
        }
        
        // アプリ起動時にプッシュ通知の情報を取得する
        if let userInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as! [AnyHashable : Any]! {
            // リッチプッシュを表示させる処理
            NCMBPush.handleRichPush(userInfo)
            
        }
        
        return true
    }
    
    // デバイストークンが取得されたら呼び出されるメソッド
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 端末情報を扱うNCMBInstallationのインスタンスを作成
        let installation : NCMBInstallation = NCMBInstallation.current()
        // デバイストークンの設定
        installation.setDeviceTokenFrom(deviceToken)
        // 端末情報をデータストアに登録
        installation.saveInBackground {error in
            if error != nil {
                // 端末情報の登録に失敗した時の処理
                let err = error as! NSError
                print("端末登録失敗：\(err.code)")
            } else {
                // 端末情報の登録に成功した時の処理
                print("端末登録成功")
            }
        }
    }
    
    // アプリが起動中にプッシュ通知の情報を取得する
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // リッチプッシュを表示させる処理
        NCMBPush.handleRichPush(userInfo)
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

