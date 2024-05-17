import 'package:args/args.dart';

const String version = '0.0.1';

abstract class Args {
  static const String help = 'help';
  static const String verbose = 'verbose';
  static const String version = 'version';
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
          Args.verbose,
          abbr: 'v',
          negatable: false,
          help: 'Show additional command output.',
        )
        ..addFlag(
          Args.version,
          negatable: false,
          help: 'Print the tool version.',
        )
      //
      ;
}

void printUsage(ArgParser argParser) {
  print('Usage: dart compile_dart2js.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    // Process the parsed arguments.
    if (results.wasParsed(Args.help)) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed(Args.version)) {
      print('compile_dart2js version: $version');
      return;
    }
    if (results.wasParsed(Args.verbose)) {
      verbose = true;
    }

    // Act on the arguments provided.
    print('Positional arguments: ${results.rest}');
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
