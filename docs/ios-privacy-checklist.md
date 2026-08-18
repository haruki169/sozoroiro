# iOS配布準備 プライバシー関連チェックリスト（T-024）

tech-stack.md 8.3節の確定事項に基づく、実装済み事項と申請時にユーザー自身が行う必要がある事項をまとめる。

## 実装済み（コード側で対応完了）

- **Info.plist**（`ios/Runner/Info.plist`）
  - `NSLocationWhenInUseUsageDescription`: 「歩いた場所と見つけた色を結びつけて記録するために使用します。記録するかどうかは、記録画面でいつでもオン・オフを選べます。」
  - `NSCameraUsageDescription`: 「見つけた色を撮影するために使用します。」
  - `NSLocationAlwaysAndWhenInUseUsageDescription` は意図的に設定していない（Always権限は要求しない方針）
- **Privacy Manifest**（`ios/Runner/PrivacyInfo.xcprivacy`、Runnerターゲットのビルドリソースに追加済み）
  - `NSPrivacyCollectedDataTypes`: Coarse Location（収集あり／トラッキングなし／ユーザー紐付けなし／用途はApp Functionality）
  - `NSPrivacyAccessedAPITypes`: File Timestamp（reason `C617.1`）、Disk Space（reason `E174.1`）— `path_provider`・`sqlite3_flutter_libs`がPrivacyInfo.xcprivacyを同梱していないため、アプリ側でカバー
  - `flutter_privacy_doctor`で依存パッケージを監査済み（geolocator_apple, flutter_local_notifications, image_picker_ios, share_plus, package_info_plus, flutter_timezone は各パッケージ自身がPrivacyInfo.xcprivacyを同梱していることを確認済み）
- **App Tracking Transparency（ATT）**: 未実装（意図的）。判断根拠は下記参照。

## ユーザー側で対応が必要な事項

以下はApple Developerアカウント・App Store Connectへのアクセスが必要なため、Claudeでは代行できない。

1. **App Store Connect プライバシー申告（Privacy Nutrition Label）**
   - データ収集: あり（Location — Coarse Location）
   - トラッキング: なし
   - ユーザーへの紐付け: なし
   - 用途区分: App Functionality
   - 申告先: App Store Connect > (対象アプリ) > App Privacy
2. **ATT（App Tracking Transparency）の同意ダイアログを実装していないことの確認**
   - 判断根拠: 本アプリは他社アプリ・Webサイトを横断したトラッキングを一切行わない（広告SDK、解析SDK等は不使用）。取得した位置情報はOpen-Meteo APIへの匿名座標クエリにのみ使用し、ユーザーIDや広告識別子と紐付けて外部送信することはない。そのため`AppTrackingTransparency`フレームワークによる同意ダイアログは不要と判断する（tech-stack.md 8.3節(4)参照）。
   - 審査時にこの判断根拠を求められた場合は、上記説明をApp Review情報欄に記載する。
3. **証明書・プロビジョニングプロファイルの設定**（Apple Developer Program登録が必要）
4. **実機でのカメラ撮影・位置情報取得の最終動作確認**（Claudeの開発環境のシミュレータにはカメラがないため未検証。T-022参照）
