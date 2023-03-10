import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelagency/view_model/visa.dart';

import '../../Helper/Colors.dart';

// ignore: must_be_immutable
class PlaceWidget extends StatefulWidget {
  String imageLink;
  String capitalName;
  int countIndex;
  PlaceWidget(
      {Key? key,
      required this.imageLink,
      required this.capitalName,
      required this.countIndex})
      : super(key: key);

  @override
  State<PlaceWidget> createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  bool isHover = false;
  bool isSelected = false;
  Offset mousPos = const Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    VisaVM visaProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: MouseRegion(
        onEnter: (e) {
          setState(() {
            isHover = true;
          });
        },
        onHover: (e) {
          setState(() {
            mousPos += e.delta;
            mousPos *= 0.12;
          });
        },
        onExit: (e) {
          setState(() {
            isHover = false;
          });
        },
        child: InkWell(
          onTap: () async {
            isSelected = !isSelected;
            await visaProvider.getVisaForNewCount(
                newCountry: widget.capitalName,
                newCountIndex: widget.countIndex);
          },
          child: Container(
            width: width * .12,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: isHover ? 15 : 2,
                spreadRadius: isHover ? 5 : 2,
                color: isHover ? AppColors.grayColor : AppColors.offWhiteColor,
              )
            ]),
            child: Stack(
              children: [
                backImage(height, width),
                gradiant(),
                //TODO : Needs To Be Responsive
                Padding(padding: EdgeInsets.symmetric(vertical: 10),child:texts(height, visaProvider),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  backImage(double height, double width) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      top: isHover ? -10 + mousPos.dy : 0,
      left: isHover ? -15 + mousPos.dx : 0,
      height: isHover ? height * .45 : height * .45,
      width: width * .15,
      curve: Curves.easeOutCubic,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(widget.imageLink), fit: BoxFit.cover,
          alignment: Alignment.center,
          //repeat: ImageRepeat.repeat
        )),
      ),
    );
  }

  gradiant() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          colors: [
            isHover? AppColors.pomegranateColor.withOpacity(0.55) :isSelected? Colors.black : Colors.black45.withOpacity(0.8),
            Colors.transparent
          ],
        ),
      ),
    );
  }

   texts(double height, VisaVM visaProvider) {
    bool isSelected = visaProvider.currentCountry == widget.countIndex;
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedDefaultTextStyle(
          style: GoogleFonts.lato(
              color: AppColors.whiteColor.withOpacity(isHover ? 1 : 0.8),
              fontSize: 33,
              fontWeight: FontWeight.w900),
          duration: const Duration(milliseconds: 1000),
          child: TextButton(
            onPressed: () {},
            child: Container(decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.pomegranateColor
                    : Colors.transparent,
                borderRadius: isSelected
                    ? const BorderRadius.all(Radius.circular(5))
                    : const BorderRadius.all(Radius.circular(2)),
                border: Border.all(
                  width: 2.0,
                  color: Colors.white,
                  style: BorderStyle.solid,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 20 : 10,
                    vertical: isSelected ? 2 : 0),
                child: Text(
                  widget.capitalName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                      fontSize: height * .03,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )),
    );
  }
}
