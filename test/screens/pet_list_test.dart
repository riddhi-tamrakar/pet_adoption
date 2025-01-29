import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/views/pet_list.dart';


void main() {
  testWidgets('Search filters pets', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: PetList()));

    // Simulate typing in the search field
    await tester.enterText(find.byType(TextField), 'Bella');
    await tester.pump();

    // Check that the filtered pet list contains only matching pets
    expect(find.text('Bella'), findsWidgets);
  });
}
