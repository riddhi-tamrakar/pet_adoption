import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/pet_model.dart';
import '../utils/dynamic_height.dart';

class PetItemWidget extends StatelessWidget {
  final Pet pet;
  const PetItemWidget({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DynamicSize.height(context, 0.022),
          vertical: DynamicSize.height(context, 0.015)),
      child: Card(
          shadowColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(DynamicSize.height(context, 0.01)),
          ),
          elevation: 1,
          child: ListTile(
              leading: Container(
                height: DynamicSize.height(context, 0.22),
                width: DynamicSize.height(context, 0.12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(pet.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text(
                pet.name,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                '${pet.age} - \$${pet.price}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              trailing: pet.isAdopted
                  ? const Text('Adopted', style: TextStyle(color: Colors.grey))
                  : null,
              onTap: () => Get.toNamed('/petDetails', arguments: pet))),
    );
  }
}
