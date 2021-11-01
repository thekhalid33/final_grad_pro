import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class DeliveryTime extends StatefulWidget {
  @override
  _DeliveryTimeState createState() => _DeliveryTimeState();
}

class _DeliveryTimeState extends State<DeliveryTime> {
  // Delivery delivery = Delivery.StandardDelivery;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            ListTile(
              title: CustomText(
                text: 'Time of delivery',
                fontSize: 22,
              ),
              subtitle: CustomText(
                text:
                    'The products will be delivered at a time from one day to a week',
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              title: CustomText(
                text: 'Location of delivery',
                fontSize: 22,
              ),
              subtitle: CustomText(
                text:
                    'The products will be delivered to the adders that you will add in the next page',
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              title: CustomText(
                text: 'Payment for delivery',
                fontSize: 22,
              ),
              subtitle: CustomText(
                text:
                    'The payment must be done when the products arrive to its owner and at the same address that the products are order to',
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// SizedBox(height: 50),
// RadioListTile<Delivery>(
// value: Delivery.StandardDelivery,
// groupValue: delivery,
// onChanged: (Delivery value) {
// delivery = value;
// setState(() {});
// },
// title: CustomText(
// text: 'Standard Delivery',
// fontSize: 24,
// ),
// subtitle: CustomText(
// text: '\nOrder will be delivered between 3 - 5 business days',
// ),
// activeColor: primaryColor,
// ),
// SizedBox(height: 20),
// RadioListTile<Delivery>(
// value: Delivery.NextDayDelivery,
// groupValue: delivery,
// onChanged: (Delivery value) {
// delivery = value;
// setState(() {});
// },
// title: CustomText(
// text: 'Next Day Delivery',
// fontSize: 24,
// ),
// subtitle: CustomText(
// text:
// '\nPlace your order before 6pm and your items will be delivered the next day',
// ),
// activeColor: primaryColor,
// ),
// SizedBox(height: 20),
// RadioListTile<Delivery>(
// value: Delivery.NominatedDelivery,
// groupValue: delivery,
// onChanged: (Delivery value) {
// delivery = value;
// setState(() {});
// },
// title: CustomText(
// text: 'Nominated Delivery',
// fontSize: 24,
// ),
// subtitle: CustomText(
// text:
// '\nPick a particular date from the calendar and order will be delivered on selected date',
// ),
// activeColor: primaryColor,
// )
