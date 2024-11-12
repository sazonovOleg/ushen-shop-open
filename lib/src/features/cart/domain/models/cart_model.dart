class CartModel {
  CartModel({
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
    required this.indexEl,
    required this.wholePack,
  });

  final String name;
  final int weight;
  final int price;
  final String image;
  final int indexEl;
  final bool wholePack;

  CartModel.empty()
      : name = '',
        weight = 0,
        price = 0,
        image = '',
        indexEl = 0,
        wholePack = false;
}
