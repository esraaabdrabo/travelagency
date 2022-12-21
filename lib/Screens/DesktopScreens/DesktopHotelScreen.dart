import 'dart:developer';
import 'dart:html';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Controller/RoomController.dart';
import 'package:travelagency/Helper/my_theme.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/models/hotels.dart';
import 'package:travelagency/services/Hotels.dart';
import 'package:travelagency/view_model/hotels.dart';
import "package:http/http.dart" as http;
import '../../Helper/Colors.dart';
import '../Widgets/Drawer.dart';
import '../Widgets/RoomWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesktopHotelScreen extends StatefulWidget {
  const DesktopHotelScreen({Key? key}) : super(key: key);

  @override
  State<DesktopHotelScreen> createState() => _desktopHotelScreenState();
}

class _desktopHotelScreenState extends State<DesktopHotelScreen> {
  final roomController = Get.put(RoomController());
  ////*************************************************************** */
  sendImg() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    var bytes = await image!.readAsBytes();

    showDialog(context: context, builder: (context) => Image.memory(bytes));

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://srv544.hstgr.io:7443/dbc194fb6745eb09/files/PassportImage/"));
    request.files.add(http.MultipartFile.fromBytes("picture", bytes));
    log("start");
    var res = await request.send();
    log(res.statusCode.toString());
  }
  ////*************************************************************** */

  final formKey1 = GlobalKey<FormState>();
  PageController pageCont = PageController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkoutDateController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameCont.dispose();
    phoneCont.dispose();
    emailCont.dispose();
    checkInDateController.dispose();
    checkoutDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;
    var wedth = MediaQuery.of(context).size.width; //1536
    var heght = MediaQuery.of(context).size.height;
    List<Widget> roomWidgets = List.generate(
        roomController.RoomCount.value.toInt(),
        (index) => RoomWidget(
              roomindex: index + 1,
              heght: heght,
              wedth: wedth,
            ));

    return ChangeNotifierProvider(
        create: (context) => HotelsVM(),
        builder: (context, child) {
          HotelsVM hotelsProvider = Provider.of(context);
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: hotelsProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //left draw
                      const Expanded(flex: 1, child: CustomDrawer()),
                      Expanded(
                        flex: 4,
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomWidgets.sizedbox15h,
                            Text("HOTEL", style: red36lato),

                            hotelList(heght, wedth, hotelsProvider,
                                translate: translate,
                                pageCont: pageCont,
                                formKey1: formKey1,
                                nameCont: nameCont,
                                phoneCont: phoneCont,
                                emailCont: emailCont,
                                fromDateCont: checkInDateController,
                                toDateCont: checkoutDateController),
                            SizedBox(height: heght * 0.011),
                            sectionDivder,

                            //form fileds
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  //search with country
                                  countriesDropDown(hotelsProvider, wedth),
                                  SizedBox(height: heght * 0.003),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: wedth * 0.005),
                                        child: SizedBox(
                                          width: wedth * 0.19,
                                          height: 40,
                                          child: TextFormField(
                                              onChanged: (String keySearch) {},
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons
                                                            .account_circle_outlined,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: "Nationality")),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: wedth * 0.005),
                                        child: SizedBox(
                                          width: wedth * 0.19,
                                          height: 40,
                                          child: TextFormField(
                                              onChanged: (String keySearch) {},
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons.money_off,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: "Currency")),
                                        ),
                                      ),
                                      //from date
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: wedth * 0.005),
                                        child: SizedBox(
                                          width: wedth * 0.19,
                                          height: 40,
                                          child: TextFormField(
                                              controller: checkInDateController,
                                              onTap: () async {
                                                var date = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2030));
                                                checkInDateController.text =
                                                    date
                                                        .toString()
                                                        .substring(0, 10);
                                              },
                                              onChanged: (String keySearch) {},
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons.date_range,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: "Check In Date")),
                                        ),
                                      ),
                                      //to date
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: wedth * 0.005),
                                        child: SizedBox(
                                          width: wedth * 0.19,
                                          height: 40,
                                          child: TextFormField(
                                              onChanged: (String keySearch) {},
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons.date_range,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: "Check Out Date")),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: heght * 0.02),
                            //room1 room2
                            SizedBox(
                              height: heght * 0.32,
                              child: SizedBox(
                                height: (heght * 0.075) *
                                    roomController.RoomCount.value.toDouble(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: heght * 0.006),
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: roomWidgets,
                                  ),
                                ),
                              ),
                            ),
                            //add room
                            Row(
                              children: [
                                SizedBox(
                                  width: 160,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors
                                          .pomegranateColor
                                          .withOpacity(0.8),
                                    ),
                                    onPressed: () {
                                      roomController.RoomCount.value =
                                          roomController.RoomCount.value + 1;
                                      setState(() {});
                                    },
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Add Room",
                                            style: GoogleFonts.lato(),
                                          ),
                                          const Icon(Icons.add)
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            CustomWidgets.sizedbox15h,
                            sectionDivder,
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}

