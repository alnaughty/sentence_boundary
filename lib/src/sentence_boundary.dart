class SentenceBoundary {
  final RegExp _regExp = RegExp(r"[^\w\s]");
  List<List<String>> detect(String fulltext) {
    List<List<String>> _ff = [];
    List<String> tokenized = fulltext.split(' ');
    List<String> _container = [];
    if (fulltext.contains(RegExp(r"[^\w\s]"))) {
      for (int x = 0; x < tokenized.length; x++) {
        final String token = tokenized[x];
        if (isTheEnd(token)) {
          _container.add(token);
          List<String> _subCont = List.from(_container);
          _ff.add(_subCont);
          _container.clear();
        } else {
          if (!isTheEnd(token) && x == tokenized.length - 1) {
            _container.add(token);
            List<String> _subCont = List.from(_container);
            _ff.add(_subCont);
            _container.clear();
          } else {
            _container.add(token);
          }
        }
      }
    } else {
      List<String> __container = [];
      for (String token in tokenized) {
        __container.add(token);
      }
      _ff.add(__container);
    }
    List<List<String>> _clean = [];
    for (List<String> toCheck in _ff) {
      print(toCheck);
      List<String> _checked = [];
      for (String ff in toCheck) {
        print(ff);
        String fin = ff;
        if (ff.contains(_regExp)) {
          final String matchedRegExp = ff[_regExp.firstMatch(ff)!.end - 1];
          print("REGEXP MATCH : $matchedRegExp");
          ff = ff.replaceAll(_regExp, "(!)$matchedRegExp");
          List<String> fee = ff.split("(!)");
          _checked += fee;
        } else {
          _checked.add(ff);
        }
      }
      _clean.add(_checked);
    }

    return _clean;
  }

  bool isTheEnd(String text) {
    return text.split(RegExp(r'[^\w\s]')).length == 2;
  }
}
