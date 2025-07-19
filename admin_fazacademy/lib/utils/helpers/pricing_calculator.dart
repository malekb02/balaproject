


class AppPricingCalculator {

  static double calculatTotalPrice (double productPrice,String location){
    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + shippingCost;

    return totalPrice;
  }

  static double getShippingCost(String location){
    return 200.00;
  }
}