abstract mixin class Params {
  const Params();

  Map<String, dynamic>? toJson() => null;

  Future<Map<String, dynamic>>? toAsyncJson() => null;

  Map<String, String>? toSearchParams() => null;
}

class NoParams extends Params {}
