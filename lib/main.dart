import 'package:flutter/material.dart';
import 'package:stripecardpayment/example.dart';

void main() {
  runApp(StripeCardPaymentExample());
}

class StripeCardPaymentExample extends StatefulWidget {
  @override
  _StripeCardPaymentExampleState createState() => _StripeCardPaymentExampleState();
}

class _StripeCardPaymentExampleState extends State<StripeCardPaymentExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe Card Payment',
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

