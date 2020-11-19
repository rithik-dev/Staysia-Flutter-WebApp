import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staysia_web/models/get_citites.dart';

class CityCard extends StatelessWidget {
  final Cities city;

  const CityCard({@required this.city});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // image: DecorationImage(
          //   image: ,
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Stack(
          children: [
            FadeInImage(
              height: double.infinity,
              fit: BoxFit.cover,
              image:NetworkImage(city.thumbnail),
              placeholder: AssetImage('images/shimmer.gif'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                child: Text(
                  city.displayName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