var sectionDivder = const Divider(
  thickness: 3,
);
//*********hotel widget design*********** */ */
priceContainer(
    {required double width, required String price, required String roomType}) {
  return Container(
    width: width * .07,
    margin: EdgeInsets.only(right: width * .009),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(24, 61, 61, 61)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          roomType,
          style: black15lato,
        ),
        Text(
          price,
          style: black15lato,
        )
      ],
    ),
  );
}

hotelWidget(
    {required double width, required double height, required HotelM hotel}) {
  return Container(
      width: width * .5,
      height: height * .19,
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(10, 61, 61, 61),
      child: Row(
        children: [
          //hotel img
          SizedBox(
            width: width * .1,
            child: CustomWidgets.cachedImg(hotel.image!),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //name && country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      hotel.name!,
                      maxLines: 1,
                      style: black20LatoTS,
                    ),
                    Text(
                      hotel.locationEn!,
                      maxLines: 1,
                      style: black15lato,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    hotel.sngPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.sngPrice.toString(),
                            roomType: "SNG")
                        : const SizedBox(),
                    hotel.dblPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.dblPrice.toString(),
                            roomType: "DBL")
                        : const SizedBox(),
                    hotel.trplPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.trplPrice.toString(),
                            roomType: "TRP")
                        : const SizedBox(),
                    hotel.fmlyPrice != null
                        ? priceContainer(
                            width: width,
                            price: hotel.fmlyPrice.toString(),
                            roomType: "Fam")
                        : const SizedBox()
                  ],
                )
              ],
            ),
          )
        ],
      ));
}

hotelList(double heght, double wedth, HotelsVM hotelsProvider,
    {required AppLocalizations translate,
    required GlobalKey<FormState> formKey1,
    required TextEditingController nameCont,
    required TextEditingController phoneCont,
    required TextEditingController emailCont,
    required TextEditingController fromDateCont,
    required TextEditingController toDateCont,
    required PageController pageCont}) {
  return SizedBox(
    height: heght * .5,
    child: ListView.builder(
        itemCount: hotelsProvider.hotels.length,
        itemBuilder: (context, index) => hotelCard(
            pageCont: pageCont,
            width: wedth,
            context: context,
            height: heght,
            hotel: hotelsProvider.hotels[index],
            translate: translate,
            formKey1: formKey1,
            nameCont: nameCont,
            phoneCont: phoneCont,
            emailCont: emailCont,
            fromDateCont: fromDateCont,
            toDateCont: toDateCont,
            hotelsProvider: hotelsProvider)),
  );
}

////////////text form field ////////////////////
///name
fullNameTf({
  required TextEditingController nameCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return //full name
      Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: TextFormField(
        controller: nameCont,
        validator: (value) {
          return hotelsProvider.validateName(value!, context);
        },
        keyboardType: TextInputType.name,
        minLines: null,
        style: const TextStyle(fontSize: 16.0),
        decoration: MyThemeData.inputDhintPre(
            icon: const Icon(
              Icons.person,
              color: Colors.grey,
              size: 20,
            ),
            label: translate.fullName)),
  );
}

