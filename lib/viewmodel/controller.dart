import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  bool ischeckbox1Enabled = false;
  bool ischeckbox2Enabled = false;
  bool ischeckbox3Enabled = false;
  bool ischeckbox4Enabled = false;
  bool termsAndCondition = false;
  bool isSecure = true;

  ischeckboxClicked(value, index) {
    if (index == 0) {
      ischeckbox1Enabled = value;
    } else if (index == 1) {
      ischeckbox2Enabled = value;
    } else if (index == 2) {
      ischeckbox3Enabled = value;
    } else if (index == 3) {
      ischeckbox4Enabled = value;
    } else if (index == 4) {
      termsAndCondition = value;
    }

    notifyListeners();
  }

  isSecuree() {
    isSecure = !isSecure;
    notifyListeners();
  }

  int quantity = 0;
  bool isAddIconPressed = false;
  bool isRemoveIconPressed = false;
  int totalprice = 0000;
  void incrementCounter(
    maxQuantity,
    price,
  ) {
    if (maxQuantity > quantity) {
      quantity++;
    }

    isAddIconPressed = true;
    isRemoveIconPressed = false;
    totalprice = (price * quantity);
    print(totalprice);
    notifyListeners();
  }

  void decrementCounter(
    int price,
  ) {
    if (quantity > 0) {
      quantity--;
      isAddIconPressed = false;
      isRemoveIconPressed = true;
      // if(totalprice <0){
      totalprice = (totalprice - price);

      // }

      notifyListeners();
    }
  }

  clearData() {
    totalprice = 0;
    quantity = 0;
    notifyListeners();
  }
}
