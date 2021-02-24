import 'package:app/blocs/bloc.dart';
import 'package:app/blocs/storynext/bloc.dart';
import 'package:app/screens/authentication/ReservationScreen.dart';
import 'package:app/widgets/StoryProgress.dart';
import 'package:app/widgets/StoryView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();

  bool _isFinished = false;

  List<Widget> _stories;

  _next() {
    if (_isFinished) return;

    if (context.read<StorynextBloc>().state.currentIndex <
        _stories.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeIn,
      );
    } else {
      setState(() => _isFinished = true);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReservationScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<StorynextBloc>().add(StoryNextPageEvent(0));

    List<Map<String, dynamic>> data = [
      {
        'text': 'Créez de belles histoires,',
        'imageName': '1.png',
        'positionning': .6,
      },
      {
        'text': 'Fédérez une communauté...',
        'imageName': '2.png',
        'positionning': -.6,
      },
      {
        'text': 'Autour de vos passions',
        'imageName': '3.png',
        'positionning': -.8,
      },
      {
        'text': 'Partagez votre vision',
        'imageName': '4.png',
        'positionning': -.8,
      },
      {
        'text': 'Et vos ambitions',
        'imageName': '5.png',
        'positionning': .6,
      },
      {
        'text': 'Créez un contenu premium',
        'imageName': '6.png',
        'positionning': .6,
      },
      {
        'text': 'Pour vos followers les plus fidèles',
        'imageName': '7.png',
        'positionning': .6,
      },
    ];

    _stories = data
        .map(
          (e) => StoryView(
            text: e['text'].toUpperCase(),
            image: e['imageName'],
            positionning: e['positionning'],
            onTap: _next,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StorynextBloc, StorynextState>(
        builder: (context, state) {
          return Stack(
            children: [
              PageView(
                controller: pageController,
                children: _stories,
                onPageChanged: (index) => context.read<StorynextBloc>().add(
                      StoryNextPageEvent(index),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _stories
                      .asMap()
                      .entries
                      .map(
                        (entry) => StoryProgress(
                          onFinished: _next,
                          index: entry.key,
                          nStories: _stories.length,
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
