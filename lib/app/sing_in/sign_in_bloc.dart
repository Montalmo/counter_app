import 'dart:async';

class SignInBlock {
  final StreamController<bool> _isLoadingComtroller = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingComtroller.stream;

  void dispose() {
    _isLoadingComtroller.close();
  }

  void setIsLoading(bool isLoading) => _isLoadingComtroller.add(isLoading);
}
