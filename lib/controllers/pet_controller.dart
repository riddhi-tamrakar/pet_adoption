import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pet_model.dart';
import 'package:confetti/confetti.dart';

class PetController extends GetxController {
  var petList = <Pet>[].obs;
  var searchQuery = ''.obs;
  var filteredPets = <Pet>[].obs;
  var isAllPetsLoaded = false.obs;
  int _currentPage = 0;
  final int _perPage = 10;
  var adoptedPets = <Pet>[].obs; // Track adopted pets
  var confettiController = ConfettiController(duration: Duration(seconds: 1));

  @override
  void onInit() {
    super.onInit();
    loadPets();
  }

  Future<void> loadPets() async {
    petList.assignAll(Pet.samplePets());
    await loadAdoptedPets(); // Load adopted state from storage
    updateFilteredPets();
  }

  void updateFilteredPets() {
    List<Pet> pets = petList
        .where((pet) =>
            pet.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();

    // Implement pagination
    if (_currentPage * _perPage < pets.length) {
      int endIndex = (_currentPage + 1) * _perPage;
      endIndex = endIndex > pets.length ? pets.length : endIndex;
      filteredPets.assignAll(pets.sublist(0, endIndex));
      isAllPetsLoaded.value = endIndex == pets.length;
    }
  }

  void loadMorePets() {
    _currentPage++;
    updateFilteredPets();
  }

  Future<void> adoptPet(Pet pet) async {
    pet.isAdopted = true;
    petList.refresh();
    updateFilteredPets();
    confettiController.play();
    adoptedPets.insert(0, pet);
    // Save adopted state to storage
    await saveAdoptedPets();
  }

  bool isAdopted(Pet pet) {
    return pet.isAdopted;
  }

  Future<void> saveAdoptedPets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> adoptedPetIds = petList
        .where((pet) => pet.isAdopted)
        .map((pet) => pet.id.toString())
        .toList();
    await prefs.setStringList('adoptedPets', adoptedPetIds);
  }

  Future<void> loadAdoptedPets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? adoptedPetIds = prefs.getStringList('adoptedPets');
    if (adoptedPetIds != null) {
      for (var pet in petList) {
        if (adoptedPetIds.contains(pet.id.toString())) {
          pet.isAdopted = true;
        }
      }
    }
  }
}
