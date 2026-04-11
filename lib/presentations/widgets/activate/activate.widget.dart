import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/widgets/dialog/no_connection/no_connection_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ActivateWidget extends StatefulWidget {
  const ActivateWidget({super.key});

  @override
  State<ActivateWidget> createState() => _ActivateWidgetState();
}

class _ActivateWidgetState extends State<ActivateWidget> {
  final String _errorName = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // ── Menu cards (scrollable area) ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SpacingUnit.x4),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: SpacingUnit.x3,
                mainAxisSpacing: SpacingUnit.x3,
                children: [
                  _MenuCard(
                    icon: Icons.event_busy_outlined,
                    iconColor: Colors.orange,
                    title: l10n.leaveManagement,
                    onTap: () => _nextLeaveScreen(context),
                  ),
                  _MenuCard(
                    icon: Icons.description_outlined,
                    iconColor: Colors.blue,
                    title: l10n.yourRequisition,
                    onTap: () => _nextMyRequestScreen(context),
                  ),
                  BlocBuilder<RequisitionApproveBloc,
                      RequisitionApproveState>(
                    builder: (context, state) {
                      final count = state.statusRequestCount[
                              EnumStepRequestStatusEnum.newStatus] ??
                          0;
                      return _MenuCard(
                        icon: Icons.check_circle_outline_rounded,
                        iconColor: Colors.green,
                        title: l10n.requisitionYouApproval,
                        badge: count > 0 ? count : null,
                        onTap: () => _nextApproveRequestScreen(context),
                      );
                    },
                  ),
                  _MenuCard(
                    icon: Icons.visibility_outlined,
                    iconColor: Colors.purple,
                    title: l10n.requisitionYouFollow,
                    onTap: () => _nextFollowerRequestScreen(context),
                  ),
                ],
              ),
            ),
          ),
          // ── Create request FAB — compact, bottom-right, thumb-friendly ──
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingUnit.x4,
              SpacingUnit.x2,
              SpacingUnit.x4,
              SpacingUnit.x4,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => _nextCreateScreen(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFf38120),
                    borderRadius: BorderRadius.circular(SpacingUnit.x7),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFf38120)
                            .withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_rounded,
                          color: Colors.white, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        l10n.createRequest,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Navigation methods (unchanged logic) ──

  void _nextLeaveScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.leavePage);
  }

  void _nextMyRequestScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    final Completer completerRequest = Completer<bool>();
    dialogIndicator(context: currentContext);
    dI<RequisitionBloc>().add(
      GetRequisitionsByFilterEvent(
        completer: completerRequest,
        page: 1,
        status: StatusRequestEnum.process,
      ),
    );
    dI<FlowBloc>().add(GetFlowsEvent(completer: completer));
    final checkRequest = await completerRequest.future;
    final check = await completer.future;
    if (check && checkRequest) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>()
          .pushName(currentContext, page: Pages.requisitionListPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dialogNoConnection(context: currentContext);
    }
  }

  void _nextApproveRequestScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(context: context);
    final Completer completerDepartment = Completer<bool>();
    dI<DepartmentBloc>().add(
      GetListDepartmentEvent(completer: completerDepartment),
    );
    dI<RequisitionApproveBloc>().add(
      GetRequisitionsApproveByFilterEvent(
        completer: completer,
        page: 1,
        status: EnumStepRequestStatusEnum.newStatus,
      ),
    );
    final check = await completer.future;
    final checkDepartment = await completer.future;
    if (check && checkDepartment) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      dI<AppNavigation>()
          .push(currentContext, page: Pages.requisitionApproveListPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      dialogNoConnection(context: currentContext);
    }
  }

  void _nextFollowerRequestScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(context: context);
    dI<RequisitionFollowingBloc>().add(
      GetRequisitionsFollowingByFilterEvent(
        completer: completer,
        page: 1,
        status: StatusRequestEnum.process,
      ),
    );
    final check = await completer.future;
    if (check) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>()
          .pushName(currentContext, page: Pages.requisitionFollowerListPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dialogNoConnection(context: currentContext);
    }
  }

  void _nextCreateScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(context: context);
    dI<FlowBloc>().add(GetFlowsEvent(completer: completer, page: 1));
    final check = await completer.future;
    if (check) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>()
          .pushName(currentContext, page: Pages.createRequestPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dialogNoConnection(context: currentContext, error: _errorName);
    }
  }
}

// ---------------------------------------------------------------------------
// Menu Card
// ---------------------------------------------------------------------------

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final int? badge;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(SpacingUnit.x4),
          border: Border.all(color: iconColor.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(SpacingUnit.x3),
                  ),
                  child: Icon(icon, color: iconColor, size: 26),
                ),
                const Spacer(),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge! > 99 ? '99+' : '$badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: SpacingUnit.x3),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.text,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
