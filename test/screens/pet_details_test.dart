import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/controllers/pet_controller.dart';
import 'package:pet_adoption/models/pet_model.dart';
import 'package:pet_adoption/views/pet_details.dart';
import 'package:mockito/mockito.dart';

class MockPetController extends Mock implements PetController {}

void main() {
  late MockPetController mockPetController;
  late Pet pet;

  setUp(() {
    // Initialize the mock controller
    mockPetController = MockPetController();

    // Create a sample pet object
    pet = Pet(
      id: 1,
      name: 'Bella',
      age: "2",
      price: 100,
      imageUrl: 'https://example.com/image.jpg',
      isAdopted: false,
    );

    // Mocking petController's behavior
    when(mockPetController.confettiController).thenReturn(ConfettiController());
  });

  testWidgets('Pet details are displayed correctly',
      (WidgetTester tester) async {
    // Provide the Pet to PetDetails screen using Get.arguments
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/petDetails',
      getPages: [
        GetPage(
          name: '/petDetails',
          page: () => PetDetails(),
        ),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(mockPetController); // Inject the mock controller
      }),
    ));

    // Push the PetDetails screen with the pet as argument
    Get.toNamed('/petDetails', arguments: pet);

    // Wait for the widget to build
    await tester.pumpAndSettle();

    // Check if the pet details are displayed
    expect(find.text('Name: Bella'), findsOneWidget);
    expect(find.text('Age: 2'), findsOneWidget);
    expect(find.text('Price: \$100'), findsOneWidget);
    expect(find.byType(Hero),
        findsOneWidget); // Hero animation widget should be present
  });

  testWidgets('Adopt Me button becomes disabled after adoption',
      (WidgetTester tester) async {
    // Provide the Pet to PetDetails screen using Get.arguments
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/petDetails',
      getPages: [
        GetPage(
          name: '/petDetails',
          page: () => PetDetails(),
        ),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(mockPetController); // Inject the mock controller
      }),
    ));

      // Push the PetDetails screen with the pet as argument
      Get.toNamed('/petDetails', arguments: pet);

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Initially, the pet should not be adopted, so the button should be enabled
      expect(find.text('Adopt Me'), findsOneWidget);

      // Simulate tapping the "Adopt Me" button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify the pet is adopted (button text should change to "Adopted")
      expect(find.text('Adopted'), findsOneWidget);
      expect(pet.isAdopted, true); // Check if the pet's adoption status is updated
    });

  
      
}
