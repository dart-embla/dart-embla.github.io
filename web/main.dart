import 'dart:html';
import 'dart:async';
import 'dart:convert' show JSON;

main() {
  for (final codeHint in querySelectorAll('.code-hint')) {
    new CodeHint(
      codeHint.querySelector('.code-hint__button'),
      codeHint.querySelector('.code-hint__pop-up')
    ).listen();
  }

  modifyCodeSamples();
  window.onHashChange.listen((_) => modifyCodeSamples());

  githubStarsBubble();
}

void modifyCodeSamples() {
  if (window.location.hash.contains('middleware')) {
    document.body.classes.add('with-middleware');
  } else {
    document.body.classes.remove('with-middleware');
  }
  if (window.location.hash.contains('routes')) {
    document.body.classes.add('with-routes');
  } else {
    document.body.classes.remove('with-routes');
  }
}

Future githubStarsBubble() async {
  final repoData = await HttpRequest
    .getString('https://api.github.com/repos/emilniklas/embla')
    .then(JSON.decode);

  final int stars = repoData['stargazers_count'];
  final bubble = querySelector('.header__github__bubble');

  bubble.text = '$stars';
  bubble.classes.add('shown');
}

class CodeHint {
  final ButtonElement button;
  final DivElement popup;
  StreamSubscription _onClickOnAnythingListener;

  CodeHint(this.button, this.popup);

  void listen() {
    button.onClick.listen(_onClick);
  }

  Future _onClick(MouseEvent event) async {
    popup.classes.toggle('shown');
    await new Future.delayed(const Duration(milliseconds: 1));
    if (popup.classes.contains('shown')) {
      _onClickOnAnythingListener = document.body.onClick.listen((e) {

        if (e.target != button && !_isPopupTarget(e.target)) {
          _onClick(e);
        }
      });
    } else {
      _onClickOnAnythingListener.cancel();
    }
  }

  bool _isPopupTarget(EventTarget target) {
    if (target is! Element) return false;
    final Element element = target;
    return popup.contains(element);
  }
}
