import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Commissioner',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BankItem> banks = [
    BankItem(
      name: 'Santander Bank',
      logoPath: Constants.bankLogoPath,
      cardNumber: "**** 9228",
    ),
    BankItem(
      name: 'Santander Bank',
      logoPath: Constants.bankLogoPath,
      cardNumber: "**** 2991",
    ),
    BankItem(
      name: 'Santander Bank',
      logoPath: Constants.bankLogoPath,
      cardNumber: "**** 2997",
    ),
    BankItem(
      name: 'Santander Bank',
      logoPath: Constants.bankLogoPath,
      cardNumber: "**** 9811",
    ),
  ];

  int selectedBankIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Constants.menuBarText,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DelayedDisplay(
                      delay: Duration(milliseconds: 300),
                      child: WarningWidget(
                        warningText:
                            "Please select an  account that you only use for business.",
                      ),
                    ),
                    SizedBox(height: 16),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 600),
                      child: Divider(
                        height: 1,
                        color: Color(0xFFE0E0E0),
                        thickness: 1,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return DelayedDisplay(
                          delay: Duration(milliseconds: index * 300),
                          child: BankAccWidget(
                            onTap: () {
                              setState(() {
                                selectedBankIndex = index;
                              });
                            },
                            isSelected: selectedBankIndex == index,
                            bankItem: banks[index],
                          ),
                        );
                      },
                      itemCount: 4,
                      separatorBuilder: (BuildContext context, int index) {
                        return DelayedDisplay(
                          delay: Duration(milliseconds: index * 380),
                          child: Divider(
                            height: 1,
                            color: Color(0xFFE0E0E0),
                            thickness: 1,
                          ),
                        );
                      },
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 1000),
                      child: Divider(
                        height: 1,
                        color: Color(0xFFE0E0E0),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: 15),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 1300),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 72, vertical: 12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Constants.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Constants.primaryColor.withOpacity(.15),
                                  offset: Offset(0, 10),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: Text("Add an account",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Constants.primaryColorAccent.withOpacity(0.9),
                    Constants.primaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.6],
                )),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WarningWidget extends StatelessWidget {
  const WarningWidget({
    Key? key,
    required this.warningText,
  }) : super(key: key);
  final String warningText;

  @override
  Widget build(BuildContext context) {
    return DefaultPadding(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF18274B).withOpacity(0.12),
                offset: Offset(0, 14),
                blurRadius: 50,
                spreadRadius: -4,
              ),
              BoxShadow(
                color: Color(0xFF18274B).withOpacity(0.08),
                offset: Offset(0, 8),
                blurRadius: 15,
                spreadRadius: -6,
              ),
            ]),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(
                Constants.alertIconPath,
              ),
              size: 18,
              color: Colors.black,
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                warningText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BankAccWidget extends StatelessWidget {
  const BankAccWidget({
    Key? key,
    required this.isSelected,
    this.onTap,
    required this.bankItem,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback? onTap;
  final BankItem bankItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          child: Row(children: [
            CustomRadioButton(
              isSelected: isSelected,
            ),
            SizedBox(width: 33.0),
            ImageIcon(AssetImage(bankItem.logoPath),
                color: Colors.black, size: 20),
            SizedBox(width: 33.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bankItem.name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
                Text(bankItem.cardNumber,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class DefaultPadding extends StatelessWidget {
  const DefaultPadding({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: child,
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({Key? key, this.isSelected = false})
      : super(key: key);
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 7,
      backgroundColor: Constants.primaryColor,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: isSelected ? 3.3 : 5.5,
      ),
    );
  }
}

class BankItem {
  final String name;
  final String cardNumber;
  final String logoPath;

  BankItem(
      {required this.name, required this.cardNumber, required this.logoPath});
}
