import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Controller/RoomController.dart';
import 'package:travelagency/Helper/my_theme.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/models/hotels.dart';
import 'package:travelagency/services/Hotels.dart';
import 'package:travelagency/view_model/hotels.dart';

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
                                  //location
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: wedth * 0.005,
                                        bottom: heght * 0.007),
                                    child: TextFormField(
                                        minLines: null,
                                        onChanged: (String keySearch) {},
                                        style: const TextStyle(fontSize: 16.0),
                                        decoration: MyThemeData.inputDhintPre(
                                            icon: const Icon(
                                              Icons.location_on,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            label: "Location")),
                                  ),
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
                            //search with country
                            countriesDropDown(hotelsProvider)
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
    child: GridView.builder(
        itemCount: hotelsProvider.hotels.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 380,
            mainAxisExtent: 250),
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

hotelPrice(String price, String num) {
  return Container(
    color: AppColors.whiteColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num,
          style: red15lato,
        ),
        const SizedBox(
          width: 3,
        ),
        const Icon(
          Icons.person,
          color: AppColors.pomegranateColor,
        ),
        CustomWidgets.sizedbox15w,
        Text(
          "$price \$",
          style: black15lato,
        )
      ],
    ),
  );
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
                      Container(
                        alignment: const Alignment(0, 0),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: pageCont,
                                    children: [
                                      //name num email from date to date
                                      Column(
                                        children: [
                                          //full name

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
                                                keyboardType:
                                                    TextInputType.name,
                                                minLines: null,
                                                style: const TextStyle(
                                                    fontSize: 16.0),
                                                decoration:
                                                    MyThemeData.inputDhintPre(
                                                        icon: const Icon(
                                                          Icons.person,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        ),
                                                        label: translate
                                                            .fullName)),
                                          ),
                                          //phone num
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.005,
                                                bottom: height * 0.025),
                                            child: TextFormField(
                                                validator: (value) {
                                                  return hotelsProvider
                                                      .validatePhone(
                                                          value!, context);
                                                },
                                                controller: phoneCont,
                                                keyboardType:
                                                    TextInputType.number,
                                                minLines: null,
                                                style: const TextStyle(
                                                    fontSize: 16.0),
                                                decoration:
                                                    MyThemeData.inputDhintPre(
                                                        icon: const Icon(
                                                          Icons.phone_android,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        ),
                                                        label: translate
                                                            .phoneNumber)),
                                          ),
                                          //email
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.005,
                                                bottom: height * 0.025),
                                            child: TextFormField(
                                                validator: (value) {
                                                  return hotelsProvider
                                                      .validateEmail(
                                                          value!, context);
                                                },
                                                controller: emailCont,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                minLines: null,
                                                onChanged: (value) {},
                                                style: const TextStyle(
                                                    fontSize: 16.0),
                                                decoration:
                                                    MyThemeData.inputDhintPre(
                                                        icon: const Icon(
                                                          Icons.email,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        ),
                                                        label:
                                                            translate.email)),
                                          ),
                                          //from date

                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.005,
                                                bottom: height * 0.025),
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                  controller: fromDateCont,
                                                  onTap: () async {
                                                    var date =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(2030));
                                                    fromDateCont.text = date
                                                        .toString()
                                                        .substring(0, 10);
                                                    log(fromDateCont.text);
                                                  },
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                  decoration:
                                                      MyThemeData.inputDhintPre(
                                                          icon: const Icon(
                                                            Icons.date_range,
                                                            color: Colors.grey,
                                                            size: 20,
                                                          ),
                                                          label: translate
                                                              .checkInDate)),
                                            ),
                                          ),
                                          //to date
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.005,
                                                bottom: height * 0.025),
                                            child: SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                  controller: toDateCont,
                                                  onTap: () async {
                                                    var date =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(2030));
                                                    toDateCont.text = date
                                                        .toString()
                                                        .substring(0, 10);
                                                    log(toDateCont.text);
                                                  },
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                  decoration:
                                                      MyThemeData.inputDhintPre(
                                                          icon: const Icon(
                                                            Icons.date_range,
                                                            color: Colors.grey,
                                                            size: 20,
                                                          ),
                                                          label: translate
                                                              .checkOutDate)),
                                            ),
                                          ),
                                          MaterialButton(
                                              onPressed: () {
                                                if (formKey1.currentState!
                                                    .validate()) {
                                                  pageCont.nextPage(
                                                      duration: Duration(
                                                          milliseconds: 1000),
                                                      curve: Curves
                                                          .easeInOutCubic);
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
                                              )),
                                        ],
                                      ),
                                      //passport img , adult num ,child num ,room num ,room type, book btn
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              var fromPicker =
                                                  await ImagePickerWeb
                                                      .getMultiImagesAsFile();
                                              log(fromPicker![0].name);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 9,
                                                      horizontal: 8),
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
                                                        color: Color.fromARGB(
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
                                                keyboardType:
                                                    TextInputType.name,
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
                                                keyboardType:
                                                    TextInputType.name,
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
                                                keyboardType:
                                                    TextInputType.name,
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
    child: Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(10, 61, 61, 61),
      child: Column(
        children: [
          //hotel name
          Text(hotel.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: black20LatoTS),
          CustomWidgets.sizedbox15h,
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              //hotel img
              SizedBox(
                  height: height * .23,
                  width: 300,
                  child: CustomWidgets.cachedImg(hotel.image!)),
              //hotel country
              ClipRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: -15),
                child: Container(
                  color: const Color.fromARGB(0, 255, 255, 255),
                  padding: const EdgeInsets.all(15),
                  child: Text(hotel.locationEn!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: black15lato),
                ),
              ))
            ],
          ),
          hotelPrice(hotel.sngPrice.toString(), "1"),
          hotelPrice(hotel.dblPrice.toString(), "2"),
          hotelPrice(hotel.trplPrice.toString(), "3"),
          //family
          Container(
            color: AppColors.whiteColor,
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "family",
                  style: red15lato,
                ),
                CustomWidgets.sizedbox15w,
                Text(
                  "${hotel.fmlyPrice.toString()} \$",
                  style: black15lato,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

////////////////search with country//////////////////////
countriesDropDown(HotelsVM hotelsProvider) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: DropdownButton(
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
      ),
      //search
      MaterialButton(
        color: AppColors.offWhiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        onPressed: () {},
        child: Text(
          "Search",
          style: black15lato,
        ),
      )
    ],
  );
}
