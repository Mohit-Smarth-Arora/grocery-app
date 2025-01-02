import "package:grocery/features/home/models/home_product_data_model.dart";
import "package:grocery/features/cart/ui/cart_page.dart";

Set<ProductDataModel> cartItems = {};

ProductDataModel? getProductById(String id) {
  return cartItems.firstWhere((p) => p.id == id, orElse: () => ProductDataModel());
}

void addProductToCart(ProductDataModel product) {
  ProductDataModel? existingProduct = getProductById(product.id ?? '');
  if (existingProduct?.id != null) {
    existingProduct?.incrementQuantity();
  } else {
    cartItems.add(product);
  }
}


void removeProductFromCart(ProductDataModel product) {
  ProductDataModel? existingProduct = getProductById(product.id ?? '');
  if (existingProduct?.id != null) {
    existingProduct?.decrementQuantity();


    if(existingProduct?.getQuantity() == 0){
      cartItems.remove(product);

    }


  }
}


void setProductQuantity(String id, int quantity) {
  ProductDataModel? product = getProductById(id);
  if (product?.id != null) {
    product?.setQuantity(quantity);
  }
}

int? getProductQuantity(String id) {
  ProductDataModel? product = getProductById(id);
  if (product?.id != null) {
    return product?.getQuantity();
  }
  return null;
}


double total = 0.0;
void countTotal(Set<ProductDataModel> cartItems) {
  total = cartItems.fold(
      0,
          (previousValue, item) =>
      previousValue + (item.quantity ?? 0) * (item.price ?? 0));
  print('Total: $total');
  return ;
}

