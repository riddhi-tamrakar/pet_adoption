import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:pet_adoption/utils/colors.dart';
import '../controllers/pet_controller.dart';
import '../models/pet_model.dart';

class PetDetails extends StatelessWidget {
  final Pet pet = Get.arguments as Pet; // Retrieve the Pet object
  final PetController petController = Get.find<PetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(title: Text(pet.name)),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: Hero(
                tag: 'pet_${pet.name}',
                child: Image.network(pet.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Name: ${pet.name}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Theme.of(context).primaryColor)),
                Text(
                  'Age: ${pet.age}',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.black),
                ),
                Text('Price: \$${pet.price}',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.black)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pet.isAdopted ? null : () => _adoptPet(context),
                  child: Text(pet.isAdopted ? 'Adopted' : 'Adopt Me'),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: petController.confettiController,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ],
      ),
    );
  }

  void _adoptPet(BuildContext context) {
    petController.adoptPet(pet);
    Get.snackbar(pet.name, "You’ve adopted ${pet.name}");
    Navigator.pop(context);
  }
}
