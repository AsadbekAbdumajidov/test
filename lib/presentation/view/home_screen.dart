import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/constants/constants.dart';
import 'package:test/core/widgets/flush_bars.dart';
import 'package:test/core/widgets/loading_widget.dart';
import 'package:test/di.dart';
import 'package:test/presentation/cubit/users/users_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: BlocProvider(
          create: (context) => inject<UsersCubit>()..getUsers(),
          child:
              BlocConsumer<UsersCubit, UsersState>(listener: (context, state) {
            if (state.status == Status.ERROR) {
              showErrorMessage(
                  context, state.failure.getLocalizedMessage(context));
            }
          }, builder: (context, state) {
            if (state.status == Status.LOADING) {
              return const LoadingWidget();
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.length,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  var user = state.response[index];
                  return ListTile(
                    title: Text("${user.firstName} ${user.lastName}"),
                    subtitle: Text(user.id),
                  );
                });
          }),
        ));
  }
}
