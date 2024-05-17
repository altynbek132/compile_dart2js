import 'package:args/args.dart';

abstract class Args {
  static const String help = 'help';
  static const String version = 'version';
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
        ..addOption(
          Args.pattern,
          defaultsTo: '*_js.dart',
          help: """
Glob pattern to compile.

Example: 'web/*_js.dart'
Default: '*_js.dart'
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
