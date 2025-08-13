extension QueryExt on Map<String, String>? {
  Map<String, String>? assign(Map<String, String>? other) {
    if (this == null) return {...?other};

    if (other == null) return {...?this};

    return {
      ...?this,
      ...other,
    };
  }
}
