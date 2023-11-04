import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_application_2/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:flutter_application_2/src/authentication/presentation/widgets/loading_column.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  static const routeName = '/';

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthenticationCubit>().getUserHandler();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('data'),
          ),
          body: state is GettingUser
              ? const LoadingColumn(
                  message: 'Fethcing User',
                )
              : state is CreatingUser
                  ? const LoadingColumn(
                      message: 'Creating User',
                    )
                  : state is UserLoaded
                      ? Center(
                          child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final user = state.users[index];
                                return ListTile(
                                  key: ValueKey(user.id),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(user.avatar),
                                  ),
                                  title: Text(user.name),
                                  subtitle: Text(user.createdAt.substring(10)),
                                );
                              }),
                        )
                      : const Center(
                          child: Text('No data'),
                        ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (ctx) => AddUserDialog(
                        nameController: nameController,
                      ));
            },
            label: const Text('Add User'),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
