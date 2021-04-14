
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/extensions/optional.dart';
import 'package:wl_delivery/extensions/double_extension.dart';

class ProductListTile extends StatelessWidget {

  void Function() addAction;
  void Function() removeAction;
  final ProductCount productCount;
  ProductListTile({
    required this.productCount,
    required this.addAction,
    required this.removeAction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productCount.product.image.orEmpty),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(
                      productCount.product.title.orEmpty,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${productCount.product.price.toCurrency}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        // Spacer(),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.pink,
                            shape: StadiumBorder(),
                          ),
                          child: DefaultTextStyle(
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                button('-', removeAction),
                                SizedBox(
                                    width: 25,
                                    child: Text(
                                      productCount.count.toString(),
                                      textAlign: TextAlign.center,
                                    )
                                ),
                                button('+', addAction),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(String text, void Function() action) {
    return TextButton(
      child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 24
          )
      ),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)
      ),
      onPressed: action,);
  }
}