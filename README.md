# flutter_base_project_for_beginner

A base project of Flutter app for beginner.

## Getting Started


### Cấu trúc thư mục

- Tất cả các file/thư mục được đặt tên theo kiểu `snake_case`

> [Guideline](https://github.com/thanhle1547/flutter_architecture_notes/tree/main/proposed_simple_scalable)


### Naming Convention

> 1. [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style)
>
> 2. [Flutter: Best Practices and Tips](https://medium.com/flutter-community/flutter-best-practices-and-tips-7c2782c9ebb5)


### Setup [`spider`](https://pub.dev/packages/spider)

```
dart pub global activate spider
```


### Cấu hình VSCode

Trong thư mục `.vscode/`, tạo file `settings.json` và copy nội dung của file [settings.index.json](.vscode/settings.index.json) vào.




## Assets

Dùng thư viện [`spider`](https://pub.dev/packages/spider) gen ra file chứa đường dẫn tới các assets.

### Generate Code

Run following command to generate dart code:

```
spider build
```

### Watch Directory

Spider can also watch given directory for changes in files and rebuild dart code automatically. Use following command to watch for changes:

```
spider build --watch

# watching directories with verbose logs
spider build --watch --verbose
```

or

```
spider build --smart-watch
```