//phone
phoneTF({
  required TextEditingController phoneCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: TextFormField(
        validator: (value) {
          return hotelsProvider.validatePhone(value!, context);
        },
        controller: phoneCont,
        keyboardType: TextInputType.number,
        minLines: null,
        style: const TextStyle(fontSize: 16.0),
        decoration: MyThemeData.inputDhintPre(
            icon: const Icon(
              Icons.phone_android,
              color: Colors.grey,
              size: 20,
            ),
            label: translate.phoneNumber)),
  );
}

//email
emailTF({
  required TextEditingController emailCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: TextFormField(
        validator: (value) {
          return hotelsProvider.validateEmail(value!, context);
        },
        controller: emailCont,
        keyboardType: TextInputType.emailAddress,
        minLines: null,
        onChanged: (value) {},
        style: const TextStyle(fontSize: 16.0),
        decoration: MyThemeData.inputDhintPre(
            icon: const Icon(
              Icons.email,
              color: Colors.grey,
              size: 20,
            ),
            label: translate.email)),
  );
}

//from date
fromDateTF({
  required TextEditingController fromDateCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: SizedBox(
      height: 40,
      child: TextFormField(
          controller: fromDateCont,
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030));
            fromDateCont.text = date.toString().substring(0, 10);
          },
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.date_range,
                color: Colors.grey,
                size: 20,
              ),
              label: translate.checkInDate)),
    ),
  );
}

//to date
toDateTF({
  required TextEditingController toDateCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return Padding(
    padding: EdgeInsets.only(right: width * 0.005, bottom: height * 0.025),
    child: SizedBox(
      height: 40,
      child: TextFormField(
          controller: toDateCont,
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030));
            toDateCont.text = date.toString().substring(0, 10);
            log(toDateCont.text);
          },
          style: const TextStyle(fontSize: 16.0),
          decoration: MyThemeData.inputDhintPre(
              icon: const Icon(
                Icons.date_range,
                color: Colors.grey,
                size: 20,
              ),
              label: translate.checkOutDate)),
    ),
  );
}

//go next
nextBtn({
  required HotelsVM hotelsProvider,
  required double width,
  required PageController pageCont,
  required double height,
  required GlobalKey<FormState> formKey1,
}) {
  return MaterialButton(
      onPressed: () {
        if (formKey1.currentState!.validate()) {
          pageCont.nextPage(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic);
        }
      },
      minWidth: width * .2,
      padding: EdgeInsets.symmetric(
        vertical: height * .03,
      ),
      color: AppColors.pomegranateColor,
      child: Text(
        "Next",
        style: white15lato,
      ));
}

