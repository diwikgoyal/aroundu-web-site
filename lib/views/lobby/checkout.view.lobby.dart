import 'package:aroundu/constants/appRoutes.dart';
import 'package:aroundu/designs/widgets/textfield.widget.designs.dart';
import 'package:aroundu/models/lobby.dart';
import 'package:aroundu/models/offers_model.dart';
import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/utils/api_service/file_upload.service.dart';
import 'package:aroundu/utils/custome_snackbar.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/lobby/access_request.view.dart';
import 'package:aroundu/views/lobby/provider/coupon_provider.dart';
import 'package:aroundu/views/lobby/provider/forms_list_provider.dart';
import 'package:aroundu/views/lobby/provider/get_price_provider.dart';
import 'package:aroundu/views/lobby/provider/lobbies_providers.dart';
import 'package:aroundu/views/lobby/provider/lobbies_providers_util.dart';
import 'package:aroundu/views/lobby/provider/lobby_access_provider.dart';
import 'package:aroundu/views/lobby/provider/lock_pricing_provider.dart';
import 'package:aroundu/views/lobby/provider/selected_tickets_provider.dart';
import 'package:aroundu/views/offer/apply.offer.dart';
import 'package:aroundu/views/payment/gateway_service/Cashfree/cashfree.payment.dart';
import 'package:aroundu/views/profile/controllers/controller.profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../designs/colors.designs.dart';
import '../../designs/icons.designs.dart';
import '../../designs/widgets/button.widget.designs.dart';
import '../../designs/widgets/icon.widget.designs.dart';
import '../../designs/widgets/space.widget.designs.dart';
import '../../designs/widgets/text.widget.designs.dart';
import 'package:dotted_border/dotted_border.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(1);

  void increment() => state++;
  void decrement() {
    if (state > 0) {
      state--;
    }
  }

  void setValue(int value) {
    state = value;
  }
}

// Provider to track which key is currently expanded
final expandedKeyProvider = StateProvider<String?>((ref) => null);

// Simplified expansion state provider using StateProvider
final expandStateProvider = StateProvider.family<bool, String>((ref, key) {
  final expandedKey = ref.watch(expandedKeyProvider);
  return expandedKey == key;
});

// Helper function to toggle expansion (can be used directly in widgets)
void toggle(WidgetRef ref, String key) {
  final currentExpanded = ref.read(expandedKeyProvider);
  if (currentExpanded == key) {
    ref.read(expandedKeyProvider.notifier).state = null; // Collapse
  } else {
    ref.read(expandedKeyProvider.notifier).state = key; // Expand this one
  }
}

class CheckOutPublicLobbyView extends ConsumerStatefulWidget {
  const CheckOutPublicLobbyView({
    super.key,
    required this.lobby,
    this.formModel,
    this.requestText,
    this.selectedTickets = const <SelectedTicket>[],
  });
  final Lobby lobby;
  final FormModel? formModel;
  final String? requestText;
  final List<SelectedTicket> selectedTickets;

  @override
  ConsumerState<CheckOutPublicLobbyView> createState() => _CheckOutPublicLobbyViewState();
}

class _CheckOutPublicLobbyViewState extends ConsumerState<CheckOutPublicLobbyView> {
  final profileController = Get.put(ProfileController());
  final TextEditingController _couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // || (widget.lobby.lobbyType=='PUBLIC' && widget.lobby.priceDetails?.price!= 0.0)

    Future.microtask(() {
      ref.read(selectedOfferProvider.notifier).state = null;
      ref.read(formsListProvider.notifier).resetFormsList();
      if (widget.formModel != null) {
        if (ref.read(formsListProvider).isEmpty) {
          ref.read(formsListProvider.notifier).addForm(widget.formModel!);
        }
      }
    });

    // Add listener to update coupon code in provider
    _couponController.addListener(() {
      final text = _couponController.text;
      ref.read(couponProvider.notifier).updateCouponCode(text);

      // If text is empty, clear the selected offer
      if (text.isEmpty) {
        ref.read(selectedOfferProvider.notifier).state = null;
      }
    });

