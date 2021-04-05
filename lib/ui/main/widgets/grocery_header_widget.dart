
import 'package:flutter/material.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/extensions/string_extension.dart';
import 'package:wl_delivery/extensions/optional.dart';

class GroceryHeaderWidget extends StatelessWidget {
  const GroceryHeaderWidget({
    Key? key,
    required this.grocery,
  }) : super(key: key);

  final GroceryCafe grocery;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(
                    grocery.image.orEmpty),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                              grocery.title.orEmpty,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Container(
                                decoration: ShapeDecoration(
                                  color: Colors.green,
                                  shape: StadiumBorder(),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Text(
                                    grocery.status
                                        .orEmpty
                                        .capitalize(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight
                                            .w600
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                                grocery.openTime
                                    .orEmpty
                            ),
                            Text(
                                'Delivery fee: ${grocery.deliveryPrice} \$'
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}