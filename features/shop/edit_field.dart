import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:winto/app/providers.dart';
import 'package:winto/core/constants/colors.dart';
import 'package:winto/core/constants/text_styles.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/core/utils/dialogs/reusable_dialogs.dart';
import 'package:winto/features/admin/data/firebase/update.dart';
import 'package:winto/features/nav/static_bottom_navigator.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class EditFieldPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> userMap;
  final String label;
  final String field;
  final String hintText;
  final int maxLines;
  final int maxCharacters;
  const EditFieldPage(this.userMap, this.label, this.field, this.maxLines,
      this.maxCharacters, this.hintText,
      {super.key});

  @override
  ConsumerState<EditFieldPage> createState() => _EditNamePageState();
}

class _EditNamePageState extends ConsumerState<EditFieldPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  var userNameErrorProvider =
      StateProvider<String>((_) => 'Username unavailable');

  checkUserNameValidity(WidgetRef ref) async {
    if (_controller.text == (widget.userMap[widget.field] ?? '')) {
      ref.read(userNameErrorProvider.notifier).state = 'Username is available';
    } else {
      log('checking username validty');
      // O(log n)
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('username', isEqualTo: _controller.text.toLowerCase())
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Document with ID equal to username exists
        ref.read(userNameErrorProvider.notifier).state =
            'Username unavailable, please try a different one.';
      } else {
        ref.read(userNameErrorProvider.notifier).state =
            'Username is available';
      }
    }
  }

  void _onUserNameChanged(WidgetRef ref) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      checkUserNameValidity(ref);
    });
  }

  TextStyle getUsernameHntStyle(WidgetRef ref) {
    if (ref.read(userNameErrorProvider.notifier).state ==
        'Choose your unique username') {
      return bodyText2;
    } else if (ref.read(userNameErrorProvider.notifier).state ==
        'Username unavailable, please try a different one.') {
      return const TextStyle(
          fontSize: 14, fontFamily: 'Open Sans', color: iRed);
    }
    return TextStyle(fontSize: 14, fontFamily: 'Open Sans', color: primary);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = (widget.userMap[widget.field] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          widget.label,
         
          style: titilliumBold.copyWith(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          splashRadius: 1,
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            isLocaleEn(context)
                ? CupertinoIcons.arrow_left
                : CupertinoIcons.xmark,
            color: color1,
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  await showSimpleLoadingDialog<String>(
                    context: context,
                    future: () async {
                      //code here

                      if (widget.field == 'username' &&
                          ref.read(userNameErrorProvider.notifier).state !=
                              'Username is available') {
                        showDialogError('Choose a unique username', context);
                      } else {
                        if (widget.field == 'username') {
                          _controller.text =
                              _controller.text.toLowerCase().trim();
                        }
                        final userMap =
                            ref.read(userMapProvider.notifier).state!;
                        final updates = {
                          if (_controller.text != userMap[widget.field])
                            widget.field: _controller.text,
                        };
                        for (var entry in updates.entries) {
                          ref.read(userMapProvider.notifier).update(
                              (state) => {...state!, entry.key: entry.value});
                          await updateUserField(entry.key, entry.value);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile updated')),
                        );
                      }
                      return "done2";
                    },
                    // Custom dialog
                    dialogBuilder: (context, _) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20),
                            TLoaderWidget(),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  );

                  Navigator.pop(context, true);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const StaticBottomNavigator()));
                },
                child: Text(
                  'save',
                  textScaleFactor: 1.0,
                  style: bodyText1.copyWith(
                      fontFamily: 'Open Sans', fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 6),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                maxLength:
                    widget.maxCharacters == 0 ? null : widget.maxCharacters,
                maxLines: widget.maxLines,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  /* suffixIcon: Icon(
                    Icons.clear,
                  ), */
                  border: const UnderlineInputBorder(), // Only a bottom border
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (String text) {
                  if (widget.field == 'username') {
                    ref.read(userNameErrorProvider.notifier).state =
                        'checking ...';
                    _onUserNameChanged(ref);
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              if (widget.field == 'username')
                Consumer(
                  builder: (context, ref, child) {
                    var validityHint = ref.watch(userNameErrorProvider);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            validityHint,
                            style: getUsernameHntStyle(ref),
                          ),
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
