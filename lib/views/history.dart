import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pet_controller.dart';

class HistoryPage extends StatelessWidget {
  final PetController petController = Get.find<PetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Adoption History')),
      body: Obx(() {
        if (petController.adoptedPets.isEmpty) {
          return Center(
              child: Text(
            'No pets adopted yet.',
            style: Theme.of(context).textTheme.labelSmall!,
          ));
        }

        return ListView.builder(
          itemCount: petController.adoptedPets.length,
          itemBuilder: (context, index) {
            final pet = petController.adoptedPets[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(pet.imageUrl),
              ),
              title: Text(
                pet.name,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                  'Adopted at: ${DateTime.now()}'), // You can store an actual timestamp
            );
          },
        );
      }),
    );
  }
}
