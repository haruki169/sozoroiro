# そぞろいろ

散歩中に、その日の「色のお題」に近い色を見つけて記録していくアプリ。スコアやランキング、対戦要素を持たず、日記や俳句に近い感覚で、日々の色との出会いを静かに積み重ねていく。

「歩くたびに、世界の色に気づく」

## ドキュメント

- [要件定義書](./そぞろいろ_要件定義書.md)
- [技術選定書](./tech-stack.md)
- [設計書](./docs/design.md)
- [実装タスクリスト](./docs/tasks.md)（GitHub Issuesと連携して管理）

## 技術スタック

Flutter (Dart) / Riverpod / go_router / Drift (SQLite) / palette_generator / geolocator / flutter_map + MapTiler Cloud / flutter_local_notifications / Open-Meteo API

詳細は [tech-stack.md](./tech-stack.md) を参照。

## セットアップ

```bash
flutter pub get
flutter run
```

Drift等のコード生成が必要なファイルを変更した場合:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## タスク管理

実装タスク（T-001〜T-024）は [docs/tasks.md](./docs/tasks.md) を元にGitHub Issuesで管理する。依存関係・完了条件は各Issue本文および tasks.md を参照。
