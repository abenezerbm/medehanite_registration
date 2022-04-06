import 'package:flutter/material.dart';
import 'package:medhanite_registration/functions/check_login_func.dart';
import 'package:medhanite_registration/state_enum.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  state _state;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        _state = await checkLoginFunc();

        setState(() {});

       if(_state == state.unAuthenticated) Navigator.pushReplacementNamed(context, 'login');
       else if(_state == state.authenticated) Navigator.pushReplacementNamed(context, 'formScreen');
      } catch (e) {
        _state = state.networkError;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == state.networkError)
      return Material(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  }),
              Text("Refresh")
            ],
          ),
        ),
      );
    return Material(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
