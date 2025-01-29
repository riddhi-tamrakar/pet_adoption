class Pet {
  final int id;
  final String name;
  final String age;
  final double price;
  final String imageUrl;
  bool isAdopted;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.imageUrl,
    this.isAdopted = false,
  });

  static List<Pet> samplePets() {
    return [
      Pet(
        id:1,
          name: 'Buddy',
          age: '2 years',
          price: 100,
          imageUrl: 'assets/images/pet1.jpg'),
      Pet(
         id:2,
          name: 'Bella',
          age: '1 year',
          price: 120,
          imageUrl: 'assets/images/pet2.jpg'),
      Pet(
         id:3,
          name: 'Charlie',
          age: '3 years',
          price: 90,
          imageUrl: 'assets/images/pet3.jpg'),
      Pet(
         id:4,
          name: 'Luna',
          age: '2 years',
          price: 110,
          imageUrl: 'assets/images/pet4.jpg'),
      Pet(
         id:5,
          name: 'Rocky',
          age: '4 years',
          price: 85,
          imageUrl: 'assets/images/pet1.jpg'),
      Pet(
         id:6,
          name: 'Milo',
          age: '5 months',
          price: 130,
          imageUrl: 'assets/images/pet2.jpg'),
      Pet(
         id:7,
          name: 'Daisy',
          age: '6 months',
          price: 95,
          imageUrl: 'assets/images/pet3.jpg'),
      Pet(
         id:8,
          name: 'Lucy',
          age: '1.5 years',
          price: 105,
          imageUrl: 'assets/images/pet4.jpg'),
      Pet(
         id:9,
          name: 'Max',
          age: '2.5 years',
          price: 115,
          imageUrl: 'assets/images/pet1.jpg'),
      Pet(
         id:10,
          name: 'Cooper',
          age: '3.5 years',
          price: 90,
          imageUrl: 'assets/images/pet2.jpg'),
      Pet(
         id:11,
          name: 'Zoe',
          age: '7 months',
          price: 100,
          imageUrl: 'assets/images/pet3.jpg'),
      Pet(
         id:12,
          name: 'Oscar',
          age: '1 year',
          price: 125,
          imageUrl: 'assets/images/pet4.jpg'),
      Pet(
         id:13,
          name: 'Toby',
          age: '8 months',
          price: 110,
          imageUrl: 'assets/images/pet1.jpg'),
      Pet(
         id:14,
          name: 'Maggie',
          age: '2 years',
          price: 115,
          imageUrl: 'assets/images/pet2.jpg'),
      Pet(
         id:15,
          name: 'Chloe',
          age: '3 months',
          price: 120,
          imageUrl: 'assets/images/pet3.jpg'),
    ];
  }
}
