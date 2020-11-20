import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:staysia_web/components/custom_text_form_field.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/views/search_results_page.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  DateTime checkInDateTime;
  DateTime checkOutDateTime;
  String searchText;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(20),
      height: 75,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextFormField(
                    labelText: 'Search',
                    overrideLabel: true,
                    onChanged: (s) => searchText = s,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Check In'),
                    subtitle: Text(printDate(checkInDateTime)),
                    onTap: () async {
                      checkInDateTime = await showDatePickerDialog(context);
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Check Out'),
                    subtitle: Text(printDate(checkOutDateTime)),
                    onTap: () async {
                      checkOutDateTime = await showDatePickerDialog(
                        context,
                        isCheckoutDate: true,
                      );
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (searchText == null) {
                toast('Please enter some text');
              } else {
                final response =
                    await NavigationController.searchHotelWithNameController(
                  q: searchText,
                  checkIn: checkInDateTime == null
                      ? null
                      : printDate(checkInDateTime),
                  checkOut: checkOutDateTime == null
                      ? null
                      : printDate(checkOutDateTime),
                );
                //push to search details page
                await Navigator.pushNamed(context, SearchResultsPage.id,
                    arguments: {
                      'results': response,
                      'q': searchText,
                      'checkIn': checkInDateTime == null
                          ? null
                          : printDate(checkInDateTime),
                      'checkOut': checkOutDateTime == null
                          ? null
                          : printDate(checkOutDateTime),
                    });
              }
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              radius: 30,
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime> showDatePickerDialog(
    BuildContext context, {
    bool isCheckoutDate = false,
  }) async {
    var dateTime = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Theme.of(context).accentColor,
            ),
          ),
          child: child,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (dateTime == null) {
      return isCheckoutDate ? checkOutDateTime : checkInDateTime;
    } else if (isCheckoutDate && checkInDateTime == null) {
      return dateTime;
    } else if (isCheckoutDate && dateTime.isBefore(checkInDateTime)) {
      dateTime = checkOutDateTime;
      showSimpleNotification(
        Text(
          'The Checkout Date should be after Check In Date.',
          style: TextStyle(color: Colors.white),
        ),
        background: Colors.deepOrange,
      );
    } else if (!isCheckoutDate && checkOutDateTime == null) {
      return dateTime;
    } else if (!isCheckoutDate && dateTime.isAfter(checkOutDateTime)) {
      dateTime = checkOutDateTime;
      showSimpleNotification(
        Text(
          'The Check In Date should be before Check Out Date.',
          style: TextStyle(color: Colors.white),
        ),
        background: Colors.deepOrange,
      );
    }
    return dateTime;
  }

  String printDate(DateTime dateTime) {
    if (dateTime == null) {
      return 'Add Date';
    } else {
      return '$dateTime'.split(' ').first.split('-').reversed.join('/');
    }
  }
}
