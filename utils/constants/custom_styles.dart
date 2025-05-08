import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';

InputDecoration get inputTextField => InputDecoration(
      labelText: '',
      labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
      hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      floatingLabelStyle: const TextStyle().copyWith(
        color: Colors.black.withOpacity(0.8),
      ),
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      border: const OutlineInputBorder().copyWith(
          //  borderRadius: BorderRadius.circular(14),
          // border: const OutlineInputBorder().copyWith(
          //     borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey)),
      enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey)),
      focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.black12)),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.red)),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 2, color: Colors.orange)),
    );

InputDecoration get inputTextSearchField => InputDecoration(
      labelStyle:
          robotoSmallTitleRegular.copyWith(fontSize: 14, color: Colors.black),
      hintStyle:
          robotoSmallTitleRegular.copyWith(fontSize: 14, color: Colors.black),
      errorStyle: robotoSmallTitleRegular.copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: robotoSmallTitleRegular.copyWith(
        color: Colors.black.withOpacity(0.8),
      ),
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(50),
          // border: const OutlineInputBorder().copyWith(
          //     borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey)),
      enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(width: 1, color: Colors.grey)),
      focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(width: 1, color: Colors.black12)),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(width: 1, color: Colors.red)),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(width: 2, color: Colors.orange)),
    );
