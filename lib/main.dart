import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/blocs/main.user.bloc.dart';
import 'package:socialapp/blocs/post.bloc.dart';
import 'package:socialapp/blocs/user.bloc.dart';
import 'package:socialapp/page/app.dart';

import 'blocs/comment.bloc.dart';
import 'blocs/post.main.user.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => MainUserBloc()),
    ChangeNotifierProvider(create: (context) => PostBloc()),
    ChangeNotifierProvider(create: (context) => UserBloc()),
    ChangeNotifierProvider(create: (context) => CommentBloc()),
    ChangeNotifierProvider(create: (context) => PostUserBloc()),
  ], child: MyApp()));
}
