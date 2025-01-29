import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pet_controller.dart';
import '../widgets/pet_item_widget.dart';

class PetList extends StatelessWidget {
  final PetController petController = Get.put(PetController());
  final ScrollController _scrollController = ScrollController();

  PetList() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!petController.isAllPetsLoaded.value) {
          petController.loadMorePets();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Pet Adoption'), actions: [
        IconButton(
          icon: Icon(Icons.history),
          onPressed: () {
            Get.toNamed('/history');
          },
        ),
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                petController.searchQuery.value = value;
                petController.updateFilteredPets();
              },
              style: Theme.of(context).textTheme.labelSmall!,
              decoration: InputDecoration(
                labelText: 'Search Pet',
                labelStyle: Theme.of(context).textTheme.labelSmall!,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (petController.filteredPets.isEmpty) {
                return Center(child: Text('Pet not found'));
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: petController.filteredPets.length +
                    (petController.isAllPetsLoaded.value ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index == petController.filteredPets.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final pet = petController.filteredPets[index];
                  return Hero(
                    tag: 'pet_${pet.id}',
                    child: Opacity(
                      opacity:
                          pet.isAdopted ? 0.5 : 1.0, // Grey out adopted pets
                      child: PetItemWidget(pet: pet),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
