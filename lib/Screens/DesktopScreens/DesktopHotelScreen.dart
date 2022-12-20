import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkoutDateController = TextEditingController();
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
                            sectionTitle("Discover our hotels"),

                            hotelList(heght, wedth, hotelsProvider,
                                translate: translate),
                            SizedBox(height: heght * 0.011),
                            sectionDivder,
                            sectionTitle(
                                "Find the hotel that suits your needs"),

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
                            sectionTitle(
                                "Do you want a specific country ? select it now."),
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
sectionTitle(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomWidgets.sizedbox15h,
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(title, style: red22lato),
      ),
      CustomWidgets.sizedbox15h,
    ],
  );
}

hotelList(double heght, double wedth, HotelsVM hotelsProvider,
    {required AppLocalizations translate}) {
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
            height: heght,
            context: context,
            translate: translate,
            width: wedth,
            hotel: hotelsProvider.hotels[index])),
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
    required AppLocalizations translate}) {
  return InkWell(
    onTap: () async {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                //         width: width * .7,
                child: CustomWidgets.cachedImg(hotel.image!),
              ),
              Expanded(
                //   width: width * .2,
                child: Form(
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
                                //full name
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.005,
                                      bottom: height * 0.025),
                                  child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      minLines: null,
                                      onChanged: (value) {},
                                      style: const TextStyle(fontSize: 16.0),
                                      decoration: MyThemeData.inputDhintPre(
                                          icon: const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                          label: translate.fullName)),
                                ),
                                //phone num
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.005,
                                      bottom: height * 0.025),
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      minLines: null,
                                      onChanged: (value) {},
                                      style: const TextStyle(fontSize: 16.0),
                                      decoration: MyThemeData.inputDhintPre(
                                          icon: const Icon(
                                            Icons.phone_android,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                          label: translate.phoneNumber)),
                                ),
                                //email
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.005,
                                      bottom: height * 0.025),
                                  child: TextFormField(
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
                                ),
                                //from date

                                Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.005,
                                      bottom: height * 0.025),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                        //controller: checkInDateController,
                                        onTap: () async {
                                          var date = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2030));
                                          /*       checkInDateController.text =
                                                            date
                                                                .toString()
                                                                .substring(0, 10);*/
                                        },
                                        onChanged: (String keySearch) {},
                                        style: const TextStyle(fontSize: 16.0),
                                        decoration: MyThemeData.inputDhintPre(
                                            icon: const Icon(
                                              Icons.date_range,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            label: translate.checkInDate)),
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
                                        onChanged: (String keySearch) {},
                                        style: const TextStyle(fontSize: 16.0),
                                        decoration: MyThemeData.inputDhintPre(
                                            icon: const Icon(
                                              Icons.date_range,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            label: translate.checkOutDate)),
                                  ),
                                ),
                                //passport img
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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
                                MaterialButton(
                                    onPressed: () {},
                                    minWidth: width * .2,
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * .03,
                                    ),
                                    color: AppColors.pomegranateColor,
                                    child: Text(
                                      "Save",
                                      style: white15lato,
                                    ))
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