hotelCard(
    {required double width,
    required BuildContext context,
    required double height,
    required HotelM hotel,
    required AppLocalizations translate,
    required GlobalKey<FormState> formKey1,
    required TextEditingController nameCont,
    required TextEditingController phoneCont,
    required TextEditingController emailCont,
    required TextEditingController fromDateCont,
    required TextEditingController toDateCont,
    required HotelsVM hotelsProvider,
    required PageController pageCont}) {
  return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //hotel img
                Expanded(
                  flex: 3,
                  child: CustomWidgets.cachedImg(hotel.image!),
                ),
                //form
                Expanded(
                  child: Form(
                    key: formKey1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        //form
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              //hotel name
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 20),
                                child: Text(
                                    "${translate.welcomeIn} ${hotel.name!}",
                                    textAlign: TextAlign.center,
                                    style: black20LatoWShadow),
                              ),

                              SizedBox(
                                height: height * .8,
                                child: PageView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageCont,
                                  children: [
                                    //name num email from date to date
                                    Column(
                                      children: [
                                        fullNameTf(
                                            nameCont: nameCont,
                                            hotelsProvider: hotelsProvider,
                                            width: width,
                                            height: height,
                                            context: context,
                                            translate: translate), //phone num
                                        phoneTF(
                                            phoneCont: phoneCont,
                                            hotelsProvider: hotelsProvider,
                                            width: width,
                                            height: height,
                                            context: context,
                                            translate: translate),
                                        emailTF(
                                            emailCont: emailCont,
                                            hotelsProvider: hotelsProvider,
                                            width: width,
                                            height: height,
                                            context: context,
                                            translate: translate), //from date
                                        fromDateTF(
                                            fromDateCont: fromDateCont,
                                            hotelsProvider: hotelsProvider,
                                            width: width,
                                            height: height,
                                            context: context,
                                            translate: translate), //to date
                                        toDateTF(
                                            toDateCont: toDateCont,
                                            hotelsProvider: hotelsProvider,
                                            width: width,
                                            height: height,
                                            context: context,
                                            translate: translate),
                                        nextBtn(
                                            hotelsProvider: hotelsProvider,
                                            width: width,
                                            pageCont: pageCont,
                                            height: height,
                                            formKey1: formKey1)
                                      ],
                                    ),
                                    //passport img , adult num ,child num ,room num ,room type, book btn
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            XFile? image = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            var t = await image!.readAsBytes();

                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    Image.memory(t));
                                            var request = http.MultipartRequest(
                                                'POST',
                                                Uri.parse(
                                                    "https://srv544.hstgr.io:7443/dbc194fb6745eb09/files/PassportImage/"));
                                            request.files.add(
                                                http.MultipartFile.fromBytes(
                                                    "picture", t));
                                            log("start");
                                            var res = await request.send();
                                            log(res.statusCode.toString());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 9, horizontal: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: AppColors.grayColor
                                                        .withOpacity(.5)),
                                                color: AppColors.offWhiteColor
                                                    .withOpacity(.8)),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.upload,
                                                    color: Color.fromARGB(
                                                        170, 61, 61, 61)),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  translate.passportImage,
                                                  style: black15lato.copyWith(
                                                      color:
                                                          const Color.fromARGB(
                                                              200, 61, 61, 61)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        CustomWidgets.sizedbox15h,
                                        //adult num

                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: width * 0.005,
                                              bottom: height * 0.025),
                                          child: TextFormField(
                                              controller: nameCont,
                                              validator: (value) {
                                                return hotelsProvider
                                                    .validateName(
                                                        value!, context);
                                              },
                                              keyboardType: TextInputType.name,
                                              minLines: null,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons.man,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: // translate.fullName
                                                          "adult num")),
                                        ),
                                        //child num

                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: width * 0.005,
                                              bottom: height * 0.025),
                                          child: TextFormField(
                                              controller: nameCont,
                                              validator: (value) {
                                                return hotelsProvider
                                                    .validateName(
                                                        value!, context);
                                              },
                                              keyboardType: TextInputType.name,
                                              minLines: null,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons.boy,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: // translate.fullName
                                                          "child num")),
                                        ),
//room num
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: width * 0.005,
                                              bottom: height * 0.025),
                                          child: TextFormField(
                                              controller: nameCont,
                                              validator: (value) {
                                                return hotelsProvider
                                                    .validateName(
                                                        value!, context);
                                              },
                                              keyboardType: TextInputType.name,
                                              minLines: null,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                              decoration:
                                                  MyThemeData.inputDhintPre(
                                                      icon: const Icon(
                                                        Icons
                                                            .house_siding_rounded,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      label: // translate.fullName
                                                          "room num")),
                                        ),

                                        MaterialButton(
                                            onPressed: () {
                                              if (formKey1.currentState!
                                                  .validate()) {
                                                print("valid");
                                              }
                                            },
                                            minWidth: width * .2,
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * .03,
                                            ),
                                            color: AppColors.pomegranateColor,
                                            child: Text(
                                              "Save",
                                              style: white15lato,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),

                        //exit btn
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.cancel),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      child: hotelWidget(width: width, height: height, hotel: hotel));
}

////////////////search with country//////////////////////
countriesDropDown(HotelsVM hotelsProvider, double wedth) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: DropdownButton(
        isExpanded: true,
        value: hotelsProvider.selectedCountry,
        items: List.generate(hotelsProvider.countries.length, (index) {
          return DropdownMenuItem(
              value: hotelsProvider.countries[index],
              child: Text(
                hotelsProvider.countries[index],
                style: black15lato,
              ));
        }),
        onChanged: (country) {
          hotelsProvider.changeSelectedCountry(country.toString());
        }),
  );
}