    if (widget.lobby.accessRequestData != null) {
      Future.microtask(() {
        ref.read(counterProvider.notifier).setValue(widget.lobby.accessRequestData?.count ?? 1);

        ref.read(pricingProvider(widget.lobby.id).notifier).updateGroupSize(widget.lobby.id, ref.read(counterProvider));
      });
    } else {
      Future.microtask(() {
        ref.read(counterProvider.notifier).setValue(1);

        // final existingForms = ref.read(formsListProvider);
        // final hasExistingForm =
        //     existingForms.any((f) => f.title == widget.formModel?.title);

        // if (!hasExistingForm &&
        //     widget.formModel != null &&
        //     widget.lobby.isFormMandatory == true) {
        //   ref.read(formsListProvider.notifier).addForm(widget.formModel!);
        // }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(formsListProvider.notifier).resetFormsList();
      ref.read(counterProvider.notifier).setValue(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // kLogger.trace("lobby typr : ${widget.lobby.lobbyType} \n formMandatory : ${widget.lobby.isFormMandatory}");
    final count = ref.watch(counterProvider);

    final selectedOffer = ref.watch(selectedOfferProvider);
    print("selectedOffer.offerName : ${selectedOffer?.offerName}");

    final pricingState = ref.watch(pricingProvider(widget.lobby.id));
    final pricingData = pricingState.pricingData;
    print("priceData : ${pricingData?.toJson()}");

    final formList = ref.watch(formsListProvider);

    // Watch coupon state
    final couponState = ref.watch(couponProvider);

    // Synchronize coupon state with selectedOfferProvider
    // If coupon validation was successful, update the selected offer
    if (couponState.validatedOffer != null && selectedOffer?.offerId != couponState.validatedOffer?.offerId) {
      // Use microtask to avoid build phase state updates
      Future.microtask(() {
        ref.read(selectedOfferProvider.notifier).state = couponState.validatedOffer;
      });
    }
    print("formList : ${formList}");
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: DesignText(text: "Checkout", fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xFF444444)),
        leading: IconButton(
          onPressed: () {
            Fluttertoast.showToast(msg: "checkout is still pending");
            ref.read(selectedOfferProvider.notifier).state = null;
            ref.read(counterProvider.notifier).setValue(0);
            Get.back();
          },
          icon: DesignIcon.icon(icon: Icons.arrow_back_ios_new_rounded),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 0.09 * sh,
        constraints: BoxConstraints(minHeight: 64),
        // padding: EdgeInsets.symmetric(
        //   horizontal: 0.05 * sw,
        //   vertical: 0.01 * sh,
        // ),
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DesignText(
                  text: (widget.lobby.priceDetails?.price != 0.0) ? "Total Payout " : 'Let’s GO !',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF444444),
                ),
                DesignText(
                  text: "₹ ${calculateTotalPrice(pricingData: pricingData, selectedOffer: selectedOffer)}",

                  // text: (calculateTotalPrice(pricingData: pricingData, selectedOffer: selectedOffer) != '0.0') ? "₹ ${calculateTotalPrice(pricingData: pricingData, selectedOffer: selectedOffer)}" : "Free",

                  // text: (pricingData?.isTieredPriced != null &&
                  //         pricingData?.isTieredPriced == true)
                  //     ? "₹ ${pricingData?.total ?? (count * ((pricingData?.currentPricePerSlot ?? widget.lobby.priceDetails?.price ?? 0.0) - (selectedOffer?.discountedPrice ?? 0.0)))}"
                  //     : (widget.lobby.priceDetails?.price != 0.0)
                  //         ? (selectedOffer?.discountedPrice != null)
                  //             ? "₹ ${(count * (widget.lobby.priceDetails?.price ?? 0.0)) - (count * ((widget.lobby.priceDetails?.price ?? 0.0) - (selectedOffer?.discountedPrice ?? 0.0)))}"
                  //             : "₹ ${count * (widget.lobby.priceDetails?.price ?? 0.0)}"
                  //         : "Free",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(
              width: 0.45 * sw,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: DesignButton(
                      onPress: () async {
                        HapticFeedback.mediumImpact();
                        final price = count * (widget.lobby.priceDetails?.price ?? 0.0);
                        final formList = ref.read(formsListProvider);
                        final isFormValidated = ref.watch(formsListProvider.notifier).validateAllForms();
                        print("isFormValidated : $isFormValidated");
                        // kLogger.trace(
                        //   "isFormListData : ${(ref.read(formsListProvider.notifier).getAllFormsData()[1]['questions'].length)}",
                        // );
                        if (count > 0 && isFormValidated == null) {
                          bool shouldProceed = false;
                          await showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              final emailController = TextEditingController();
                              emailController.text = profileController.profileData.value?.email ?? "";

                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                title: DesignText(
                                  text: "Verify Your Email",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: DesignColors.accent,
                                ),
                                content: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      DesignText(
                                        text:
                                            "Please verify your email address is correct. We'll send your invoice, QR code, and other important details to this email.",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                        maxLines: null,
                                        overflow: TextOverflow.visible,
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          hintText: "Your email address",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide(color: DesignColors.accent, width: 1.5),
                                          ),
                                          prefixIcon: Icon(Icons.email_outlined, color: DesignColors.accent),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Just close the dialog without setting shouldProceed to true
                                      Navigator.of(context).pop();
                                    },
                                    child: DesignText(
                                      text: "Cancel",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final email = emailController.text.trim();
                                      final bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                      ).hasMatch(email);

                                      if (!emailValid) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Please enter a valid email address"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      // Only make API call if email has changed
                                      if (email != (profileController.profileData.value?.email ?? "")) {
                                        try {
                                          final res = await ApiService().post(
                                            "user/api/v1/updateBasicProfile",
                                            body: {"email": email, "isEditingProfile": true},
                                          );

                                          if (res.statusCode == 200) {
                                            // Update local profile data
                                            await profileController.getUserProfileData();

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text("Email updated successfully"),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Failed to update email. Please try again."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }

                                      // Set shouldProceed to true and close dialog
                                      shouldProceed = true;
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: DesignColors.accent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    ),
                                    child: DesignText(
                                      text: "Confirm",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          // Only proceed with checkout if user confirmed
                          if (!shouldProceed) {
                            return;
                          }

                          await ref
                              .read(pricingProvider(widget.lobby.id).notifier)
                              .fetchPricing(
                                widget.lobby.id,
                                groupSize: ref.read(counterProvider),
                                selectedTickets: widget.selectedTickets,
                              );

                          final getPricingData = ref.read(pricingProvider(widget.lobby.id));
                          kLogger.trace("getPricingData : ${getPricingData.pricingData?.toJson()}");
                          if (getPricingData.pricingData != null && getPricingData.pricingData?.status != 'SUCCESS') {
                            Get.back();
                            CustomSnackBar.show(
                              context: context,
                              message: getPricingData.pricingData?.message ?? 'Something went wrong!',
                              type: SnackBarType.error,
                            );
                            return;
                          }

                          // Lock the pricing after updating group size
                          await ref
                              .read(lockPricingProvider(widget.lobby.id).notifier)
                              .lockPricing(widget.lobby.id, ref.read(counterProvider), widget.selectedTickets);

                          // Check if lock pricing failed and show toast with error message
                          final lockPricingData = ref.read(lockPricingDataProvider(widget.lobby.id));
                          kLogger.trace("lockPricingData : ${lockPricingData?.toJson()}");
                          if (lockPricingData != null && lockPricingData.status != 'SUCCESS') {
                            Get.back();
                            CustomSnackBar.show(
                              context: context,
                              message: lockPricingData.message ?? 'Something went wrong!',
                              type: SnackBarType.error,
                            );

                            return;
                          } else if ((pricingData?.total != getPricingData.pricingData?.total) ||
                              (pricingData?.total != lockPricingData?.total) ||
                              (getPricingData.pricingData?.total != lockPricingData?.total)) {
                            Get.back();
                            CustomSnackBar.show(
                              context: context,
                              message: 'Please check out again as the price has been updated for your slots.',
                              type: SnackBarType.error,
                            );
                            return;
                          }
                          kLogger.trace(
                            "here is calc : ${calculateTotalPrice(pricingData: pricingData, selectedOffer: selectedOffer)}",
                          );
                          if (calculateTotalPrice(pricingData: pricingData, selectedOffer: selectedOffer) == "0.0") {
                            bool lobbyJoinStatus = false;
                            if (widget.lobby.isPrivate && widget.lobby.accessRequestData != null) {
                              final body = {
                                "lobbyId": widget.lobby.id,
                                "requestAccessDTOList": [
                                  {
                                    "accessRequestId": widget.lobby.accessRequestData?.accessId ?? "",
                                    "paymentDone": true,
                                  },
                                ],
                                "afterPayment": true,
                              };
                              if (selectedOffer != null && selectedOffer.offerId.isNotEmpty) {
                                body["OfferId"] = selectedOffer.offerId;
                              }

                              // Chain the second API call
                              final accessResponse = await ref.read(permissionAccessRequestProvider(body).future);

                              lobbyJoinStatus = accessResponse['status'] == 'SUCCESS';
                            } else {
                              final slots = ref.read(counterProvider);
                              if ((formList.isNotEmpty ? formList.first : widget.formModel) != null) {
                                if (slots > 1) {
                                  final accessResponse = await ref.read(
                                    handleLobbyAccessProvider(
                                      widget.lobby.id,
                                      false,
                                      text: widget.requestText ?? "",
                                      hasForm: true,
                                      form: (formList.isNotEmpty ? formList.first : widget.formModel)?.toJson() ?? {},
                                      formList:
                                          (formList.isNotEmpty ? formList.sublist(1) : formList)
                                              .map((form) => form.toJson())
                                              .toList() ??
                                          [],
                                      slots: slots,
                                      offerId: selectedOffer?.offerId,
                                      selectedTickets: widget.selectedTickets,
                                    ).future,
                                  );
                                  lobbyJoinStatus = accessResponse['status'] == 'SUCCESS';
                                } else {
                                  final accessResponse = await ref.read(
                                    handleLobbyAccessProvider(
                                      widget.lobby.id,
                                      false,
                                      text: widget.requestText ?? "",
                                      hasForm: true,
                                      form: (formList.isNotEmpty ? formList.first : widget.formModel)?.toJson() ?? {},
                                      offerId: selectedOffer?.offerId,
                                      selectedTickets: widget.selectedTickets,
                                    ).future,
                                  );
                                  lobbyJoinStatus = accessResponse['status'] == 'SUCCESS';
                                }
                              } else {
                                if (slots > 1) {
                                  final accessResponse = await ref.read(
                                    handleLobbyAccessProvider(
                                      widget.lobby.id,
                                      false,
                                      text: "",
                                      hasForm: false,
                                      slots: slots,
                                      offerId: selectedOffer?.offerId,
                                      selectedTickets: widget.selectedTickets,
                                    ).future,
                                  );
                                  lobbyJoinStatus = accessResponse['status'] == 'SUCCESS';
                                } else {
                                  final accessResponse = await ref.read(
                                    handleLobbyAccessProvider(
                                      widget.lobby.id,
                                      false,
                                      text: "",
                                      hasForm: false,
                                      offerId: selectedOffer?.offerId,
                                      selectedTickets: widget.selectedTickets,
                                    ).future,
                                  );
                                  lobbyJoinStatus = accessResponse['status'] == 'SUCCESS';
                                }
                              }
                            }
                            Get.back();
                            if (lobbyJoinStatus) {
                              ref.invalidate(LobbyProviderUtil.getProvider(LobbyType.joined));
                              Fluttertoast.showToast(msg: "You have successfully joined the lobby");
                            } else {
                              Fluttertoast.showToast(msg: "Something went wrong!!!");
                            }
                          } else if (pricingData != null && pricingData.currentProvider == 'cashfree') {
                            Get.offNamed(
                              AppRoutes.cashfree,
                              arguments: {
                                'userId': profileController.profileData.value?.userId ?? "",
                                'lobby': widget.lobby,
                                'formModel': formList.isNotEmpty ? formList.first : widget.formModel,
                                'formList': formList,
                                'requestText': widget.requestText,
                                'selectedTickets': widget.selectedTickets,
                              },
                            );
                          } else {
                            CustomSnackBar.show(
                              context: context,
                              message: "Can't proceed right now for payment \n Please try later after some time",
                              type: SnackBarType.warning,
                            );
                            // Get.off(
                            //   () => HyperCheckOutPaymentView(
                            //     // amount: 100,
                            //     userId:
                            //         profileController
                            //             .profileData
                            //             .value
                            //             ?.userId ??
                            //         "",
                            //     lobby: widget.lobby,
                            //     formModel:
                            //         formList.isNotEmpty
                            //             ? formList.first
                            //             : widget.formModel,
                            //     formList: formList,
                            //     requestText: widget.requestText,
                            //   ),
                            // );
                          }
                        } else {
                          if (count == 0) {
                            Fluttertoast.showToast(msg: "can't proceed with 0 slots");
                          } else if (isFormValidated != null) {
                            Fluttertoast.showToast(msg: "Please fill all the required form fields");
                          }
                        }
                      },
                      bgColor: (count > 0 && ref.watch(formsListProvider.notifier).validateAllForms() == null)
                          ? DesignColors.accent
                          : const Color(0xFF989898),
                      title: "Checkout",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 393,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 2,
                      color: Color(0x143E79A1), // #3E79A114: 0x14 is the alpha value
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            (widget.lobby.mediaUrls.isNotEmpty) ? widget.lobby.mediaUrls.first : "",
                            height: 142,
                            width: 175,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 142,
                                width: 175,
                                color: Colors.grey[200],
                                child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 142,
                                width: 175,
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(color: DesignColors.accent, strokeWidth: 3),
                                ),
                              );
                            },
                          ),
                        ),
                        Space.w(width: 12),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DesignText(
                                  text: widget.lobby.title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF323232),
                                  maxLines: 2,
                                ),
                                // SizedBox(height: 4),
                                // DesignText(
                                //   text: widget.lobby.description,
                                //   fontSize: 12,
                                //   fontWeight: FontWeight.w400,
                                //   color: const Color(0xFF6E6E6E),
                                //   maxLines: 2,
                                // ),
                                if (widget.lobby.filter.otherFilterInfo.dateRange != null) ...[
                                  Space.h(height: 8),
                                  Row(
                                    children: [
                                      DesignIcon.custom(
                                        icon: DesignIcons.calendar,
                                        color: DesignColors.accent,
                                        size: 10,
                                      ),
                                      Space.w(width: 4),
                                      Expanded(
                                        child: DesignText(
                                          text:
                                              widget.lobby.filter.otherFilterInfo.dateRange?.formattedDateCompactView ??
                                              "",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF444444),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (widget.lobby.filter.otherFilterInfo.dateInfo != null) ...[
                                  Space.h(height: 8),
                                  Row(
                                    children: [
                                      DesignIcon.custom(
                                        icon: DesignIcons.calendar,
                                        color: DesignColors.accent,
                                        size: 10,
                                      ),
                                      Space.w(width: 4),
                                      Expanded(
                                        child: DesignText(
                                          text: widget.lobby.filter.otherFilterInfo.dateInfo?.formattedDate ?? "",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF444444),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (widget.lobby.filter.otherFilterInfo.locationInfo != null) ...[
                                  Space.h(height: 8),
                                  Row(
                                    children: [
                                      DesignIcon.custom(
                                        icon: DesignIcons.location,
                                        color: DesignColors.accent,
                                        size: 10,
                                      ),
                                      Space.w(width: 4),
                                      Expanded(
                                        child: DesignText(
                                          text:
                                              widget
                                                  .lobby
                                                  .filter
                                                  .otherFilterInfo
                                                  .locationInfo!
                                                  .googleSearchResponses
                                                  .first
                                                  .structuredFormatting
                                                  ?.mainText ??
                                              "",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF444444),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Space.h(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0x143E79A1),
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: (widget.lobby.priceDetails?.price != 0.0)
                                  ? 'Refund & Cancellation : '
                                  : 'Cancellation : ',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                color: const Color(0xFF444444),
                              ),
                            ),
                            TextSpan(
                              text: (widget.lobby.priceDetails?.price != 0.0)
                                  ? (widget.lobby.priceDetails.isRefundAllowed)
                                        ? 'Available up to 2 days before the lobby.'
                                        : 'Refund Not Available'
                                  : 'Cancel at any time with no hassle',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins',
                                color: const Color(0xFF444444),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Space.h(height: 24),
              if (pricingData != null && pricingData.code == 0) ...[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFBBBCBD), width: 0.6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DesignText(
                        text: 'Pricing Details',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232),
                      ),
                      Space.h(height: 12),
                      if (!widget.lobby.isAdvancedPricing)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DesignText(
                              text: 'Total Amount',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF444444),
                            ),
                            DesignText(text: '₹ ${pricingData.total}', fontSize: 12, fontWeight: FontWeight.w400),
                          ],
                        )
                      else ...[
                        ...List.generate(pricingData.ticketSelections.length, (index) {
                          final ticket = pricingData.ticketSelections[index];
                          final slots = ticket['slots'] ?? 1;
                          final price = ticket['price'] ?? 0;
                          final totalPrice = price * slots;
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          DesignText(
                                            text: ticket['name'],
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF323232),
                                          ),
                                          Space.h(height: 2),
                                          DesignText(
                                            text: '₹ ${price.toStringAsFixed(0)} each',
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF666666),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        DesignText(
                                          text: '× $slots',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF444444),
                                        ),
                                        Space.h(height: 2),
                                        DesignText(
                                          text: '₹ ${totalPrice.toStringAsFixed(0)}',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF323232),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                      if (widget.lobby.priceTierList != null && widget.lobby.priceTierList!.isNotEmpty) ...[
                        Space.h(height: 16),
                        DesignText(
                          text: 'Price Tiers',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF444444),
                        ),
                        Space.h(height: 8),
                        ...widget.lobby.priceTierList!.asMap().entries.map((entry) {
                          final index = entry.key;
                          final tier = entry.value;
                          final isCurrentTier =
                              pricingData.currentPosition != null && pricingData.currentPosition == index;

                          return Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DesignText(
                                  text: "${tier.minSlots} - ${tier.maxSlots} slots",
                                  fontSize: 12,
                                  fontWeight: isCurrentTier ? FontWeight.w800 : FontWeight.w400,
                                  color: isCurrentTier ? Colors.green : const Color(0xFF444444),
                                ),
                                DesignText(
                                  text: "₹ ${tier.price}",
                                  fontSize: 12,
                                  fontWeight: isCurrentTier ? FontWeight.w800 : FontWeight.w400,
                                  color: isCurrentTier ? Colors.green : const Color(0xFF323232),
                                ),
                              ],
                            ),
                          );
                        }),
                        Space.h(height: 12),
                      ],
                      if (pricingData.isTieredPriced != null && pricingData.isTieredPriced == true) ...[
                        DesignText(
                          text: 'Pricing Details',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF323232),
                        ),
                        Space.h(height: 4),
                        DesignText(
                          text: pricingData.priceBreakdown ?? "",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF323232),
                          maxLines: null,
                          overflow: TextOverflow.visible,
                        ),
                        //  Space(height: 12),
                      ],
                    ],
                  ),
                ),
                Space.h(height: 24),
              ],
              if (widget.lobby.lobbyType != 'PRIVATE' && !widget.lobby.isAdvancedPricing) ...[
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  color: Colors.white,
                  elevation: 8,
                  shadowColor: const Color(0x143E79A1),
                  child: Container(
                    width: 1 * sw,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            ref.read(counterProvider.notifier).decrement();
                            ref.read(selectedOfferProvider.notifier).state = null;
                            if (formList.isNotEmpty) {
                              formList.removeLast();
                            }
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [CircularProgressIndicator(color: DesignColors.accent)],
                                  ),
                                );
                              },
                            );
                            await ref
                                .read(pricingProvider(widget.lobby.id).notifier)
                                .updateGroupSize(widget.lobby.id, count - 1);

                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: DesignColors.accent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.remove, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 0.6 * sw,
                          child: TextField(
                            enabled: (widget.lobby.isFormMandatory == false),
                            controller: TextEditingController(text: count.toString()),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF444444)),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onSubmitted: (value) async {
                              final newCount = int.tryParse(value) ?? 0;
                              ref.read(counterProvider.notifier).setValue(newCount);

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [CircularProgressIndicator(color: DesignColors.accent)],
                                    ),
                                  );
                                },
                              );

                              await ref
                                  .read(pricingProvider(widget.lobby.id).notifier)
                                  .updateGroupSize(widget.lobby.id, newCount);

                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ),
                        // DesignText(
                        //   text: count.toString(),
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w600,
                        //   color: const Color(0xFF444444),
                        // ),
                        InkWell(
                          onTap: () async {
                            ref.read(counterProvider.notifier).increment();
                            ref.read(selectedOfferProvider.notifier).state = null;
                            if (widget.formModel != null) {
                              if (ref.read(formsListProvider).isEmpty) {
                                ref.read(formsListProvider.notifier).addForm(widget.formModel!);
                              } else {
                                final clearedForm = widget.formModel!.copyWith(
                                  questions: widget.formModel!.questions.map((q) => q.copyWith(answer: '')).toList(),
                                );

                                ref.read(formsListProvider.notifier).addForm(clearedForm);
                              }
                            }
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [CircularProgressIndicator(color: DesignColors.accent)],
                                  ),
                                );
                              },
                            );
                            await ref
                                .read(pricingProvider(widget.lobby.id).notifier)
                                .updateGroupSize(widget.lobby.id, count + 1);

                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: DesignColors.accent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Space.h(height: 24),
              ],
              Container(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFBBBCBD), width: 0.6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(
                      text: (widget.lobby.priceDetails?.price != 0.0) ? "Price details" : "Order Summary",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF444444),
                    ),
                    Space.h(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DesignText(
                                  text: "Lobby Charges",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF323232),
                                ),
                                DesignText(
                                  text:
                                      "₹ ${calculateTotalPrice(pricingData: pricingData, selectedOffer: selectedOffer)}",
                                  // text: (pricingData?.isTieredPriced != null &&
                                  //         pricingData?.isTieredPriced == true)
                                  //     ? "₹ ${(pricingData?.currentPricePerSlot ?? widget.lobby.priceDetails.price)}"
                                  //     : (widget.lobby.priceDetails?.price !=
                                  //             0.0)
                                  //         ? "₹ ${(widget.lobby.priceDetails?.price)}"
                                  //         : "Free",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF323232),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DesignText(
                                  text: "Slots booked",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF323232),
                                ),
                                DesignText(
                                  text: count.toString(),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF323232),
                                ),
                              ],
                            ),
                          ),
                          if (widget.lobby.priceDetails?.price != 0.0) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DesignText(
                                    text: "Discount",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF323232),
                                  ),
                                  DesignText(
                                    text:
                                        "- ₹ ${calculateDiscount(pricingData: pricingData, selectedOffer: selectedOffer)}",
                                    // text:
                                    //     "- ₹ ${(selectedOffer != null) ? "${count * ((widget.lobby.priceDetails?.price ?? 0.0) - (selectedOffer.discountedPrice))}" : "0.0"}",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: (selectedOffer != null) ? DesignColors.accent : const Color(0xFF323232),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DesignText(
                                    text: "Tax",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF323232),
                                  ),
                                  DesignText(
                                    text: "₹ 0.0",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF323232),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Color(0xFFBBBCBD), thickness: 0.4),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DesignText(
                                    text: "Total",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF323232),
                                  ),
                                  DesignText(
                                    text:
                                        "₹ ${calculateTotalPrice(pricingData: pricingData, selectedOffer: selectedOffer)}",
                                    // text: (pricingData?.isTieredPriced !=
                                    //             null &&
                                    //         pricingData?.isTieredPriced == true)
                                    //     ? (selectedOffer?.discountedPrice !=
                                    //             null)
                                    //         ? "₹ ${pricingData?.total ?? (count * (pricingData?.currentPricePerSlot ?? widget.lobby.priceDetails?.price ?? 0.0)) - (pricingData?.total ?? (count * (pricingData?.currentPricePerSlot ?? widget.lobby.priceDetails?.price ?? 0.0)) - (count * (selectedOffer?.discountedPrice ?? 0.0)))}"
                                    //         : "₹ ${pricingData?.total ?? (count * (pricingData?.currentPricePerSlot ?? widget.lobby.priceDetails?.price ?? 0.0))}"
                                    //     : (widget.lobby.priceDetails?.price !=
                                    //             0.0)
                                    //         ? (selectedOffer?.discountedPrice !=
                                    //                 null)
                                    //             ? "₹ ${(count * (widget.lobby.priceDetails?.price ?? 0.0)) - (count * ((widget.lobby.priceDetails?.price ?? 0.0) - (selectedOffer?.discountedPrice ?? 0.0)))}"
                                    //             : "₹ ${count * (widget.lobby.priceDetails?.price ?? 0.0)}"
                                    //         : "₹ 0.0",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF323232),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.lobby.priceDetails?.price != 0.0 && !widget.lobby.isAdvancedPricing) ...[
                Space.h(height: 24),
                DesignTextField(
                  hintText: "Have a coupon code ?",
                  borderRadius: 18,
                  suffixIcon: couponState.isLoading
                      ? SizedBox(
                          width: 8,
                          height: 8,
                          child: CircularProgressIndicator(
                            padding: EdgeInsets.all(12),
                            strokeWidth: 2,
                            color: const Color(0xFFEC4B5D),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            // If field is empty, don't validate
                            if (_couponController.text.trim().isEmpty) {
                              return;
                            }

                            // If already validated, clear the coupon
                            if (couponState.validatedOffer != null) {
                              _couponController.clear();
                              ref.read(couponProvider.notifier).clearCoupon();
                              ref.read(selectedOfferProvider.notifier).state = null;
                            } else {
                              _validateCoupon();
                            }
                          },
                          child: ((couponState.validatedOffer == null) && couponState.errorMessage == null)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: DesignText(
                                        text: 'Apply',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: DesignColors.accent,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              : DesignIcon.icon(
                                  icon: couponState.validatedOffer != null
                                      ? Icons
                                            .done_outlined // Change to  icon for removal
                                      : couponState.errorMessage != null
                                      ? Icons
                                            .error_outline_rounded // Show error icon for invalid codes
                                      : Icons.arrow_forward_ios_rounded, // Default arrow icon
                                  color: couponState.validatedOffer != null
                                      ? Colors.green
                                      : couponState.errorMessage != null
                                      ? Colors.red
                                      : const Color(0xFFEC4B5D),
                                  size: 16,
                                ),
                        ),
                  controller: _couponController,
                  errorText: couponState.errorMessage,
                  onChanged: (val) {
                    // Update coupon code in provider for any change
                    final upperVal = val?.trim().toUpperCase() ?? '';
                    ref.read(selectedOfferProvider.notifier).state = null;
                    ref.read(couponProvider.notifier).clearCoupon();
                    ref.read(couponProvider.notifier).updateCouponCode(upperVal);
                  },
                  onEditingComplete: () {
                    if (_couponController.text.trim().isNotEmpty) {
                      ref.read(selectedOfferProvider.notifier).state = null;
                      _validateCoupon();
                    }
                  },
                ),
              ],
              if (widget.lobby.priceDetails?.price != 0.0 &&
                  widget.lobby.hasOffer &&
                  !widget.lobby.isAdvancedPricing) ...[
                Space.h(height: 24),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.applyOffers.replaceAll(':lobbyId', widget.lobby.id)),
                  child: Card(
                    elevation: 4,
                    shadowColor: const Color(0x143E79A1),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        gradient: LinearGradient(
                          // transform: const TranslationGradientTransform(
                          //     offset: Offset(10, 0)),
                          transform: const CustomGradientTransform(scale: 4),
                          begin: const Alignment(-1, -0.02),
                          end: const Alignment(1, 0.02),
                          // 91.16deg is approximately the same as going from left to right
                          colors: [Colors.white.withOpacity(0.8), const Color(0x14EC4A5D)],
                          stops: const [0.0986, 0.949], // Corresponding to 1.86% and 94.9%
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          DesignIcon.icon(icon: Icons.local_offer_outlined, color: const Color(0xFFEC4B5D)),
                          Space.w(width: 14),
                          DesignText(
                            text: "Apply Offers",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF323232),
                          ),
                          const Spacer(),
                          if (selectedOffer != null) ...[
                            DesignText(
                              text:
                                  "${selectedOffer.discountValue} ${(selectedOffer.discountType == 'PERCENTAGE') ? "%" : "INR"}",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF323232),
                            ),
                            Space.w(width: 16),
                          ],
                          DesignIcon.icon(
                            icon: Icons.arrow_forward_ios_rounded,
                            color: const Color(0xFFEC4B5D),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              if (formList.isNotEmpty) ...[
                Space.h(height: 24),
                // if (widget.formModel != null)
                //   formCard(
                //     tileText: "Your form response",
                //     formIndex: 0,
                //   ),
                if (count > 0)
                  ...List.generate(count, (index) {
                    if (index == 0) {
                      return formCard(tileText: "Your form response", formIndex: 0, lobbyId: widget.lobby.id);
                    }
                    return formCard(tileText: "Form for slot ${index + 1}", formIndex: index, lobbyId: widget.lobby.id);
                  }),
              ],
              Space.h(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                color: Colors.white,
                elevation: 8,
                shadowColor: const Color(0x143E79A1),
                child: Container(
                  width: 1 * sw,
                  // height: 180,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DesignText(
                        text: "User Details ",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF323232),
                      ),
                      Space.h(height: 18),
                      DesignText(
                        text: profileController.profileData.value?.name ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232),
                      ),
                      Space.h(height: 4),
                      DesignText(
                        text: profileController.profileData.value?.email ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232),
                      ),
                      Space.h(height: 4),
                      DesignText(
                        text: profileController.profileData.value?.userName ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232),
                      ),
                    ],
                  ),
                ),
              ),
              // if (widget.lobby.priceDetails?.price != 0.0) ...[
              //   Space(height: 24),
              //   Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(24)),
              //     color: Colors.white,
              //     elevation: 8,
              //     shadowColor: const Color(0x143E79A1),
              //     child: Container(
              //       width: 1.sw,
              //       // height: 180,
              //       padding:
              //           EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              //       child: DottedBorder(
              //         color: const Color(0xFFBBBCBD),
              //         strokeWidth: 0.6,
              //         radius: Radius.circular(12),
              //         dashPattern: const [6, 3],
              //         borderType: BorderType.RRect,
              //         child: Container(
              //           padding: EdgeInsets.all(10),
              //           child: Row(
              //             children: [
              //               const Icon(
              //                 Icons.add_circle_outline_rounded,
              //                 color: Color(0xFF3E79A1),
              //               ),
              //               Space(width: 18),
              //               DesignText(
              //                 text: "Add new card",
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w500,
              //                 color: const Color(0xFF3E79A1),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ],
              Space.h(height: 24),
              const EventGuidelinesGrid(),
              Space.h(height: 48),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    DesignIcon.icon(icon: Icons.info_outline_rounded, color: const Color(0xFF3E79A1)),
                    Space.w(width: 8),
                    Expanded(
                      child: DesignText(
                        text:
                            'By Proceeding,  I express my consent to complete this transaction and accept lobby joining guideline.',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF444444),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formCard({required String tileText, required int formIndex, required String lobbyId}) {
    final isExpanded = ref.watch(expandStateProvider(tileText));

    return GestureDetector(
      onTap: () {
        toggle(ref, tileText);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.only(bottom: (formIndex == ref.watch(formsListProvider).length - 1) ? 0 : 16),
        shadowColor: const Color(0x143E79A1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isExpanded ? Colors.white : const Color(0xFFF9F9F9),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  DesignIcon.icon(icon: Icons.description_outlined, color: const Color(0xFFEC4B5D)),
                  Space.w(width: 14),
                  DesignText(text: tileText, fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF323232)),
                  const Spacer(),
                  DesignIcon.icon(
                    icon: isExpanded ? Icons.expand_less : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFFEC4B5D),
                    size: 16,
                  ),
                ],
              ),
              if (isExpanded) ...[
                Space.h(height: 16),
                _buildFormQuestions(formIndex: formIndex, lobbyId: lobbyId),
                Space.h(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormQuestions({required int formIndex, required String lobbyId}) {
    final formNotifier = ref.read(formsListProvider.notifier);
    final formListData = ref.watch(formsListProvider);
    final formData = formListData[formIndex];
    kLogger.trace("message formdata :  $formData");

    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Form title
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: DesignText(
        //     text: formState.title,
        //     fontSize: 16,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),

        // Form questions
        Padding(
          // constraints: BoxConstraints(maxHeight: 0.6.sh),
          padding: EdgeInsets.only(bottom: 0.1 * sh),
          child: formData.questions.isEmpty
              ? FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 2500)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFEC4B5D)));
                    } else {
                      return Center(
                        child: DesignText(
                          text: "No questions found",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF323232),
                        ),
                      );
                    }
                  },
                )
              : Column(
                  children: List.generate(formData.questions.length, (index) {
                    final question = formData.questions[index];

                    // Text question
                    if (question.questionType == 'text') {
                      final controller = formNotifier.getControllerForQuestion(formIndex, question.id);

                      if (controller == null) {
                        return const SizedBox.shrink();
                      }

                      // Make sure controller has the latest value
                      if (controller.text != question.answer.toString()) {
                        controller.text = question.answer.toString();
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Card(
                          shadowColor: Color(0x143E79A1),
                          elevation: 6,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 18, top: 12, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(text: question.questionText.trim()),
                                      if (question.isMandatory)
                                        TextSpan(
                                          text: '   *',
                                          style: TextStyle(color: Color(0xFFEC4B5D)),
                                        ),
                                    ],
                                  ),
                                ),
                                Space.h(height: 12),
                                DesignTextField(
                                  controller: controller,
                                  hintText: "Answer",
                                  fontSize: 12,
                                  onChanged: (val) => formNotifier.updateAnswer(formIndex, question.id, val!),
                                  borderRadius: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    // Number question
                    else if (question.questionType == 'number') {
                      final controller = formNotifier.getControllerForQuestion(formIndex, question.id);

                      if (controller == null) {
                        return const SizedBox.shrink();
                      }

                      // Make sure controller has the latest value
                      if (controller.text != question.answer) {
                        controller.text = question.answer;
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Card(
                          shadowColor: Color(0x143E79A1),
                          elevation: 6,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 18, top: 12, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(text: question.questionText.trim()),
                                      if (question.isMandatory)
                                        TextSpan(
                                          text: '   *',
                                          style: TextStyle(color: Color(0xFFEC4B5D)),
                                        ),
                                    ],
                                  ),
                                ),
                                Space.h(height: 12),
                                DesignTextField(
                                  controller: controller,
                                  hintText: "Enter a number",
                                  fontSize: 12,
                                  inputType: TextInputType.number,
                                  onEditingComplete: () {
                                    if (controller.text != null) {
                                      if (controller.text.isEmpty || RegExp(r'^\d+$').hasMatch(controller.text)) {
                                        formNotifier.updateAnswer(formIndex, question.id, controller.text);
                                      } else {
                                        // Revert to previous valid value
                                        controller.text = question.answer;
                                        controller.selection = TextSelection.fromPosition(
                                          TextPosition(offset: controller.text.length),
                                        );
                                        // Show error message
                                        Fluttertoast.showToast(
                                          msg: "Please enter digits only",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                      }
                                    }
                                  },
                                  onChanged: (val) {
                                    // Validate: only allow digits
                                    if (val != null) {
                                      if (val.isEmpty || RegExp(r'^\d+$').hasMatch(val)) {
                                        formNotifier.updateAnswer(formIndex, question.id, val);
                                      } else {
                                        // Revert to previous valid value
                                        controller.text = question.answer;
                                        controller.selection = TextSelection.fromPosition(
                                          TextPosition(offset: controller.text.length),
                                        );
                                        // Show error message
                                        // Fluttertoast.showToast(
                                        //   msg: "Please enter digits only",
                                        //   toastLength: Toast.LENGTH_SHORT,
                                        //   gravity: ToastGravity.BOTTOM,
                                        //   backgroundColor: Colors.red,
                                        //   textColor: Colors.white,
                                        // );
                                      }
                                    }
                                  },
                                  borderRadius: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    // Email question
                    else if (question.questionType == 'email') {
                      final controller = formNotifier.getControllerForQuestion(formIndex, question.id);

                      if (controller == null) {
                        return const SizedBox.shrink();
                      }

                      // Make sure controller has the latest value
                      if (controller.text != question.answer) {
                        controller.text = question.answer;
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Card(
                          shadowColor: Color(0x143E79A1),
                          elevation: 6,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 18, top: 12, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(text: question.questionText.trim()),
                                      if (question.isMandatory)
                                        TextSpan(
                                          text: '   *',
                                          style: TextStyle(color: Color(0xFFEC4B5D)),
                                        ),
                                    ],
                                  ),
                                ),
                                Space.h(height: 12),
                                DesignTextField(
                                  controller: controller,
                                  hintText: "Enter your email",
                                  fontSize: 12,
                                  inputType: TextInputType.emailAddress,
                                  onEditingComplete: () {
                                    if (controller.text.isNotEmpty &&
                                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(controller.text)) {
                                      // Show warning but don't revert the text
                                      Fluttertoast.showToast(
                                        msg: "Please enter a valid email address",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.orange,
                                        textColor: Colors.white,
                                      );
                                    }
                                  },
                                  onChanged: (val) {
                                    if (val != null) {
                                      // Update the answer regardless of validation
                                      formNotifier.updateAnswer(formIndex, question.id, val);

                                      // Validate email format if not empty
                                      if (val.isNotEmpty &&
                                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                                        // Show warning but don't revert the text
                                        // Fluttertoast.showToast(
                                        //   msg: "Please enter a valid email address",
                                        //   toastLength: Toast.LENGTH_SHORT,
                                        //   gravity: ToastGravity.BOTTOM,
                                        //   backgroundColor: Colors.orange,
                                        //   textColor: Colors.white,
                                        // );
                                      }
                                    }
                                  },
                                  borderRadius: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    // Date question
                    else if (question.questionType == 'date') {
                      final controller = formNotifier.getControllerForQuestion(formIndex, question.id);

                      if (controller == null) {
                        return const SizedBox.shrink();
                      }

                      // Make sure controller has the latest value
                      if (controller.text != question.answer) {
                        controller.text = question.answer;
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Card(
                          shadowColor: Color(0x143E79A1),
                          elevation: 6,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 18, top: 12, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(text: question.questionText.trim()),
                                      if (question.isMandatory)
                                        TextSpan(
                                          text: '   *',
                                          style: TextStyle(color: Color(0xFFEC4B5D)),
                                        ),
                                    ],
                                  ),
                                ),
                                Space.h(height: 12),
                                InkWell(
                                  onTap: () async {
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: controller.text.isNotEmpty
                                          ? DateTime.parse(controller.text)
                                          : DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: DesignColors.accent,
                                              onPrimary: Colors.white,
                                              surface: Colors.white,
                                              onSurface: Color(0xFF262933),
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: DesignColors.accent,
                                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (picked != null) {
                                      // Format date as ISO string for storage
                                      final formattedDate = picked.toIso8601String();
                                      controller.text = formattedDate;
                                      formNotifier.updateAnswer(formIndex, question.id, formattedDate);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: DesignColors.border),
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.text.isNotEmpty ? _formatDate(controller.text) : "Select a date",
                                          style: TextStyle(
                                            color: controller.text.isNotEmpty ? Colors.black : Colors.grey,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    // File question
                    else if (question.questionType == 'file') {
                      final controller = formNotifier.getControllerForQuestion(formIndex, question.id);

                      if (controller == null) {
                        return const SizedBox.shrink();
                      }

                      // Make sure controller has the latest value
                      if (controller.text != question.answer) {
                        controller.text = question.answer;
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Card(
                          shadowColor: Color(0x143E79A1),
                          elevation: 6,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 18, top: 12, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(text: question.questionText.trim()),
                                      if (question.isMandatory)
                                        TextSpan(
                                          text: '   *',
                                          style: TextStyle(color: Color(0xFFEC4B5D)),
                                        ),
                                    ],
                                  ),
                                ),
                                Space.h(height: 8),
                                Text(
                                  "Accepts PDF, PNG, JPG, MP4 files (Max 50MB)",
                                  style: TextStyle(fontSize: 10, color: Colors.grey, fontFamily: 'Poppins'),
                                ),
                                Space.h(height: 12),
                                InkWell(
                                  onTap: () async {
                                    try {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'mp4'],
                                        withData: true, // Required for web
                                      );

                                      if (result != null && result.files.single.bytes != null) {
                                        // Get file data for web
                                        final file = result.files.single;
                                        final bytes = file.bytes!;
                                        final filename = file.name;

                                        // Check file size (50MB = 50 * 1024 * 1024 bytes)
                                        if (bytes.length > 50 * 1024 * 1024) {
                                          Fluttertoast.showToast(
                                            msg: "File size exceeds 50MB limit",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                          );
                                          return;
                                        }

                                        // Show loading indicator
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.transparent,
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircularProgressIndicator(color: DesignColors.accent),
                                                  SizedBox(height: 16),
                                                  Text("Uploading file...", style: TextStyle(color: Colors.white)),
                                                ],
                                              ),
                                            );
                                          },
                                        );

                                        // Upload file
                                        try {
                                          final uploadBody = {
                                            'userId': await GetStorage().read("userUID") ?? '',
                                            'lobbyId': lobbyId,
                                            'questionId': question.id,
                                          };

                                          final result = await FileUploadService().uploadBytes(
                                            "user/upload/api/v1/file",
                                            bytes,
                                            filename,
                                            uploadBody,
                                          );

                                          // Close loading dialog
                                          Navigator.pop(context);

                                          if (result.statusCode == 200) {
                                            String fileUrl = result.data['imageUrl'];
                                            controller.text = fileUrl;
                                            formNotifier.updateAnswer(formIndex, question.id, fileUrl);

                                            Fluttertoast.showToast(
                                              msg: "File uploaded successfully",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            );
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: "Failed to upload file",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                            );
                                          }
                                        } catch (e) {
                                          // Close loading dialog
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                            msg: "Error uploading file: $e",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                          );
                                        }
                                      }
                                    } catch (e, s) {
                                      kLogger.error("Error selecting file:", error: e, stackTrace: s);
                                      Fluttertoast.showToast(
                                        msg: "Error selecting file: $e",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: DesignColors.border),
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    child: controller.text.isEmpty
                                        ? Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: Colors.grey.shade300, width: 1),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.05),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.cloud_upload_outlined,
                                                  color: Colors.grey.shade600,
                                                  size: 24,
                                                ),
                                                SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    "Upload File",
                                                    style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Icon(Icons.add, color: Colors.grey.shade600, size: 20),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  if (_isImageFile(controller.text))
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.network(
                                                        controller.text,
                                                        height: 120,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) =>
                                                            Icon(Icons.image, size: 50, color: Colors.grey),
                                                      ),
                                                    )
                                                  else if (_isPdfFile(controller.text))
                                                    Icon(Icons.picture_as_pdf, size: 50, color: Colors.red)
                                                  else if (_isVideoFile(controller.text))
                                                    Icon(Icons.video_file, size: 50, color: Colors.blue),
                                                  IconButton(
                                                    style: IconButton.styleFrom(
                                                      backgroundColor: Colors.white,
                                                      minimumSize: Size(32, 32),
                                                      maximumSize: Size(32, 32),
                                                    ),
                                                    icon: Icon(Icons.close, color: Colors.black, size: 16),
                                                    onPressed: () {
                                                      controller.clear();
                                                      formNotifier.updateAnswer(formIndex, question.id, '');
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                _getFileNameFromUrl(controller.text),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    // URL question
                    else if (question.questionType == 'url') {
                      final controller = formNotifier.getControllerForQuestion(formIndex, question.id);

                      if (controller == null) {
                        return const SizedBox.shrink();
                      }

                      // Make sure controller has the latest value
                      if (controller.text != question.answer) {
                        controller.text = question.answer;
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Card(
                          shadowColor: Color(0x143E79A1),
                          elevation: 6,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 18, top: 12, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(text: question.questionText.trim()),
                                      if (question.isMandatory)
                                        TextSpan(
                                          text: '   *',
                                          style: TextStyle(color: Color(0xFFEC4B5D)),
                                        ),
                                    ],
                                  ),
                                ),
                                Space.h(height: 12),
                                DesignTextField(
                                  controller: controller,
                                  hintText: "Enter URL",
                                  fontSize: 12,
                                  inputType: TextInputType.url,
                                  onEditingComplete: () {
                                    kLogger.trace(isValidUrl(controller.text).toString());
                                    // Validate URL format if not empty
                                    if (controller.text.isNotEmpty && !isValidUrl(controller.text)) {
                                      // Show warning but don't revert the text
                                      Fluttertoast.showToast(
                                        msg: "Please enter a valid URL",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.orange,
                                        textColor: Colors.white,
                                      );
                                    }
                                  },
                                  onChanged: (val) {
                                    if (val != null) {
                                      // Update the answer regardless of validation
                                      formNotifier.updateAnswer(formIndex, question.id, val);

                                      // Validate URL format if not empty
                                      // if (val.isNotEmpty && !_isValidUrl(val)) {
                                      //   // Show warning but don't revert the text
                                      //   Fluttertoast.showToast(
                                      //     msg: "Please enter a valid URL",
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.BOTTOM,
                                      //     backgroundColor: Colors.orange,
                                      //     textColor: Colors.white,
                                      //   );
                                      // }
                                    }
                                  },
                                  borderRadius: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    // Multiple choice question
                    else if (question.questionType == 'multiple-choice') {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Card(
                          shadowColor: Color(0x143E79A1),
                          elevation: 6,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 18, top: 12, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(text: question.questionText.trim()),
                                      if (question.isMandatory)
                                        TextSpan(
                                          text: '   *',
                                          style: TextStyle(color: Color(0xFFEC4B5D)),
                                        ),
                                    ],
                                  ),
                                ),
                                Space.h(height: 12),
                                ...question.options.map((option) {
                                  return CheckboxListTile(
                                    title: DesignText(
                                      text: option,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF444444),
                                    ),
                                    value: question.answer == option,
                                    onChanged: (val) {
                                      if (val != null && val) {
                                        formNotifier.updateAnswer(formIndex, question.id, option);
                                      }
                                    },
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    activeColor: const Color(0xFFEC4B5D),
                                    checkColor: Colors.white,
                                    controlAffinity: ListTileControlAffinity.leading,
                                    dense: true,
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    // Default fallback for unsupported question types
                    return Container();
                  }),
                ),
        ),
      ],
    );
  }

  // Helper method to format date for display
  String _formatDate(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (e) {
      return isoString; // Return original string if parsing fails
    }
  }

  // Helper method to extract file name from URL
  String _getFileNameFromUrl(String url) {
    try {
      return url.split('/').last;
    } catch (e) {
      return url; // Return original URL if extraction fails
    }
  }

  bool isValidUrl(String url) {
    if (url.isEmpty || url.trim().isEmpty) return false;

    String cleanUrl = url.trim();

    // Basic sanity checks
    if (cleanUrl.length < 3 ||
        cleanUrl.contains(' ') ||
        cleanUrl.contains('\n') ||
        cleanUrl.contains('\t') ||
        cleanUrl.contains('\r')) {
      return false;
    }

    // Remove protocol if present to check the domain part
    String domainPart = cleanUrl;
    bool hasProtocol = false;

    if (cleanUrl.startsWith('http://')) {
      domainPart = cleanUrl.substring(7);
      hasProtocol = true;
    } else if (cleanUrl.startsWith('https://')) {
      domainPart = cleanUrl.substring(8);
      hasProtocol = true;
    }

    // Remove path, query, and fragment to isolate domain
    domainPart = domainPart.split('/')[0].split('?')[0].split('#')[0];

    // Handle port
    String domain = domainPart.split(':')[0];

    // Domain must not be empty after all parsing
    if (domain.isEmpty) return false;

    // Validate the domain structure BEFORE trying Uri.parse
    if (!_isValidDomainStructure(domain)) {
      return false;
    }

    // Now try to parse with https if no protocol
    String urlToParse = hasProtocol ? cleanUrl : 'https://$cleanUrl';

    // Additional attempt with www if needed
    if (!hasProtocol && !cleanUrl.startsWith('www.') && !_isIpAddress(domain)) {
      String urlWithWww = 'https://www.$cleanUrl';
      Uri? uriWithWww = Uri.tryParse(urlWithWww);
      if (uriWithWww != null && _isValidParsedUri(uriWithWww)) {
        return true;
      }
    }

    Uri? uri = Uri.tryParse(urlToParse);
    return uri != null && _isValidParsedUri(uri);
  }

  bool _isValidDomainStructure(String domain) {
    if (domain.isEmpty || domain.length > 253) return false;

    // Handle localhost
    if (domain == 'localhost') return true;

    // Check if it's an IP address
    if (_isIpAddress(domain)) {
      return _isValidIpAddress(domain);
    }

    // For domain names, must contain at least one dot
    if (!domain.contains('.')) return false;

    // Cannot start or end with dot or hyphen
    if (domain.startsWith('.') || domain.endsWith('.') || domain.startsWith('-') || domain.endsWith('-')) {
      return false;
    }

    // Cannot contain consecutive dots
    if (domain.contains('..')) return false;

    // Split into labels and validate each
    final labels = domain.split('.');
    if (labels.length < 2) return false;

    for (int i = 0; i < labels.length; i++) {
      final label = labels[i];
      if (!_isValidDomainLabel(label, i == labels.length - 1)) {
        return false;
      }
    }

    return true;
  }

  bool _isValidDomainLabel(String label, bool isTLD) {
    if (label.isEmpty || label.length > 63) return false;

    // Cannot start or end with hyphen
    if (label.startsWith('-') || label.endsWith('-')) return false;

    // Must contain only alphanumeric characters and hyphens
    if (!RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(label)) return false;

    // If it's a TLD (last label), additional validation
    if (isTLD) {
      // TLD must be at least 2 characters
      if (label.length < 2) return false;

      // TLD should contain at least one letter
      if (!RegExp(r'[a-zA-Z]').hasMatch(label)) return false;

      // Common valid TLD patterns - reject obvious random strings
      if (!_isValidTLD(label)) return false;
    } else {
      // Non-TLD labels cannot be all hyphens or have weird patterns
      if (RegExp(r'^-+$').hasMatch(label)) return false;
    }

    return true;
  }

  bool _isValidTLD(String tld) {
    // Convert to lowercase for checking
    String lowerTLD = tld.toLowerCase();

    // List of definitely invalid TLDs (random letter combinations)
    final obviouslyInvalid = {
      'aa',
      'bb',
      'cc',
      'dd',
      'ee',
      'ff',
      'gg',
      'hh',
      'ii',
      'jj',
      'kk',
      'll',
      'mm',
      'nn',
      'oo',
      'pp',
      'qq',
      'rr',
      'ss',
      'tt',
      'uu',
      'vv',
      'ww',
      'xx',
      'yy',
      'zz',
      'aaa',
      'bbb',
      'ccc',
      'ddd',
      'eee',
      'fff',
      'ggg',
      'hhh',
      'iii',
      'jjj',
      'kkk',
      'lll',
      'mmm',
      'nnn',
      'ooo',
      'ppp',
      'qqq',
      'rrr',
      'sss',
      'ttt',
      'uuu',
      'vvv',
      'www',
      'xxx',
      'yyy',
      'zzz',
    };

    if (obviouslyInvalid.contains(lowerTLD)) return false;

    // Check for common valid TLD patterns
    // Real TLDs usually have meaningful patterns
    final commonValidTLDs = {
      'com',
      'org',
      'net',
      'gov',
      'edu',
      'mil',
      'int',
      'co',
      'io',
      'ai',
      'me',
      'uk',
      'us',
      'ca',
      'au',
      'de',
      'fr',
      'jp',
      'cn',
      'in',
      'br',
      'mx',
      'ru',
      'info',
      'biz',
      'name',
      'pro',
      'aero',
      'asia',
      'cat',
      'coop',
      'jobs',
      'mobi',
      'museum',
      'post',
      'tel',
      'travel',
      'xxx',
      'app',
      'dev',
      'tech',
      'online',
      'site',
      'website',
      'store',
      'blog',
      'news',
      'today',
      'world',
    };

    // If it's a common valid TLD, accept it
    if (commonValidTLDs.contains(lowerTLD)) return true;

    // For other TLDs, check if they look reasonable
    // Real TLDs typically:
    // 1. Are not random character sequences
    // 2. Have vowels and consonants mixed reasonably
    // 3. Don't have repeating patterns

    // Check for reasonable letter distribution
    if (lowerTLD.length >= 3) {
      // Count vowels
      int vowels = 0;
      for (int i = 0; i < lowerTLD.length; i++) {
        if ('aeiou'.contains(lowerTLD[i])) vowels++;
      }

      // Should have at least one vowel for longer TLDs
      if (vowels == 0 && lowerTLD.length > 3) return false;

      // Check for excessive repetition
      if (RegExp(r'(.)\1{2,}').hasMatch(lowerTLD)) return false;
    }

    // If it passes basic checks and isn't obviously invalid, accept it
    return true;
  }

  bool _isIpAddress(String host) {
    // IPv4 pattern
    if (RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$').hasMatch(host)) {
      return true;
    }

    // Basic IPv6 pattern (simplified)
    if (host.contains(':') && RegExp(r'^[0-9a-fA-F:]+$').hasMatch(host)) {
      return true;
    }

    return false;
  }

  bool _isValidIpAddress(String host) {
    // IPv4 validation
    final ipv4Pattern = RegExp(r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$');
    final match = ipv4Pattern.firstMatch(host);

    if (match != null) {
      for (int i = 1; i <= 4; i++) {
        final octet = int.tryParse(match.group(i)!);
        if (octet == null || octet < 0 || octet > 255) {
          return false;
        }
      }
      return true;
    }

    // IPv6 basic validation
    if (host.contains(':')) {
      final parts = host.split(':');
      if (parts.length > 8) return false;

      for (final part in parts) {
        if (part.isNotEmpty && (part.length > 4 || !RegExp(r'^[0-9a-fA-F]+$').hasMatch(part))) {
          return false;
        }
      }
      return true;
    }

    return false;
  }

  bool _isValidParsedUri(Uri uri) {
    // Must be http or https
    if (uri.scheme != 'http' && uri.scheme != 'https') return false;

    // Must have a valid host
    if (uri.host.isEmpty) return false;

    // Final validation of the host
    return _isValidDomainStructure(uri.host);
  }

  // Helper functions to check file types
  bool _isImageFile(String url) {
    final ext = url.toLowerCase().split('.').last;
    return ['png', 'jpg', 'jpeg'].contains(ext);
  }

  bool _isPdfFile(String url) {
    return url.toLowerCase().endsWith('.pdf');
  }

  bool _isVideoFile(String url) {
    return url.toLowerCase().endsWith('.mp4');
  }

  String calculateTotalPrice({required PricingResponse? pricingData, Offer? selectedOffer}) {
    double total = pricingData?.total ?? 0.0;
    if (selectedOffer != null) {
      if (selectedOffer.discountType == 'PERCENTAGE') {
        // double percentage = selectedOffer.discountValue;
        double discount = double.parse(calculateDiscount(pricingData: pricingData, selectedOffer: selectedOffer));
        total = total - discount;
      } else if (selectedOffer.discountType == 'FLAT') {
        total = total - selectedOffer.discountValue;
      }
    }

    return (total.toString() == "0.0" || total.toString() == "0") ? "0.0" : total.toString();
  }

  String calculateDiscount({required PricingResponse? pricingData, Offer? selectedOffer}) {
    double discount = 0.0;
    double total = pricingData?.total ?? 0.0;
    if (selectedOffer != null) {
      if (selectedOffer.discountType == 'PERCENTAGE') {
        double percentage = selectedOffer.discountValue;
        discount = (total * percentage) / 100;
      } else if (selectedOffer.discountType == 'FLAT') {
        discount = selectedOffer.discountValue;
      }
    }

    return discount.toString();
  }

  // Method to validate the coupon
  void _validateCoupon() {
    kLogger.trace("validating coupon");
    // Hide keyboard
    FocusScope.of(context).unfocus();

    final couponCode = _couponController.text.trim();
    if (couponCode.isEmpty) {
      // Clear any existing coupon
      ref.read(couponProvider.notifier).clearCoupon();
      ref.read(selectedOfferProvider.notifier).state = null;
      return;
    }

    ref.read(couponProvider.notifier).validateCoupon(widget.lobby.id, "LOBBY");
  }
}

