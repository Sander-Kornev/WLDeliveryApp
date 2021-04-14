// Settings Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wl_delivery/ui/cart/checkout/checkout_state.dart';
import 'package:wl_delivery/extensions/optional.dart';

import 'checkout_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SignupForm(
            // formKey: _formKey,
            key: Key("value"),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CheckoutCubit cubit = BlocProvider.of(context);
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButtonTheme(
          data: ElevatedButtonThemeData(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(10, 50)))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Where to?'),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                      offset:
                          Offset(0.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BlocBuilder<CheckoutCubit, CheckoutState>(
                        builder: (context, state) {
                      String? addressErr = state.addressValidationError;
                      String? phoneErr = state.phoneValidationError;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Address',
                                errorText: addressErr),
                            keyboardType: TextInputType.streetAddress,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: cubit.setAddress,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Entrance'),
                                  keyboardType: TextInputType.streetAddress,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  onChanged: cubit.setEntrance,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Floor'),
                                  keyboardType: TextInputType.streetAddress,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  onChanged: cubit.setFloor,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Apt'),
                                  keyboardType: TextInputType.streetAddress,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  onChanged: cubit.setApartment,
                                ),
                              ),
                            ]
                          ),
                          TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Phone number',
                                errorText: phoneErr),
                            keyboardType: TextInputType.phone,
                            onChanged: cubit.setPhoneNumber,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Payment'),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                      offset:
                      Offset(0.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocBuilder<CheckoutCubit, CheckoutState>(
                      builder: (context, state) {
                        String? addressErr = state.addressValidationError;
                        String? phoneErr = state.phoneValidationError;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total'),
                                Text(cubit.total.orEmpty),
                              ],
                            ),
                            Divider(),
                            CheckboxListTile(
                              title: Text("By card"),
                              value: cubit.byCard,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (_) => cubit.cardOptionSelected(),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              title: Text("By cash"),
                              value: cubit.byCash,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (_) => cubit.cashOptionSelected(),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            Divider(),
                            Text(cubit.paymentDescription),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                onPressed: cubit.checkoutAction,
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        )
    );
  }
}
