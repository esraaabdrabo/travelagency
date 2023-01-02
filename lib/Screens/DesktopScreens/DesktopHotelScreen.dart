import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/Helper/my_theme.dart';
import 'package:travelagency/Helper/text_style.dart';
import 'package:travelagency/Screens/Widgets/dialogs.dart';
import 'package:travelagency/Screens/Widgets/hotels/search_btn.dart';
import 'package:travelagency/Screens/Widgets/widgets.dart';
import 'package:travelagency/view_model/hotels.dart';
import '../../Helper/Colors.dart';
import '../../models/hotel/hotels.dart';
import '../Widgets/Drawer.dart';
import '../Widgets/RoomWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesktopHotelScreen extends StatefulWidget {
  const DesktopHotelScreen({Key? key}) : super(key: key);

  @override
  State<DesktopHotelScreen> createState() => _desktopHotelScreenState();
}

// ignore: camel_case_types
class _desktopHotelScreenState extends State<DesktopHotelScreen> {
  final formKey1 = GlobalKey<FormState>();

  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();

  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkoutDateController = TextEditingController();
  //*second form soctrollers*//
  TextEditingController adultCont = TextEditingController();
  TextEditingController childCont = TextEditingController();
  TextEditingController roomNumCont = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameCont.dispose();
    phoneCont.dispose();
    emailCont.dispose();
    checkInDateController.dispose();
    checkoutDateController.dispose();
    adultCont.dispose();
    childCont.dispose();
    roomNumCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations translate = AppLocalizations.of(context)!;
    var wedth = MediaQuery.of(context).size.width; //1536
    var heght = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
        create: (context) => HotelsVM(),
        builder: (context, child) {
          HotelsVM hotelsProvider = Provider.of(context);
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //left draw
                const Expanded(flex: 1, child: CustomDrawer()),
                Expanded(
                  flex: 4,
                  child: hotelsProvider.isLoading
                      ? CustomWidgets.loading
                      : ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Text("HOTEL", style: screenTitle(context)),
                            Container(
                              height: heght * .5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: wedth * .009),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1.0,
                                  color: AppColors.grayColor.withOpacity(0.09),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: wedth * .011,
                                  vertical: heght * .015),
                              child: Column(
                                children: [
                                  //search with country
                                  countriesDropDown(
                                    hotelsProvider,
                                    wedth,
                                    context,
                                  ),
                                  SizedBox(height: heght * 0.003),
                                  CustomWidgets.sizedbox15h,
                                  webSearchReq(
                                      heght: heght,
                                      wedth: wedth,
                                      checkoutDateController:
                                          checkoutDateController,
                                      checkInDateController:
                                          checkInDateController,
                                      hotelsProvider: hotelsProvider,
                                      translate: translate,
                                      context: context),
                                  SizedBox(
                                      height: heght * .15,
                                      child: ListView.builder(
                                        itemCount: hotelsProvider.rooms.length,
                                        itemBuilder: (context, roomIndex) =>
                                            RoomWidget(
                                                index: roomIndex,
                                                hotelsProvider: hotelsProvider,
                                                heght: heght,
                                                wedth: wedth),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      addRoom(
                                          hotelsProvider: hotelsProvider,
                                          context: context),
                                      SizedBox(
                                        width: wedth * .005,
                                      ),
                                      searchBtn(
                                          hotelsProvider: hotelsProvider,
                                          inDate: checkInDateController,
                                          outDate: checkoutDateController,
                                          context: context),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: heght * 0.02),
                            hotelList(heght, wedth, hotelsProvider,
                                translate: translate,
                                formKey1: formKey1,
                                nameCont: nameCont,
                                noteCont: noteCont,
                                phoneCont: phoneCont,
                                emailCont: emailCont,
                                fromDateCont: checkInDateController,
                                toDateCont: checkoutDateController),
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
priceContainer(BuildContext context,
    {required double width, required String price, required String roomType}) {
  return Container(
    width: width * .07, // width * .07,
    margin: EdgeInsets.only(right: width * .009),
    padding:
        EdgeInsets.symmetric(vertical: width * .004, horizontal: width * .009),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * .004),
        color: const Color.fromARGB(24, 61, 61, 61)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          roomType,
          style: black15lato(context),
        ),
        Text(
          price,
          style: black15lato(context),
        )
      ],
    ),
  );
}

//******search country *******/
searchBtn(
    {required HotelsVM hotelsProvider,
    required TextEditingController inDate,
    required TextEditingController outDate,
    required BuildContext context}) {
  return Align(
    alignment: Alignment.topRight,
    child: MaterialButton(
        elevation: 0,
        hoverColor: Colors.black,
        color: AppColors.pomegranateColor.withOpacity(0.8),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .02,
            horizontal: MediaQuery.of(context).size.width * .01),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.height * .01,
        )),
        onPressed: () {
          hotelsProvider.checkSearchReq(
            inDate: inDate.text,
            outDate: outDate.text,
          );
          hotelsProvider.isHotelClickAct
              ? hotelsProvider.search(context)
              : Dialogs.onlyTextContent(
                  context, "Please fill the required informations");
        },
        child: Text("Search", style: white15lato(context))),
  );
}

addRoom({required HotelsVM hotelsProvider, required BuildContext context}) {
  return Align(
    alignment: Alignment.topRight,
    child: MaterialButton(
        elevation: 0,
        hoverColor: Colors.black,
        color: AppColors.grayColor.withOpacity(.4),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .02,
            horizontal: MediaQuery.of(context).size.width * .015),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.height * .01,
        )),
        onPressed: () {
          hotelsProvider.addRoom(context);
        },
        child: Text("Add Room", style: white15lato(context))),
  );
}

