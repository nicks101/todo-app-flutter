import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/utils/extensions.dart';

import '../providers/auth_provider.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({this.radius, super.key});

  final double? radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile =
        ref.watch(userProvider.select((value) => value?.photoURL ?? ''));

    final profilePic = userProfile.isEmpty
        ? context.constants.defaultProfilePicPath
        : userProfile;

    return CircleAvatar(
      radius: radius,
      backgroundColor: context.color.transparentColor,
      backgroundImage: NetworkImage(profilePic),
    );
  }
}
