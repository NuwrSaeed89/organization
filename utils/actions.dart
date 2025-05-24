import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/floating_button_client_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/floating_button_vendor_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';

class ActionsMethods {

 static  GestureDetector customLongMethode(ProductModel product, BuildContext context, bool editMode, Widget child) {
 var floatControllerClient =
      Get.put(FloatingButtonsClientController());
      var floatControllerVendor =
      Get.put(FloatingButtonsController());
      floatControllerVendor.isEditabel=editMode;



    return GestureDetector(
                                    onLongPressStart: (details) {
                                      if(editMode){
                                        var controller= floatControllerVendor;
                                      controller.product= product;
                                       controller.isEditabel=editMode;
            controller.showFloatingButtons(
              context,
              details.globalPosition,
              productIsFavorite: false,
            );
          } 
          
          else{
             var controller= floatControllerClient;
             controller.product=product;
               controller.isEditabel=editMode;
            controller.showFloatingButtons(
              context,
              details.globalPosition,
              productIsFavorite: false,
            );
          }},
          onLongPressMoveUpdate: (details) {
          if(editMode){ var controller= floatControllerVendor; // : floatControllerClient;
            controller.updatePosition(details.globalPosition);
             }else{ var controller= floatControllerClient; // : floatControllerClient;
            controller.updatePosition(details.globalPosition);}},
          onLongPressEnd: (details) {
            if(editMode){
               var controller= floatControllerVendor; // : floatControllerClient;
            controller.processSelection();
            controller.removeFloatingButtons();
            }else{
               var controller= floatControllerClient; // : floatControllerClient;
            controller.processSelection();
            controller.removeFloatingButtons();
            }
          },  onTap: () => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 1000),
                                        pageBuilder: (context, anim1, anim2) =>
                                            ProductDetails(
                                               key: UniqueKey(),
                                          product:product,
                                          vendorId: product.vendorId,
                                        ),
                                      )),
                                  child: 
                                 child
                                );
  }
}