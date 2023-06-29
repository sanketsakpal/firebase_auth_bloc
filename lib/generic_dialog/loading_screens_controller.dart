typedef ClosingLoadingScreen = bool Function();
typedef UpdateClosingLoadingScreen = bool Function(String text);

class LoadingScreenController {
  final ClosingLoadingScreen closeLoadingScreen;
  final UpdateClosingLoadingScreen updateClosingLoadingScreen;
  const LoadingScreenController({
    required this.closeLoadingScreen,
    required this.updateClosingLoadingScreen,
  });
}
