import 'package:args/args.dart';

abstract class Args {
  static const String help = 'help';
  static const String version = 'version';
  static const String dir = 'dir';
  static const String pattern = 'pattern';
  static const String fvm = 'fvm';
}

ArgParser buildParser() {
  return ArgParser()
        ..addFlag(
          Args.help,
          abbr: 'h',
          negatable: false,
          help: 'Print this usage information.',
        )
        ..addFlag(
          Args.version,
          negatable: false,
          help: 'Print the tool version.',
        )
        //
        ..addFlag(
          Args.dir,
          negatable: false,
          defaultsTo: true,
          help: """
Directory to compile.

Example: 'web'
Default: '.'
"""
              .trim(),
        )
        ..addFlag(
          Args.pattern,
          negatable: false,
          help: """
Glob pattern to compile.

Example: 'web/*.dart'
Default: '*.dart'
"""
              .trim(),
        )
        ..addFlag(
          Args.fvm,
          negatable: false,
          help: """
fvm dart or dart
"""
              .trim(),
        )
      //
      ;
}
