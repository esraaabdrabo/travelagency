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

class DesktopHotelScreen extends StatefulWidget {
  const DesktopHotelScreen({Key? key}) : super(key: key);

  @override
  State<DesktopHotelScreen> createState() => _desktopHotelScreenState();
}

class _desktopHotelScreenState extends State<DesktopHotelScreen> {
  final roomController = Get.put(RoomController());
  TextEditingController checkInDateController = new TextEditingController();
  TextEditingController checkoutDateController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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

                            hotelList(heght, hotelsProvider),
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

hotelList(double heght, HotelsVM hotelsProvider) {
  return SizedBox(
    height: heght * .35,
    child: GridView.builder(
      itemCount: hotelsProvider.hotels.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          maxCrossAxisExtent: 250,
          mainAxisExtent: 250),
      itemBuilder: (context, index) =>
          hotelCard(heght, hotelsProvider.hotels[index]),
    ),
  );
}

hotelCard(double heght, HotelM hotel) {
  return InkWell(
    onTap: () async {
      HotelsSV().getAllHotels();
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(hotel.name!,
              textAlign: TextAlign.center, style: black20LatoTS),
        ),
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            //hotel img
            SizedBox(
                height: heght * .23,
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
        )
      ],
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