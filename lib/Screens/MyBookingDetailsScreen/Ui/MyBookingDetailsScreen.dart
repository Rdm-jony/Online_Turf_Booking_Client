import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/GoogleMapScreen/Ui/GoogleMapScreen.dart';
import 'package:playspot_client/Screens/MyBookingDetailsScreen/bloc/my_booking_details_bloc.dart';

class MyBookingDetailsScreen extends StatelessWidget {
  MyBookingDetailsBloc myBookingDetailsBloc = MyBookingDetailsBloc();
  final bookingDetails;

  MyBookingDetailsScreen({super.key, required this.bookingDetails});
  List bookingDetailsOfPayment = [
    'Customer Name',
    "Email",
    "Event Name",
    "Booking Date",
    "Time Slot",
    "Payment Id",
    "Total Price"
  ];
  final List<String> ratings = ['1', '2', "3", "4"];
  var selectedRating;
  TextEditingController? feedBackController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List paymentDetails = [
      bookingDetails.customerName,
      bookingDetails.email,
      bookingDetails.eventName,
      bookingDetails.date,
      bookingDetails.slot,
      bookingDetails.trxId,
      bookingDetails.totalPrice
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextWidget(
          text: bookingDetails.turfName.toString().toUpperCase(),
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: 200,
              child: Image.network(
                bookingDetails.turfLogo,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextWidget(
              text: bookingDetails.turfName,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: screenWidth * 0.8,
              child: TextWidget(
                  textAlign: TextAlign.center, text: bookingDetails.address),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: screenWidth,
              height: 300,
              child: GoogleMapScreen(location: bookingDetails.location),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: screenWidth,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 1), color: Colors.green),
              child: Center(
                child: TextWidget(
                  text: "Booking Details",
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: screenWidth,
              height: 300,
              child: ListView.builder(
                itemCount: bookingDetailsOfPayment.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: screenWidth,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth * 0.4,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border:
                                  Border.all(width: 1, color: Colors.white)),
                          child: Center(
                            child: TextWidget(
                              text: bookingDetailsOfPayment[index],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.6,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border:
                                  Border.all(width: 1, color: Colors.white)),
                          child: Center(
                              child: TextWidget(
                            text: paymentDetails[index],
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: feedBackController,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Feedback is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("Feedback"),
                          border: OutlineInputBorder()),
                    ),
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                      onRatingUpdate: (rating) {
                        selectedRating = rating;
                      },
                    ),
                    SizedBox(
                        width: 100,
                        height: 30,
                        child: ButtonWidget(
                            callback: () {
                              submitFeedBack();
                            },
                            text: "Add"))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void submitFeedBack() {
    var isValid = _key.currentState?.validate();

    if (isValid == true) {
      String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
      var email = FirebaseAuth.instance.currentUser?.email;
      var name = FirebaseAuth.instance.currentUser?.displayName;
      var reviewInfo = {
        "email": email,
        "name": name,
        "feedback": feedBackController?.text.toString(),
        "date": date,
        "rating": selectedRating,
        "turfId": bookingDetails.turfId
      };
      myBookingDetailsBloc.add(SendFeedbackToDbEvent(reviewInfo: reviewInfo));
    }
  }
}
