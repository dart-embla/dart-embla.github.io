import 'dart:io';
import 'dart:async';

import 'package:markdown/markdown.dart';

const docsSourceDirectory = 'docs/source/';
const docsOutputDirectory = 'build/web/docs/';

main(List<String> args) {
  args.forEach((f) => new DocGenerator.fromPath(f).parse());
}

class DocGenerator {
  final File source;
  final File dest;
  final String version;
  final String path;
  static final RegExp pathMatcher = new RegExp(r'^(\d+\.\d+)\/(.*)\.md$');

  DocGenerator(this.source, this.dest, this.version, this.path);

  factory DocGenerator.fromPath(String path) {
    final file = new File(path).absolute;
    final pathInSource = file.path.split(docsSourceDirectory).last;
    final match = DocGenerator.pathMatcher.firstMatch(pathInSource);
    final version = match[1];
    var docPath = match[2];
    if (docPath == 'introduction') {
      docPath = 'index';
    }
    final destFile = new File('$docsOutputDirectory$version/$docPath.html');
    return new DocGenerator(file, destFile.absolute, version, docPath);
  }

  Future<Null> parse() async {
    await dest.create(recursive: true);
    await source.readAsString()
      .then(markdownToHtml)
      .then(dest.writeAsString);
  }
}
