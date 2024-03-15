import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Products_on_the_cart[index]["name"],
            cart_prod_picture: Products_on_the_cart[index]["picture"],
            cart_prod_old_price: Products_on_the_cart[index]["old_price"],
            cart_prod_price: Products_on_the_cart[index]["price"],
            cart_prod_size: Products_on_the_cart[index]["size"],
            cart_prod_color: Products_on_the_cart[index]["color"],
            cart_prod_qty: Products_on_the_cart[index]["quantity"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_old_price;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_old_price,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cart_prod_picture,
          width: 80,
          height: 80,
        ),
        title: Text(
          cart_prod_name,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Column(
          children: <Widget>[
//            ====Product price section start====
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$${cart_prod_price}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
//            ====Product price and Size start====
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(cart_prod_size),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(cart_prod_color),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          children: <Widget>[
            IconButton(icon: const Icon(Icons.arrow_drop_up), onPressed: () {}),
            Text(cart_prod_qty),
            IconButton(
                icon: const Icon(Icons.arrow_drop_down), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
