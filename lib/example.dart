import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {

  /*In app you pass can pass test card number like :-
  4111111111111111  16number card digit
 here i'm using test secret key  $& publishableKey
 if you have any question than mail me guptahariom007@gmail.com
  */
  static String secret = 'sk_test_51IqZYXSIqwFPwXlm1sXeWFvMdNnXK8tzirMM2ZxVrwYPeNxGWmWFQ8tTEqLrnJhqmsS1kDLs99IzAzoVzVm0ShXs00GXfMMrov';

  TextEditingController cardNumberController = new TextEditingController();
  TextEditingController expYearController = new TextEditingController();
  TextEditingController expMonthController = new TextEditingController();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "pk_test_51IqZYXSIqwFPwXlmGelBcMl2LMyIea8gznBdSBwuc0RNALEZwdidnpL9m0Z1aRHl6LVYBh2uQ3xADeDHxST1JKpV00VyAN8aj5",
            merchantId: "Test",
            androidPayMode: 'test'
        )
    );
  }

  static Future<Map<String, dynamic>> createCharge(String tokenId) async {

    try {
      Map<String, dynamic> body = {
        'amount': '10000',
        'currency': 'INR',
        'source': tokenId,
        'description': 'My first try'
      };

      print(body);

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/charges'),
          body: body,
          headers: { 'Authorization': 'Bearer ${secret}','Content-Type': 'application/x-www-form-urlencoded'}
      );
      print(response.body);

      return jsonDecode(response.body);

    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            TextField(
              controller: expMonthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Expired Month'),
            ),
            TextField(
              controller: expYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Expired Year'),
            ),
            RaisedButton(
              child: Text('card'),
              onPressed: () {
                final CreditCard testCard =  CreditCard(
                    number: cardNumberController.text,
                    expMonth: int.parse(expMonthController.text),
                    expYear: int.parse(expYearController.text)
                );

                StripePayment.createTokenWithCard(testCard).then((token) {
                  print(token.tokenId);

                  createCharge(token.tokenId);
                });
              },)
          ],
        ),
      ),
    );
  }
}
