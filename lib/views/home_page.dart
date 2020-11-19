import 'package:flutter/material.dart';
import 'package:staysia_web/components/city_card.dart';
import 'package:staysia_web/components/custom_error_widget.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/models/get_citites.dart';

class HomePage extends StatelessWidget {
  static const id = '/homePage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            FutureBuilder<GetCities>(
              future: NavigationController.getCitiesController(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CityCard(city: snapshot.data.cities[index]);
                      },
                      itemCount: snapshot.data.cities.length,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return CustomErrorWidget();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
