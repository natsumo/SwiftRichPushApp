# 【Swift iOS10】プッシュ通知受信時にWebページを表示しよう<br>（リッチプッシュ）
*2016/10/26作成*

![画像1](/readme-img/001.png)

## 概要
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の『プッシュ通知』機能において、プッシュ通知にURLを設定し配信できる『リッチプッシュ』機能を実装したサンプルプロジェクトです
* リッチプッシュ機能を使うと、プッシュ通知にURLを設定し配信を行った場合、ユーザープッシュ通知を開封する際にWebViewとして表示することが可能です
* 簡単な操作ですぐに [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の機能を体験いただけます★☆
* このサンプルはiOS10に対応しています
 * iOS8以上でご利用いただけます

## ニフティクラウドmobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* macOS Sierra 10.12
* Xcode ver. 8.0
* iPhone6 ver. 10.0.1
 * このサンプルアプリは、プッシュ通知を受信する必要があるため実機ビルドが必要です

※上記内容で動作確認をしています

## プッシュ通知の仕組み
* ニフティクラウドmobile backendのプッシュ通知は、iOSが提供している通知サービスを利用しています
 * iOSの通知サービス　__APNs（Apple Push Notification Service）__

 ![画像10](/readme-img/010.png)

* 上図のように、アプリ（Xcode）・サーバー（ニフティクラウドmobile backend）・通知サービス（APNs）の間でやり取りを行うため、認証が必要になります
 * 認証に必要な鍵や証明書の作成は作業手順の「0.プッシュ通知機能使うための準備」で行います

## 作業の手順
### 0.プッシュ通知機能使うための準備
__[【iOS】プッシュ通知の受信に必要な証明書の作り方(開発用)](https://github.com/natsumo/iOS_Certificate)__
* 上記のドキュメントをご覧の上、必要な証明書類の作成をお願いします
 * 証明書の作成には[Apple Developer Program](https://developer.apple.com/account/)の登録（有料）が必要です

![画像i002](/readme-img/i002.png)

### 1. [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の会員登録とログイン→アプリ作成と設定
* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

* 続けてプッシュ通知の設定を行います
* ここで⑦APNs用証明書(.p12)の設定も行います

![画像5](/readme-img/005.png)

### 2. [GitHub](https://github.com/natsumo/SwiftPushApp.git)からサンプルプロジェクトのダウンロード

* 下記リンクをクリックしてプロジェクトをダウンロードをMacにダウンロードします

 * __[SwiftRichPushApp](https://github.com/natsumo/SwiftRichPushApp/archive/master.zip)__

### 3. Xcodeでアプリを起動

* ダウンロードしたフォルダを開き、「__SwiftRichPushApp.xcworkspace__」をダブルクリックしてXcode開きます(白い方です)

![画像09](/readme-img/009.png)
![画像06](/readme-img/006.png)

* 「SwiftRichPushApp.xcodeproj」（青い方）ではないので注意してください！

![画像08](/readme-img/008.png)

### 4. APIキーの設定

* `AppDelegate.swift`を編集します
* 先程[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボード上で確認したAPIキーを貼り付けます

![画像07](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
* 書き換え終わったら`command + s`キーで保存をします

### 5. 実機ビルド
* 始めて実機ビルドをする場合は、Xcodeにアカウント（AppleID）の登録をします
 * メニューバーの「Xcode」＞「Preferences...」を選択します
 * Accounts画面が開いたら、左下の「＋」をクリックします。
 * Apple IDとPasswordを入力して、「Add」をクリックします

 ![画像i29](/readme-img/i029.png)

 * 追加されると、下図のようになります。追加した情報があっていればOKです
 * 確認できたら閉じます。

 ![画像i30](/readme-img/i030.png)

* 「TARGETS」 ＞「General」を開きます

![画像14](/readme-img/014.png)

* 「Identity」＞「Bundle Identifier」を入力します
 * 「Bundle Identifier」にはAppID作成時に指定した「Bundle ID」を入力してください
* 「Signing(Debug)」＞「Provisioning Profile」を設定します
 * 今回使用するプロビジョニングプロファイルをプルダウンから選択します
 * プロビジョニングプロファイルはダウンロードしたものを一度__ダブルクリック__して認識させておく必要があります（プルダウンに表示されない場合はダブルクリックを実施後設定してください）
 * 選択すると以下のようになります
 ![画像15](/readme-img/015.png)

* 「TARGETS」＞「Capabilities」を開き、「Push Notifications」を__ON__に設定します
 * 設定すると以下のようになります
 ![画像16](/readme-img/016.png)

* 設定は完了です
* lightningケーブルで登録した動作確認用iPhoneをMacにつなぎます
* Xcode画面で左上で、接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします

### 6.動作確認
* インストールしたアプリを起動します
 * プッシュ通知の許可を求めるアラートが出たら、必ず許可してください！
* 起動されたらこの時点でデバイストークンが取得されます
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「データストア」＞「installation」クラスを確認してみましょう！

![画像12](/readme-img/012.png)

### 7.リッチプッシュを送ってWebViewを表示させましょう
* 動作確認のため、アプリを完全に閉じておきましょう
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「プッシュ通知」＞「＋新しいプッシュ通知」をクリックします
* プッシュ通知のフォームが開かれます
* タイトル、メッセージ、__URL__ を入力してプッシュ通知を作成します

![画像11](/readme-img/011.png)

* 端末を確認しましょう！
* アプリの状態により、WebView（リッチプッシュ）の表示のされ方は以下のようになります

#### アプリが起動していないときプッシュ通知を受信した場合
* アプリを__完全に閉じた状態__でプッシュ通知を送った場合は、プッシュ通知が受信されます
* 受信したプッシュ通知をタップするとWebViewが画面に表示されます
* 画面下の「Close」をタップするとWebViewが閉じ、裏で起動していたアプリが表示されます
 * リッチプッシュによって表示されるWebViewは一度い閉じると再表示できません。

![画像1](/readme-img/001.png)

#### アプリが起動しているときプッシュ通知を受信した場合
* アプリを起動している（画面に表示中/バックグラウンド起動中）状態でプッシュ通知を送った場合は、プッシュ通知自体は__表示されません__！（iOSの仕様）ただし、プッシュ通知が受信できていないわけではなく、正しく配信されていれば、WebViewが画面に表示されます

## 解説
### SDKのインポートと初期設定
* ニフティクラウドmobile backend の[ドキュメント（クイックスタート）](http://mb.cloud.nifty.com/doc/current/introduction/quickstart_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [SwiftでmBaaSを始めよう！(＜CocoaPods＞でuse_framewoks!を有効にした方法)](http://qiita.com/natsumo/items/57d3a4d9be16b0490965)

### コード紹介
#### デバイストークン取得とニフティクラウドmobile backendへの保存
 * `AppDelegate.swift`の`didFinishLaunchingWithOptions`メソッドにAPNsに対してデバイストークンの要求するコードを記述し、デバイストークンが取得された後に呼び出される`didRegisterForRemoteNotificationsWithDeviceToken`メソッドを追記をします
 * デバイストークンの要求はiOSのバージョンによってコードが異なります

```swift
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

        // MARK: アプリが起動されるときに実行される処理を追記する場所

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

    // MARK: アプリが起動しているときに実行される処理を追記する場所
}
```

#### リッチプッシュの取得
* 上記デバイストークン処理のコードに加え、コメント（`// MARK:`）の２箇所（処理を実行するタイミング）にそれぞれに下記のコードを追記する必要があります

##### __アプリが起動されるときプッシュ通知を開封する場合__
* アプリが起動されるときプッシュ通知を開封するる場合の処理は、`didFinishLaunchingWithOptions`メソッド内に記述します

```swift
// MARK: アプリが起動されるときに実行される処理を追記する場所
if let userInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as! [AnyHashable : Any]! {
    // リッチプッシュを表示させる処理
    NCMBPush.handleRichPush(userInfo)
}
```

##### __アプリが起動しているときプッシュ通知を開封する場合__
* アプリが起動しているとき起動中に開封するため、`didReceiveRemoteNotification`メソッドを追記し、記述します

```swift
// MARK: アプリが起動しているときに実行される処理を追記する場所
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    // リッチプッシュを表示させる処理
    NCMBPush.handleRichPush(userInfo)
}
```

#### iOS9以上におけるhttp通信設定
iOS9以降の端末ではhttps通信でないとリッチプッシュのWebViewで画像を表示することができません。そのためhttps通信の許可設定をする必要があります。

* `Info.plist`に下記を追記します

![画像18](/readme-img/018.png)

* コードの場合は以下のように設定します

```plist:Info.plist
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## 参考
* 他にもさまざまなサンプルアプリを作っていますのでよろしければ見てください～
 * __https://github.com/natsumo __
