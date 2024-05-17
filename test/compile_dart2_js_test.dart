import 'dart:io';

import 'package:compile_dart2js/compile_dart2_js.dart';
import 'package:test/test.dart';

void main() {
  group('compileDart2Js', () {
    const assetsDir = 'test/assets';

    setUp(() {
      cleanNonDart(assetsDir);
    });

    tearDownAll(() {
      cleanNonDart(assetsDir);
    });

    test('should compile a single file', () async {
      await compileDart2Js(assetsDir, 'main.dart', fvm: false);
      expect(await File('$assetsDir/main.dart.js').exists(), true);
      expect(await File('$assetsDir/main2.dart.js').exists(), false);
    });
    test('should handle non-existent directory', () async {
      const dir = '/path/to/nonexistent/directory';
      const globPattern = '*.dart';

      await expectLater(
        () => compileDart2Js(dir, globPattern, fvm: false),
        throwsA(isA<FileSystemException>()),
      );
    });

    test('should compile multiple files', () async {
      const globPattern = '*.dart';

      await compileDart2Js(assetsDir, globPattern, fvm: false);

      expect(await File('$assetsDir/main.dart.js').exists(), true);
      expect(await File('$assetsDir/main2.dart.js').exists(), true);
    });
    test('should obey glob pattern', () async {
      const globPattern = '*_compile_js.dart';

      await compileDart2Js(assetsDir, globPattern, fvm: false);

      expect(await File('$assetsDir/foo_compile_js.dart.js').exists(), true);
      expect(await File('$assetsDir/bar_compile_js.dart.js').exists(), true);

      expect(await File('$assetsDir/main.dart.js').exists(), false);
      expect(await File('$assetsDir/main2.dart.js').exists(), false);
    });
  });
}

void cleanNonDart(String assetsDir) {
  final files = Directory(assetsDir).listSync();
  for (final file in files) {
    if (!file.path.endsWith('.dart')) {
      file.deleteSync();
    }
  }
}
