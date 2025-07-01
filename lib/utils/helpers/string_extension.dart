
final RegExp _videoUrlRegex = RegExp(r'(.mp4)$');
final RegExp _youtubeUrlRegex = RegExp(
    r'^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube(-nocookie)?\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|live\/|v\/)?)([\w\-]+)(\S+)?$');
final RegExp _imagePathRegex = RegExp(r'\.(jpeg|jpg|png|gif|webp|bmp|wbmp)$');

extension StringExtension on String {
  static bool asBool(String value) => value == '1';

  bool get isVideoUrl => _videoUrlRegex.hasMatch(this);

  bool get isYoutubeUrl => _youtubeUrlRegex.hasMatch(this);

  bool get isImageUrl => !isVideoUrl || !isYoutubeUrl;

  bool get isImagePath => _imagePathRegex.hasMatch(this);

  String get toLabel => "$this:";

  static String? nullOnBlank(String value) {
    if (value.trim().isEmpty) return null;

    return value;
  }

  String? get nullOnEmpty {
    if (isEmpty == true) return null;

    return this;
  }
}

extension NullableStringExtension on String? {
  bool get isBlank => this == null || this?.isEmpty == true;
  bool get isNotBlank => isBlank == false;
}
