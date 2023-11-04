import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    const avatar =
                        "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/106.jpg";
                    context.read<AuthenticationCubit>().createUserHandler(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar: avatar);

                    Navigator.of(context).pop();
                  },
                  child: const Text('Create User'))
            ],
          ),
        ),
      ),
    );
  }
}
