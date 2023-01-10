# 【iOS(Swift)】<br>プッシュ通知受信時にWebViewを表示しよう(リッチプッシュ)
*20230106更新*

![リッチプッシュ](/readme-img/RichPush.png)

## 概要
Xcode（Swift）で作成したネイティブアプリにニフクラ mobile backendの『プッシュ通知』機能の１つで、プッシュ通知にURLを設定し配信できる『リッチプッシュ』機能を実装したサンプルプロジェクトです。リッチプッシュ機能を使うと、ユーザーがプッシュ通知を開封する際に、画面に指定したWebページを「WebView」で表示させることが可能です

## ニフクラ mobile backend とは

https://mbaas.nifcloud.com/

スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、**無料**(注1)から使えるクラウドサービスです。

注1：詳しくは[こちら](https://mbaas.nifcloud.com/price.htm)をご覧ください

## 動作環境

プロジェクトに組み込んでいるニフクラ mobile backendのSDKのバージョンはドキュメント更新時点で最新の __v1.3.1__ です。このバージョンでの動作環境は下記です。

* Swift version 4.2, 5.x
* iOS 13.x ～ iOS 16.x
* Xcode 13.2.1 〜 Xcode 14.x
* armv7k, arm64, arm64e アーキテクチャ

SDKのバージョンアップを行う場合は[こちら（参考：SDKのアップデートについて）](https://mbaas.nifcloud.com/doc/current/introduction/quickstart_swift.html#Carthage%E3%82%92%E5%88%A9%E7%94%A8%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95)を参考に更新をお願いします。また、最新のSDKバージョン及び動作環境については[mobile backend Swift SDK | GitHub](https://github.com/NIFCLOUD-mbaas/ncmb_swift)をご参照ください。
プロジェクト作成時に動作検証を行った端末情報も併せて記載しておきます。

* macOS Monterey 12.6.1
* Xcode 14.0.1
* iOS 15.7 (iPhone 11 Pro)

※プッシュ通知の動作検証には実機ビルドが必須です

## サンプルプロジェクトの使い方・作業手順
### 0.プッシュ通知機能を使うための準備

* ニフクラ mobile backendのプッシュ通知は、iOSが提供している通知サービス（APNs（Apple Push Notification Service））を利用しています
* APNsを利用するには証明書を利用した認証が必要です
* 下記のドキュメントをご覧の上、認証に必要な証明書類の作成をします
  * [プッシュ通知に必要な証明書の作り方 | Qiita](https://qiita.com/natsumo/items/d5cc1d0be427ca3af1cb)
  * なお証明書の作成には[Apple Developer Program](https://developer.apple.com/account/)の登録（有料）が必要です

### 1. ニフクラ mobile backendの会員登録（無料）とログイン及びアプリ作成
* 下記リンクからニフクラ mobile backendの会員登録（無料：SNS ID）、ログインをします
  * https://console.mbaas.nifcloud.com/signup
* 「アプリの新規作成」画面（既にアプリを作成済みの場合は「+新しいアプリ」をクリックする）でアプリ名（例：SwiftPushApp）を入力しアプリを作成します
* アプリが作成されるとAPIキー（２種類）が発行されます
* APIキー（アプリケーションキーとクライアントキー）はこの後、「3. APIキーの設定」でXcodeにインポートするサンプルアプリ上で使用します
* 「OK」をクリックするとダッシュボードが表示されます
* 右上の「アプリ設定」をクリックし、「プッシュ通知」を開きます
* 「プッシュ通知」＞「プッシュ通知の許可」で「許可する」を選択し、「保存する」をクリックします
* 「iOSプッシュ通知(p12)」＞「証明書（p12）」の「証明書の選択」ボタンをクリックして「0.プッシュ通知機能を使うための準備」で作成した「⑦APNs用証明書(.p12)」を選択、「アップロード」ボタンをクリックして設定します
  * 「証明書は設定されています。」と表示されればOKです

### 2. サンプルプロジェクトのダウンロード
* 下記リンクをクリックしてプロジェクトをダウンロードします
  * https://github.com/NIFCLOUD-mbaas/SwiftRichPushApp/archive/master.zip

### 3. Xcodeでプロジェクトを起動

* ダウンロードしたフォルダを開き、「__SwiftRichPushApp.xcodeproj__」をダブルクリックしてXcodeでプロジェクトを起動します

### 4. APIキーの設定
* `AppDelegate.swift`を編集します
* 先程ニフクラ mobile backendのダッシュボード上で確認したAPIキー、それぞれ`YOUR_APPLICATION_KEY`と`YOUR_CLIENT_KEY`の部分に貼り、書き換えます
  * APIキーは、ニフクラ mobile backend管理画面、右上の「アプリ設定」から確認できます
  * １つずつコピーボタンでコピーして貼り付けてください
  * このとき、ダブルクォーテーション（`"`）を消さないように注意してください
* 書き換え終わったら`command + s`キーで保存をします

### 5. 実機ビルド
始めて実機ビルドをする場合は、Xcodeにアカウント（Apple ID）の登録をします。

* メニューバーの「Xcode」＞「Preferences...」＞「Accounts」を選択します
* 左下の「＋」＞「Apple ID」をクリックします
* 「Apple ID」を入力して「Next」、「Password」を入力して「Next」をクリックすると追加されます
  * 認証のためコードを要求された場合は従ってください
* 追加されたらこの画面は閉じます

ビルドに必要な設定をしていきます。

* プロジェクトを選択して、「Signing & Capabilities」を開きます
* 「0.プッシュ通知機能を使うための準備」で作成した「②開発用ビルド証明書(.cer)」と「⑤プロビジョニングプロファイル」を設定します
  * あらかじめ「②開発用ビルド証明書(.cer)」と「⑤プロビジョニングプロファイル」はダブルクリックをし、キーチェーンアクセスと紐づけておきましょう
* 「Team」で「Apple ID」を選択し、「Bundle IdentiIdentier」に「0.プッシュ通知機能を使うための準備」で作成した「③AppID」を記入します
* 無事連携されれば「Provisioning Profile」、「Signing Certificate」が表示されます

![画像i01](/readme-img/i01.png)

実機にビルドします。

* 「0.プッシュ通知機能を使うための準備」の「④端末の登録」で登録した、動作確認用iPhoneをMacにつなぎます
* 接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします
  * iOSのバージョンが一致せずビルドエラーとなる場合は、「General」＞「Minimum Deployments」で対象OSを変更してください

![画像i02](/readme-img/i02.png)

### 6.動作確認
* ビルドされたアプリは自動で起動します
* プッシュ通知の許可を求めるアラートが出るので、必ず許可します
  * 許可しないとプッシュ通知が届きません
* この時点でデバイストークンがAPNsから取得され、ニフクラ mobile backendに保存されます
  * 正しく保存されると、Xcode側にログ（`保存に成功しました`）が出力されます
* ニフクラ mobile backendの管理画面から「データストア」＞「installation」クラスを確認してみましょう

![画像i03](/readme-img/i03.png)

* 端末側で起動したアプリは一度閉じて（完全に終了して）おきます

### 7.プッシュ通知を送りましょう

実際にプッシュ通知を送ってみましょう

* ニフクラ mobile backend のダッシュボードで「プッシュ通知」＞「＋新しいプッシュ通知」をクリックします
* プッシュ通知のフォームが開かれます
* 必要な項目を入力してプッシュ通知を作成します
* リッチプッシュを配信するには、
  * 必ず有効なURLを「URL」に入力してください
  * 必ず「content-available」を「有効にする」してください

![画像i05](/readme-img/i05.png)

* 端末を確認しましょう
* 少し待つとプッシュ通知が届くので、届いたプッシュ通知をタップしてアプリを開くとWebビューが表示され、設定したURLのページが表示されます

![リッチプッシュ](/readme-img/RichPush.png) 

アプリの状態により、WebView（リッチプッシュ）の表示のされ方は以下のようになります。なお、いずれも表示されたWebViewを閉じるには、画面下の「Close」をタップします。（リッチプッシュによって表示されるWebViewは一度い閉じると再表示できません）

#### アプリが起動していないときプッシュ通知を受信した場合
* アプリを __完全に閉じた状態（Kill）__ でプッシュ通知を送った場合は、プッシュ通知が受信されます
* 受信したプッシュ通知をタップするとWebViewが画面に表示されます

#### アプリが起動しているときプッシュ通知を受信した場合
* アプリを起動している（画面に表示中）状態でプッシュ通知を送った場合は、プッシュ通知自体は __表示されません__ ！（iOSの仕様）
  * 起動中のアプリの画面にWebViewが画面に表示されます
* アプリを起動している（バックグラウンド起動中）状態でプッシュ通知を送った場合は、プッシュ通知が受信されます
  * 受信したプッシュ通知をタップするか、バックグラウンドからアプリを最前面に表示するとWebViewが画面を確認できます

## 解説
サンプルプロジェクトに実装済みの内容のご紹介します。

#### SDKのインポートと初期設定

SDKの導入はCarthage利用しています。

* ニフクラ mobile backend の[ドキュメント（クイックスタート）](https://mbaas.nifcloud.com/doc/current/introduction/quickstart_swift.html)

#### プッシュ通知機能の実装
* `AppDelegate.swift`の`didFinishLaunchingWithOptions`メソッドにAPNsに対してデバイストークンの要求するコードを記述し、デバイストークンが取得された後に呼び出される`didRegisterForRemoteNotificationsWithDeviceToken`メソッドを追記をします

```swift
//
//  AppDelegate.swift
//  SwiftPushApp
//
//  Created by ikeda.natsumo on 2023/01/06.
//

import UIKit
import NCMB
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // APIキーの設定とSDK初期化
        NCMB.initialize(applicationKey: "YOUR_APPLICATION_KEY", clientKey: "YOUR_CLIENT_KEY")
        
        // APNsにデバイストークンを要求
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if((error) != nil) {
                return
            }
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //端末情報を扱うNCMBInstallationのインスタンスを作成
        let installation : NCMBInstallation = NCMBInstallation.currentInstallation

        //Device Tokenを設定
        installation.setDeviceTokenFromData(data: deviceToken)

        //端末情報をデータストアに登録
        installation.saveInBackground(callback: { result in
            switch result {
            case .success:
                //端末情報の登録が成功した場合の処理
                print("保存に成功しました")
            case let .failure(error):
                //端末情報の登録が失敗した場合の処理
                print("保存に失敗しました: \(error)")
                return;
            }
        })
    }

// 以下省略
}
```

#### リッチプッシュの取得
* 上記デバイストークン処理のコードに加え、２箇所（処理を実行するタイミング）にそれぞれに下記のコードを追記しています

##### __アプリが起動されるときプッシュ通知を開封する場合__
* アプリが起動されるときプッシュ通知を開封するる場合の処理は、`didFinishLaunchingWithOptions`メソッド内に記述します

```swift
// MARK: リッチプッシュ通知を表示させる
if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
        NCMBPush.handleRichPush(userInfo: notification)
}
```

##### __アプリが起動しているときプッシュ通知を開封する場合__
* アプリが起動しているとき起動中に開封するため、`didReceiveRemoteNotification`メソッドを追記し、記述します

```swift
// プッシュ通知を受信したときの処理
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {
    if let notiData = userInfo as? [String : AnyObject] {
        // MARK: リッチプッシュ通知を表示させる
        NCMBPush.handleRichPush(userInfo: notiData)
    }
}
```

（参考）実装完了した `AppDelegate.swift`

```swift
//
//  AppDelegate.swift
//  SwiftRichPushApp
//
//  Created by ikeda.natsumo on 2023/01/06.
//

import UIKit
import NCMB
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // APIキーの設定とSDK初期化
        NCMB.initialize(applicationKey: "YOUR_APPLICATION_KEY", clientKey: "YOUR_CLIENT_KEY")
        
        // APNsにデバイストークンを要求
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if((error) != nil) {
                return
            }
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        // MARK: リッチプッシュ通知を表示させる
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
                NCMBPush.handleRichPush(userInfo: notification)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //端末情報を扱うNCMBInstallationのインスタンスを作成
        let installation : NCMBInstallation = NCMBInstallation.currentInstallation

        //Device Tokenを設定
        installation.setDeviceTokenFromData(data: deviceToken)

        //端末情報をデータストアに登録
        installation.saveInBackground(callback: { result in
            switch result {
            case .success:
                //端末情報の登録が成功した場合の処理
                print("保存に成功しました")
            case let .failure(error):
                //端末情報の登録が失敗した場合の処理
                print("保存に失敗しました: \(error)")
                return;
            }
        })
    }
    
    // プッシュ通知を受信したときの処理
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {
        if let notiData = userInfo as? [String : AnyObject] {
            // MARK: リッチプッシュ通知を表示させる
            NCMBPush.handleRichPush(userInfo: notiData)
        }
    }

// 以下省略
}
```
