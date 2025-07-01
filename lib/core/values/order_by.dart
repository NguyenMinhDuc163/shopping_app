enum OrderBy {
  /// từ thấp đến cao
  asc('ASC'),

  /// từ cao đến thấp
  desc('DESC');

  final String value;

  const OrderBy(this.value);
}
