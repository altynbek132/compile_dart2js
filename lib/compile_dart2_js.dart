import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

import 'dart:async';
import 'dart:io';

import 'package:utils/utils_dart/stream_sink_add_stream_non_blocking_extension.dart';

Future<void> compileDart2Js(
  String dir,
  String globPattern, {
  bool fvm = false,
}) async {
  final files = getFiles(dir, globPattern);
  await Future.wait(
    (await files.toList()).map((file) async {
      print('Compiling $file');
      final process = await Process.start(
        '',
        [
          if (fvm) 'fvm',
          'dart',
          'compile',
          'js',
          '-o',
          '${file}.js',
          file,
        ],
        runInShell: true,
      );
      stdout.addStreamNonBlocking(process.stdout);
      stderr.addStreamNonBlocking(process.stderr);
      if (await process.exitCode != 0) {
        print('Error compiling $file');
        print(process.stderr);
      }
    }),
  );
}

Stream<String> getFiles(String dir, String globPattern) async* {
  final directory = Directory(dir);
  if (!await directory.exists()) {
    throw FileSystemException("Directory does not exist", dir);
  }

  final glob = Glob(globPattern);

  await for (final entity in glob.list(root: dir)) {
    if (entity is File) {
      yield entity.path;
    }
  }
}
