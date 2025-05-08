import 'package:flutter/material.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/themes/custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String? description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool refund;
  final Color? color;
  final TextEditingController? note;
  const ConfirmationDialog(
      {super.key,
      required this.icon,
      this.title,
      this.description,
      required this.onYesPressed,
      this.isLogOut = false,
      this.refund = false,
      this.note,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSizes.sm)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: 500,
          child: Padding(
              padding: const EdgeInsets.all(TSizes.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.paddingSizeDefault),
                  child: Image.asset(
                    icon,
                    width: 50,
                    height: 50,
                  ),
                ),
                title != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSizeDefault),
                        child: Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: TSizes.md, color: color ?? Colors.red),
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(TSizes.paddingSizeDefault),
                  child: Column(
                    children: [
                      Text(description ?? '',
                          style: TextStyle(fontSize: TSizes.md),
                          textAlign: TextAlign.center),
                      refund
                          ? TextFormField(
                              controller: note,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .translate('dialog.note'),
                              ),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.paddingSizeDefault),
                Row(children: [
                  Expanded(
                      child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CustomButton(
                      btnTxt:
                          AppLocalizations.of(context).translate('dialog.no'),
                      backgroundColor: TColors.grey,
                      isColor: true,
                    ),
                  )),
                  const SizedBox(width: TSizes.paddingSizeDefault),
                  Expanded(
                      child: CustomButton(
                          btnTxt: AppLocalizations.of(context)
                              .translate('dialog.yes'),
                          onTap: () {
                            onYesPressed();
                            Navigator.pop(context);
                          })),
                ])
              ])),
        ));
  }
}