class GuidelineCard extends StatelessWidget {
  final String title;
  final String description;
  final DesignIcons icon;

  const GuidelineCard({super.key, required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF989898), width: 0.2),
        boxShadow: const [BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0, color: Color(0x0A3E79A1))],
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignIcon.custom(icon: icon, size: 32, color: const Color(0xFF323232)),
              SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                child: DesignText(
                  text: title,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3E79A1),
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 4),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: DesignText(
                    text: description,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF444444),
                    maxLines: 5,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class EventGuidelinesGrid extends StatelessWidget {
  const EventGuidelinesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final guidelines = [
      {
        'title': 'Respect the Space & People',
        'description':
            'Be mindful of the venue, hosts, and fellow attendees. Harassment or disruptive behavior won\'t be tolerated.',
        'icon': DesignIcons.respect,
      },
      {
        'title': 'No Last-Minute Dropouts',
        'description':
            'If you can\'t make it, cancel in advance. No-shows may affect your ability to join future events.',
        'icon': DesignIcons.doorOut,
      },
      {
        'title': 'Punctuality Matters',
        'description': 'Arrive on time to avoid missing key moments and to ensure a smooth experience for everyone.',
        'icon': DesignIcons.thumbClock,
      },
      {
        'title': 'Follow Event Guidelines',
        'description': 'Dress code, smoking/alcohol policies, and other house rules must be respected.',
        'icon': DesignIcons.law,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 350 ? 2 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1.2, // Adjust this value to control card height relative to width
          ),
          itemCount: guidelines.length,
          itemBuilder: (context, index) {
            final guideline = guidelines[index];
            return GuidelineCard(
              title: guideline['title'].toString(),
              description: guideline['description'].toString(),
              icon: guideline['icon'] as DesignIcons,
            );
          },
        );
      },
    );
  }
}

class TranslationGradientTransform extends GradientTransform {
  final Offset offset;

  const TranslationGradientTransform({required this.offset});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    // This applies a translation transformation to the gradient.
    return Matrix4.translationValues(offset.dx, offset.dy, 0);
  }
}

class CustomGradientTransform extends GradientTransform {
  final double scale;

  const CustomGradientTransform({this.scale = 1.0});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    // Applies a scaling transformation.
    return Matrix4.diagonal3Values(scale, scale, 1.0);
  }
}
