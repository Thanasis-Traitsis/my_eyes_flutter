import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/data/services/notification_service.dart';

void main() {
  group('NotificationService — onTap stream', () {
    late NotificationService service;

    setUp(() => service = NotificationService());

    test(
      'onTap is a broadcast stream — supports multiple simultaneous listeners',
      () {
        final sub1 = service.onTap.listen((_) {});
        final sub2 = service.onTap.listen((_) {});

        expect(sub1, isNotNull);
        expect(sub2, isNotNull);

        sub1.cancel();
        sub2.cancel();
      },
    );

    test(
      'dispose() closes the stream — onDone fires on active listeners',
      () async {
        final doneCompleter = Completer<void>();

        service.onTap.listen((_) {}, onDone: doneCompleter.complete);

        await service.dispose();

        await expectLater(
          doneCompleter.future.timeout(const Duration(seconds: 1)),
          completes,
        );
      },
    );

    test('onTap stream isBroadcast property is true', () {
      expect(service.onTap.isBroadcast, isTrue);
    });
  });
}
