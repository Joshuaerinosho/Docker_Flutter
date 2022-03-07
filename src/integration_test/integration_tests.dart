import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/widget_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Tests', () {
    WidgetController.hitTestWarningShouldBeFatal = true;

    testWidgets('Sign Up Page', (tester) => counterSmokeTest(tester));
  });
}
