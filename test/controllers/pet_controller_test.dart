import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pet_adoption/controllers/pet_controller.dart';
import 'package:pet_adoption/models/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
// Update this import

// Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late PetController petController;

  setUp(() async {
    // Initialize mock shared preferences
    mockSharedPreferences = MockSharedPreferences();
    final pet = Pet(
        id: 1,
        name: 'Buddy',
        age: "3",
        price: 50.0,
        imageUrl: '',
        isAdopted: false);

    // Mock the SharedPreferences setStringList method
    when(mockSharedPreferences.setStringList(
      'adoptedPets',
      [pet.id.toString()],
    )).thenAnswer((_) async => true); // Return true for any value

    // Mock the SharedPreferences getStringList method to return an empty list initially
    when(mockSharedPreferences.getStringList('adoptedPets')).thenReturn([]);

    // Initialize the PetController with mock SharedPreferences
    petController = PetController();
    petController.petList.assignAll(Pet.samplePets()); // Assign sample pets

    // Simulate that we are loading adopted pets (mocking loadAdoptedPets)
    await petController.loadAdoptedPets();
  });

  test('Adopting a pet updates adoption state', () async {
    final pet = petController.petList.first; // First pet from the list

    // Ensure the pet is not adopted initially
    expect(pet.isAdopted, false);

    // Adopt the pet
    await petController.adoptPet(pet);

    // Check if the pet is adopted
    expect(pet.isAdopted, true);

    // Ensure the adopted pet appears in adoptedPets list
    expect(petController.adoptedPets.contains(pet), true);

    // Verify SharedPreferences is called to save adopted pets
    verify(mockSharedPreferences.setStringList(
      'adoptedPets',
      [pet.id.toString()],
    )).called(1); // Ensure this method was called once
  });

  test('Load adopted pets correctly', () async {
    // Simulate the adoption of a pet
    final pet = petController.petList.first;
    await petController.adoptPet(pet);
    // Reload the adopted pets from SharedPreferences
    await petController.loadAdoptedPets();

    // Verify the adopted pet is correctly loaded from storage
    expect(pet.isAdopted, true);
  });
}
