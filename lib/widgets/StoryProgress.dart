import 'dart:async';

import 'package:app/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryProgress extends StatefulWidget {
  final Function onFinished;
  final int index;
  final int nStories;

  const StoryProgress({
    Key key,
    this.onFinished,
    this.index = 0,
    this.nStories,
  }) : super(key: key);

  @override
  _StoryProgressState createState() => _StoryProgressState();
}

class _StoryProgressState extends State<StoryProgress> {
  double _progress = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    if (!mounted) return;

    context.read<StorynextBloc>().listen((state) {
      if (state.currentIndex == widget.index) {
        startTimer();
      } else if (state.currentIndex > widget.index && _progress < 1) {
        _timer.cancel();
        setState(() => _progress = 1);
      }
    });
  }

  void startTimer() {
    _timer = Timer.periodic(
      Duration(milliseconds: 100),
      (Timer timer) => setState(
        () {
          if (_progress >= 1) {
            _timer.cancel();
            widget.onFinished();
          } else {
            _progress += 0.01;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorynextBloc, StorynextState>(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: 5,
              width: (MediaQuery.of(context).size.width - 20) / widget.nStories,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white,
              ),
            )
          ],
        );
      },
    );
  }
}
