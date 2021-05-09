import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants.dart';
import '../../models/tabs.dart';
import '../../services/validation.dart';
import '../../widgets/clayContainerHighlight.dart';
import '../../widgets/inputTextFields.dart';
import '../../widgets/submitBtn.dart';
import '../details.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  late Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  bool isFinancialAidAvailable = false;
  final Slots = [
    'Upto ₹ 2.5 lakhs',
    '₹ 2.5 - ₹ 5 lakhs',
    '₹ 5 - ₹ 10 lakhs',
    'Greater than ₹ 10 lakhs'
  ];

  final interview = ['Yes', 'No'];
  var selectedSlot;
  var selectedInterview;

  @override
  void initState() {
    super.initState();

    selectedSlot = Slots[0];
    selectedInterview = interview[0];

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_suOCdVWC1AOACo",
      "amount": num.parse(textEditingController.text.substring(10)) * 100,
      "name": "EdMissions",
      "description": "One-Time Payment for Common Admission Form.",
      "prefill": {"contact": "9576983316", "email": "support@edmissions.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    kShowSnackBar(context, "Payment successful!", true);
  }

  void handlerErrorFailure() {
    print("Pament error");
    kShowSnackBar(context, "Payment unsuccessful!", false);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    kShowSnackBar(context, "Opening External Wallet", true);
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = 'Total : ₹ 1500';
    return Stack(
      alignment:
          isFinancialAidAvailable ? Alignment.bottomCenter : Alignment.topLeft,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 100),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    !isFinancialAidAvailable
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(right: 20),
                            child: ClayContainerHighlight(
                              iconData: CupertinoIcons.arrow_left,
                              onTap: () {
                                setState(() {
                                  isFinancialAidAvailable = false;
                                  Provider.of<TabViews>(context, listen: false)
                                      .setBottomNavigationBar(true);
                                });
                              },
                            ),
                          ),
                    Text(
                      'Payment',
                      style: kHeading1,
                    ),
                    Spacer(),
                    ClayContainer(
                        color: Colors.red,
                        parentColor: Color(0xffF2F7FC),
                        depth: 2,
                        width: 100,
                        height: 40,
                        borderRadius: 15,
                        child: Center(
                          child: Text(
                            "Pending",
                            style: kHeading3.copyWith(color: Colors.white),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(CupertinoIcons.arrow_up_doc_fill,
                          color: Colors.green.shade300),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Common Admission Form Fee',
                      style: kHeading4.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    InputTextField(
                      isDisabled: true,
                      isPasswordField: true,
                      validator: (value) => Validator.validateName(
                          name: textEditingController.text),
                      color: Color(0xffF2F7FC),
                      textEditingController: textEditingController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.amber,
                            value: isFinancialAidAvailable,
                            onChanged: (value) {
                              setState(() {
                                isFinancialAidAvailable = value!;
                                Provider.of<TabViews>(context, listen: false)
                                    .setBottomNavigationBar(
                                        !isFinancialAidAvailable);
                              });
                            }),
                        Text(
                          'Request Financial aid',
                          style: kHeading4,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isFinancialAidAvailable
                        ? Column(
                            children: [
                              TextFormField(
                                maxLines: 5,
                                style: TextStyle(
                                    color: Color(0xff6683AB),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal),
                                cursorRadius: Radius.circular(4),
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(),
                                    hintText:
                                        'Please help us understand in atleast 100 words.',
                                    labelStyle: TextStyle(
                                        color: Colors.amber.shade800,
                                        fontSize: 16),
                                    hintStyle: kHeading4,
                                    labelText:
                                        'Why did you opt for Financial Aid* '),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InformationTile(
                                  content: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: Slots.length,
                                      itemBuilder: (context, index) {
                                        return RadioListTile(
                                          dense: true,
                                          activeColor: Colors.green,
                                          title: Text(
                                            Slots[index].toString(),
                                            style: kHeading4,
                                          ),
                                          value: Slots[index],
                                          groupValue: selectedSlot,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedSlot = value;
                                            });
                                          },
                                        );
                                      }),
                                  title: 'Select annual family income',
                                  isExpanded: true),
                              SizedBox(
                                height: 20,
                              ),
                              InformationTile(
                                  content: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: interview.length,
                                      itemBuilder: (context, index) {
                                        return RadioListTile(
                                          dense: true,
                                          activeColor: Colors.green,
                                          title: Text(
                                            interview[index].toString(),
                                            style: kHeading4,
                                          ),
                                          value: interview[index],
                                          groupValue: selectedInterview,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedInterview = value;
                                            });
                                          },
                                        );
                                      }),
                                  title: 'Are you ready for an interview?',
                                  isExpanded: false),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          )
                        : SubmitButton(
                            text: 'Checkout',
                            onTap: () {
                              openCheckout();
                            }),
                  ],
                )
              ],
            ),
          ),
        ),
        isFinancialAidAvailable
            ? Container(
                padding: EdgeInsets.all(20),
                child: SubmitButton(
                    pColor: Colors.green, text: 'Submit Request', onTap: () {}))
            : Container()
      ],
    );
  }
}
