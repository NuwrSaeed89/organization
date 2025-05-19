import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/social/data/firebase/user/follow-unfollow.dart';

class FollowHeart extends ConsumerStatefulWidget {
  final String myId;
  final String userId;
  final Color primary;

  const FollowHeart({
    super.key,
    required this.myId,
    required this.userId,
    required this.primary,
  });

  @override
  ConsumerState<FollowHeart> createState() => _FollowButtonState();
}

class _FollowButtonState extends ConsumerState<FollowHeart> {
  bool? _isFollowing; // Local follow state; null until fetched.
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialFollowStatus();
  }

  Future<void> _fetchInitialFollowStatus() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.myId)
          .collection('following')
          .doc(widget.userId)
          .get();
      if (mounted)
        setState(() {
          _isFollowing = doc.exists;
        });
    } catch (e) {
      // In case of error, assume not following.
      if (mounted)
        setState(() {
          _isFollowing = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    // While we're waiting for the initial fetch, show a shimmer.
    if (_isFollowing == null) {
      return TShimmerEffect(
        width: 40,
        height: 40,
        raduis: BorderRadius.circular(40),
      );
    }

    // _isFollowing is now available.
    bool displayFollowing = _isFollowing!;

    return GestureDetector(
      onTap: () async {
        HapticFeedback.mediumImpact();
        if (_isLoading) {
          log('Action already in progress...');
          return;
        }

        // Optimistically toggle the follow state.
        if (mounted)
          setState(() {
            _isFollowing = !displayFollowing;
            //_isLoading = true;
          });

        try {
          if (displayFollowing) {
            await unfollowUser(widget.myId, widget.userId);
          } else {
            await followUser(widget.myId, widget.userId);
          }
        } catch (e) {
          // On error, revert the optimistic update.
          if (mounted)
            setState(() {
              _isFollowing = displayFollowing;
            });
        } finally {
          if (mounted)
            setState(() {
              //_isLoading = false;
            });
        }
      },
      child: _isLoading
          ? TShimmerEffect(
              width: 42,
              height: 42,
              raduis: BorderRadius.circular(40),
            )
          : Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: TRoundedContainer(
                  width: 34,
                  height: 34,
                  radius: BorderRadius.circular(300),
                 enableShadow: true,
                 
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: !displayFollowing
                          ? const Icon(CupertinoIcons.heart,
                              // : CupertinoIcons.heart,
                              // color: const Color(0xFFFF5050),
                              color: Colors.black,
                              size: 23)
                          : const Icon(CupertinoIcons.heart_fill,
                              // : CupertinoIcons.heart,
                              // color: const Color(0xFFFF5050),
                              color: Colors.red,
                              size: 23),
                    ),
                  ),
                ),
            ),
          ),
    );
  }
}
