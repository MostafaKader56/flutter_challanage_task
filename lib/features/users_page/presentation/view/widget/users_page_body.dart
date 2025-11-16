import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/error_handle/error_type.dart';
import 'package:task/core/error_handle/ui_error_handler.dart';
import 'package:task/core/helpers/shared_pref_helper.dart';
import 'package:task/features/users_page/presentation/manager/delete_user_cubit/delete_user_cubit.dart';

import '../../../../../core/utils/functions.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/get_users_cubit/get_users_cubit.dart';

class UsersPageBody extends StatefulWidget {
  const UsersPageBody({super.key});

  @override
  State<UsersPageBody> createState() => _UsersPageBodyState();
}

class _UsersPageBodyState extends State<UsersPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetUsersCubit>(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteUserCubit, DeleteUserState>(
      listener: (context, state) {
        switch (state) {
          case DeleteUserInitial():
            break;
          case DeleteUserLoading():
            Functions.showLoadingDialog();
            break;
          case DeleteUserSuccess():
            BlocProvider.of<GetUsersCubit>(context).getUsers();
            GoRouter.of(context).pop();
            break;
          case DeleteUserFailure():
            GoRouter.of(context).pop();
            break;
        }
      },
      child: BlocBuilder<GetUsersCubit, GetUsersState>(
        builder: (context, state) {
          if (state is GetUsersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetUsersFailure) {
            final ErrorType error = state.exception.errorType.entries.isEmpty
                ? ErrorType.unexpectedError
                : state.exception.errorType.entries.first.value;

            return Center(
              child: Text(
                UIErrorHandler.getLocalizedMessage(error, context),
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          // --------------------
          // SUCCESS
          // --------------------
          if (state is GetUsersSuccess) {
            final users = state.users;

            if (users.isEmpty) {
              return Center(child: Text(S.of(context).no_users_found));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final user = users[index];

                return InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(user.email),
                        const SizedBox(height: 5),
                        Text(
                          user.type,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            if (user.email ==
                                SharedPrefsHelper.getUserModel()?.email) {
                              Functions.showSnackBar(
                                S.of(context).can_not_delete_yourslef,
                              );
                              return;
                            }
                            Functions.showAlerDialog(
                              title: S.of(context).delete_user_title,
                              message: S.of(context).delete_user_desc,
                              buttonOneText: S.of(context).delete,
                              buttonTwoText: S.of(context).cancel,
                              onButtonOnePressed: () {
                                BlocProvider.of<DeleteUserCubit>(
                                  context,
                                ).deleteUser(user);
                              },
                            );
                          },
                          child: Text(
                            S.of(context).delete,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
