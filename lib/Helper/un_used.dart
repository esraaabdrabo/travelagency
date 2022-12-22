/**
 * hotels
 *  //add room
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
                            rooms list 
                               //room1 room2
                            SizedBox(
                              height: heght * 0.32,
                              child: SizedBox(
                                height: 50,//(heght * 0.075) *roomController.RoomCount.value.toDouble(),
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
                            check in
                                             /*   Padding(
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
                                  */  
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
                                 
                      
                          
 */