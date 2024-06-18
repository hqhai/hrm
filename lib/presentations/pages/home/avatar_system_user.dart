import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarSystemUser extends StatefulWidget {
  const AvatarSystemUser({super.key});

  @override
  State<AvatarSystemUser> createState() => _AvatarSystemUserState();
}

class _AvatarSystemUserState extends State<AvatarSystemUser> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, stateUser) {
        return Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueAccent,
                  child:
                      Icon(Icons.supervisor_account, color: Colors.white, size: SpacingUnit.x7_5),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        stateUser.user.fullName,
                        style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x4_5),
                      ),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x1_5,
                    ),
                    SizedBox(
                      width: width * 0.4,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        stateUser.user.email,
                        style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x3_5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
