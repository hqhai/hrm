import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/request.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_state.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListUsersByManager extends StatefulWidget {
  const ListUsersByManager({super.key});

  @override
  State<ListUsersByManager> createState() => _ListUsersByManagerState();
}

class _ListUsersByManagerState extends State<ListUsersByManager> {
  bool _checkStatus(UserByAdminState stateUser) {
    return stateUser.status == RequestStatus.getUsersSuccess;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return BlocBuilder<UserByAdminBloc, UserByAdminState>(
          builder: (context, stateUser) {
            return _checkStatus(stateUser)
                ? ListView.builder(
                    itemCount: stateUser.users.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => _screenSwitch(context, stateUser, index, state),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                        padding: const EdgeInsets.all(SpacingUnit.x2),
                        decoration: const BoxDecoration(
                          color: Color(0xff293656),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        height: 100,
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      checkRequestByUser(state.requests, stateUser.users[index].id)
                                          ? colors.error
                                          : colors.text),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              stateUser.users[index].fullName??"",
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      checkRequestByUser(state.requests, stateUser.users[index].id)
                                          ? colors.error
                                          : colors.text),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const ShimmerLoad();
          },
        );
      },
    );
  }

  _screenSwitch(BuildContext context, UserByAdminState stateUser, int index, RequestState state) {
    if (checkRequestByUser(state.requests, stateUser.users[index].id)) {
      dI<RequestBloc>().add(GetRequestByUserEvent(requests: state.requests, userId: stateUser.users[index].id));
      dI<AppNavigation>().pushName(context, page: Pages.listExplanationByUserPage, extra: {
        'id': stateUser.users[index].id
      });
    }
  }

  bool checkRequestByUser(List<Request> requests, String userId) {
    List<String> requestIds = requests.map((e) => e.createdUserId).toList();
    if (requestIds.contains(userId)) {
      return true;
    }
    return false;
  }
}
