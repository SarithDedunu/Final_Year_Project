import 'package:flutter/material.dart';
import 'package:safespace/dummydata/dummy_data.dart';

class SpecialistCarousel extends StatefulWidget {
  @override
  _SpecialistCarouselState createState() => _SpecialistCarouselState();
}

class _SpecialistCarouselState extends State<SpecialistCarousel> {
  PageController _pageController = PageController(viewportFraction: 0.65);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: _pageController,
        itemCount: specialists.length,
        itemBuilder: (context, index) {
          final doctor = specialists[index];
          bool isActive = index == _currentPage;

          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: isActive ? 0 : 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (isActive)
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  )
              ],
              image: DecorationImage(
                image: AssetImage(doctor["image"]!),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          doctor["name"]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          doctor["location"]!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      print('Tapped on ${doctor["name"]}');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

