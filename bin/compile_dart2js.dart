import 'package:args/args.dart';
import 'package:compile_dart2js/args.dart';
import 'package:compile_dart2js/compile_dart2_js.dart';

const String version = '0.0.1';

void printUsage(ArgParser argParser) {
  print('Usage: dart compile_dart2js.dart <flags> [dir]');
  print(argParser.usage);
}

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    final dir = results.rest.firstOrNull;
    final globPattern = results[Args.pattern];
    final fvm = results[Args.fvm];

    // Process the parsed arguments.
    if (results.wasParsed(Args.help) || dir == null) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed(Args.version)) {
      print('compile_dart2js version: $version');
      return;
    }

    await compileDart2Js(dir, globPattern, fvm: fvm);
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
