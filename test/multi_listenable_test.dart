import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_listenable/multi_listenable.dart';

final value1 = ValueNotifier("");

final value2 = ValueNotifier("");

void main() {
  testWidgets("test MultiListenableBuilder", (tester) async {
    value1.value = "A";
    value2.value = "B";

    await tester.pumpWidget(const TestWidget());

    expect(find.text(value1.value), findsOneWidget);
    expect(find.text(value2.value), findsOneWidget);

    value1.value = "C";
    value2.value = "D";
    await tester.pump();

    expect(find.text(value1.value), findsOneWidget);
    expect(find.text(value2.value), findsOneWidget);

    value1.value = "E";
    value2.value = "D";
    await tester.pump();

    expect(find.text(value1.value), findsOneWidget);
    expect(find.text(value2.value), findsOneWidget);
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiListenableBuilder(
        listenables: [value1, value2],
        builder: (context) => Column(
          children: [
            Text(value1.value),
            Text(value2.value),
          ],
        ),
      ),
    );
  }
}
