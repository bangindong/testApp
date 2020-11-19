import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_repository/post_repository.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/blocs/main.user.bloc.dart';
import 'package:socialapp/blocs/user.bloc.dart';
import 'package:socialapp/static/static.dart';
import 'dart:math' as math;
import 'package:user_repository/user_repository.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
    final MainUserBloc mainUserBloc =
        Provider.of<MainUserBloc>(context, listen: false);
    userBloc.get();
    return Material(
      child: RefreshIndicator(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Consumer<UserBloc>(
            builder: (context, user, child) {
              return GridView.count(
                childAspectRatio: 7 / 1,
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                children: user == null
                    ? CircularProgressIndicator()
                    : _buildGridTileList(user.users, userBloc, mainUserBloc),
              );
            },
          ),
        ),
        onRefresh: () async {
          userBloc.get();
        },
      ),
    );
  }

  List<Container> _buildGridTileList(
          List<User> users, UserBloc userBloc, MainUserBloc mainUserBloc) =>
      List.generate(
          users.length,
          (i) => Container(
              child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(
                                users[i].avartar == null
                                    ? "https://via.placeholder.com/300x300"
                                    : users[i].avartar,
                              ),
                              backgroundColor: Colors.transparent,
                            )),
                        Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(users[i].name),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Static.mainUser.friendIds
                                  .contains(users[i].userId)
                              ? IconButton(
                                  onPressed: () {
                                    mainUserBloc.removeFriend(users[i].userId);
                                    userBloc.notifyListeners();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                )
                              : IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    mainUserBloc.addFriend(users[i].userId);
                                    userBloc.notifyListeners();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ))));

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
