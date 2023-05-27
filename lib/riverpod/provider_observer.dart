import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    /**
     * Provider의 상태가 업데이트 됐을 때 실행
     */
    print(
        '[Provider Updated] provider: $provider / pv: $previousValue / nv: $newValue');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    /**
     * Provider가 추가 됐을 때 실행
     */
    print(
        '[Provider added] provider: $provider / value: $value');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer containers) {
    /**
     * Provider가 삭제 됐을 때 실행
     */
    print(
        '[Provider Disposed] provider: $provider');
  }
}