webSearchReq(
    {required double heght,
    required double wedth,
    required TextEditingController checkoutDateController,
    required TextEditingController checkInDateController,
    required HotelsVM hotelsProvider,
    required AppLocalizations translate,
    required BuildContext context}) {
  return Wrap(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //from date
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: wedth * 0.005,
              ),
              child: TextFormField(
                  controller: checkInDateController,
                  validator: (value) {
                    return hotelsProvider.validateDate(value!, context);
                  },
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030));
                    checkInDateController.text =
                        date.toString().substring(0, 10);
                    log(checkInDateController.text);
                  },
                  style: TextStyle(fontSize: heght * .029),
                  decoration: MyThemeData.inputDhintPre(context,
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                        size: wedth * .015,
                      ),
                      label: translate.checkInDate)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: wedth * 0.005,
              ),
              child: TextFormField(
                  controller: checkoutDateController,
                  validator: (value) {
                    return hotelsProvider.validateDate(value!, context);
                  },
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030));
                    checkoutDateController.text =
                        date.toString().substring(0, 10);
                  },
                  style: const TextStyle(fontSize: 16.0),
                  decoration: MyThemeData.inputDhintPre(context,
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                        size: wedth * .015,
                      ),
                      label: translate.checkOutDate)),
            ),
          ),
        ],
      ),
    ],
  );
}

hotelWidget(BuildContext context,
    {required double width, required double height, required HotelM hotel}) {
  return Container(
      width: width * .5,
      height: height * .19,
      padding: EdgeInsets.all(width * .01),
      color: const Color.fromARGB(10, 61, 61, 61),
      child: Row(
        children: [
          //hotel img
          SizedBox(
            width: width * .1,
            child: CustomWidgets.cachedImg(hotel.image!),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * .017),
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
                      style: black20LatoTS(context),
                    ),
                    Text(
                      hotel.countryEn!,
                      maxLines: 1,
                      style: black15lato(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    hotel.sngPrice != null
                        ? priceContainer(context,
                            width: width,
                            price: hotel.sngPrice.toString(),
                            roomType: "SNG")
                        : const SizedBox(),
                    hotel.dblPrice != null
                        ? priceContainer(context,
                            width: width,
                            price: hotel.dblPrice.toString(),
                            roomType: "DBL")
                        : const SizedBox(),
                    hotel.trplPrice != null
                        ? priceContainer(context,
                            width: width,
                            price: hotel.trplPrice.toString(),
                            roomType: "TRP")
                        : const SizedBox(),
                    hotel.fmlyPrice != null
                        ? priceContainer(context,
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

hotelList(
  double heght,
  double wedth,
  HotelsVM hotelsProvider, {
  required AppLocalizations translate,
  required GlobalKey<FormState> formKey1,
  required TextEditingController nameCont,
  required TextEditingController phoneCont,
  required TextEditingController emailCont,
  required TextEditingController noteCont,
  required TextEditingController fromDateCont,
  required TextEditingController toDateCont,
}) {
  return SizedBox(
      height: heght * .45,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: hotelsProvider.searchResults.isEmpty
              ? hotelsProvider.hotels.length
              : hotelsProvider.searchResults.length,
          itemBuilder: (context, index) => HotelCard(
              hotel: hotelsProvider.searchResults.isEmpty
                  ? hotelsProvider.hotels[index]
                  : hotelsProvider.searchResults[index],
              hotelProvider: hotelsProvider,
              translate: translate,
              fromDate: fromDateCont.text,
              toDate: toDateCont.text)));
}

////////////text form field ////////////////////

//from date
fromDateTF({
  required TextEditingController fromDateCont,
  required HotelsVM hotelsProvider,
  required double width,
  required double height,
  required BuildContext context,
  required AppLocalizations translate,
}) {
  return TextFormField(
      controller: fromDateCont,
      validator: (value) {
        return hotelsProvider.validateDate(value!, context);
      },
      onTap: () async {
        var date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030));
        fromDateCont.text = date.toString().substring(0, 10);
      },
      style: TextStyle(fontSize: height * .025),
      decoration: MyThemeData.inputDhintPre(context,
          icon: Icon(
            Icons.date_range,
            color: Colors.grey,
            size: width * .015,
          ),
          label: translate.checkInDate));
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
          validator: (value) {
            return hotelsProvider.validateDate(value!, context);
          },
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
          decoration: MyThemeData.inputDhintPre(context,
              icon: Icon(
                Icons.date_range,
                color: Colors.grey,
                size: width * .015,
              ),
              label: translate.checkOutDate)),
    ),
  );
}

//***reserve dialog********* */

hotelName(String title, double height, double width) {
  return Padding(
    padding: EdgeInsets.only(bottom: height * .05),
    child: Text(title, textAlign: TextAlign.center, style: black20LatoWShadow),
  );
}

////////////////search with country//////////////////////
countriesDropDown(HotelsVM hotelsProvider, double wedth, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * .075,
    padding: EdgeInsets.all(wedth * .005),
    child: ListTile(
      title: Text('Select Country You Wanaa Find Hotel In'),
      subtitle: DropdownButton(
          isExpanded: true,
          value: hotelsProvider.selectedCountry,
          items: List.generate(hotelsProvider.countries.length, (index) {
            return DropdownMenuItem(
                value: hotelsProvider.countries[index],
                child: Text(
                  hotelsProvider.countries[index],
                  style: GoogleFonts.lato(
                    color: AppColors.grayColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ));
          }),
          onChanged: (country) {
            hotelsProvider.changeSelectedCountry(country.toString());
          }),
    ),
  );
}
