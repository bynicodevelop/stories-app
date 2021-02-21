import 'package:flutter/material.dart';

class StoryView extends StatelessWidget {
  final Function onTap;
  final String image;
  final String text;
  final double positionning;

  const StoryView({
    Key key,
    this.image,
    this.text,
    this.onTap,
    this.positionning = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/story/$image',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            color: Colors.black.withOpacity(.1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Visibility(
            visible: text != null,
            child: Align(
              alignment: Alignment(0, positionning),
              child: Container(
                color: Colors.black.withOpacity(.3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
