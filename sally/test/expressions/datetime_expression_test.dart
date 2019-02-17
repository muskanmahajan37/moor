import 'package:sally/sally.dart';
import 'package:sally/src/runtime/components/component.dart';
import 'package:sally/src/runtime/expressions/expression.dart';
import 'package:test_api/test_api.dart';

typedef Expression<IntType> _Extractor(Expression<DateTimeType> d);

/// Tests the top level [year], [month], ..., [second] methods
void main() {
  final expectedResults = <_Extractor, String>{
    year: 'CAST(strftime("%Y", column, "unixepoch") AS INTEGER)',
    month: 'CAST(strftime("%m", column, "unixepoch") AS INTEGER)',
    day: 'CAST(strftime("%d", column, "unixepoch") AS INTEGER)',
    hour: 'CAST(strftime("%H", column, "unixepoch") AS INTEGER)',
    minute: 'CAST(strftime("%M", column, "unixepoch") AS INTEGER)',
    second: 'CAST(strftime("%S", column, "unixepoch") AS INTEGER)',
  };
  final column = GeneratedDateTimeColumn('column', false);

  expectedResults.forEach((key, value) {
    test('should extract field', () {
      final ctx = GenerationContext(null);
      key(column).writeInto(ctx);

      expect(ctx.sql, value);
    });
  });
}