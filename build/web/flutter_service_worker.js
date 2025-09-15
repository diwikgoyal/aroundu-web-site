'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".well-known/apple-app-site-association.txt": "7e9de2705b35233e9b76923441f874fb",
".well-known/assetlinks.json": "d9adc5e27d8a698c7b1f2435456d76b4",
"assets/AssetManifest.bin": "595de2d23873410f1d90e8a2302471c0",
"assets/AssetManifest.bin.json": "484cd32f69229fd7eb6dfd83aba9466c",
"assets/AssetManifest.json": "fde3b83f6d79cc0d881afb60b98749b2",
"assets/assets/animations/A.java": "ec7c5821f1ab13f647287385015ef4ef",
"assets/assets/animations/confetti.json": "ff63a9b38d34fece66ab25e011855e49",
"assets/assets/animations/heart_animation.json": "b51af82728e4c22dcc84e3ed646b2323",
"assets/assets/animations/lobby.json": "d5665ba7a48265699661d16c770de28e",
"assets/assets/animations/match_animation.json": "0c75701882fafbe194c8129f51299193",
"assets/assets/animations/payment_failed.json": "4c57e128a25339ac0b34d63ef57d6347",
"assets/assets/animations/payment_processing.json": "d34e04e11682f81de739332e32e72630",
"assets/assets/animations/payment_success.json": "cf26ccb61ece5bb6a2a2a9c6e9ab78b3",
"assets/assets/animations/red_heart_icon_animation.json": "1b11a38486b834147f886229ec88e534",
"assets/assets/animations/success_badge.json": "0704245c8ae47ce74e58697f6c0b8e34",
"assets/assets/appshots/house.png": "75453d1ca2aeae31c003da3e1d5fe057",
"assets/assets/appshots/lobby.png": "55d56cc12670f2adc8a68df481e83a3e",
"assets/assets/icons/all.svg": "9d8fe63a9ef832deeeb68915d8b185f8",
"assets/assets/icons/aroundu.icon.png": "32d8c66562fe753a962a8eddbbccdac5",
"assets/assets/icons/aroundu.png": "522e2bdabf31d36b0a6200871b69aea9",
"assets/assets/icons/badges.png": "28be722feaed756281da77236eb4768a",
"assets/assets/icons/cake.svg": "aba0819f04b48315d9d56b3988999f14",
"assets/assets/icons/calendar.svg": "7c05085c8acf42be0b819477e59c8c2b",
"assets/assets/icons/camera.svg": "509b5f47822bd6c1d5add4385d2f9bf5",
"assets/assets/icons/chat.svg": "a16f548c29bc721439d839de15653077",
"assets/assets/icons/chats.svg": "62d11de1f07e82ff411c60b5e4865905",
"assets/assets/icons/clock.svg": "8eeecba00ef54bc006bfb0285e3f0b1b",
"assets/assets/icons/closed.svg": "3e8d840a922b402f98f077d161e7fba6",
"assets/assets/icons/cocktail.svg": "5b8c2f31417a5efc341aaac351354bb3",
"assets/assets/icons/contactCalendar.svg": "8f12084bfea559421161c74a4f0da3c1",
"assets/assets/icons/day.svg": "44f663e98c31adb12dd29fb034c74d58",
"assets/assets/icons/delete.svg": "cc6d8c296b231757bae2482846ca9493",
"assets/assets/icons/disabled.svg": "09cad55d71821430baae7c8ab91954fb",
"assets/assets/icons/dog.svg": "e134a5618d7d1918bc6a69b465136554",
"assets/assets/icons/doorOut.svg": "94d0d308aecdbce8f4ac1fb4cd1d6870",
"assets/assets/icons/dressFemale.svg": "c225ee50c4c15f3742abe753812cdc8f",
"assets/assets/icons/edit.svg": "3dfb07024bcaa60e5887f728888c43c7",
"assets/assets/icons/evening.svg": "464696be1bf057ded1bada35bb000b04",
"assets/assets/icons/face.svg": "1aaf92314927754113e59b0ab55fc57f",
"assets/assets/icons/favorite_border.png": "d795ddb72bad894533d5e61656fd51ea",
"assets/assets/icons/form.svg": "10715efaeff5652c0266fde803520dab",
"assets/assets/icons/Frame%2520427320024%2520copy.png": "9b8240877bbbe65d04e793adae6976a0",
"assets/assets/icons/Frame%2520427320024.png": "9b8240877bbbe65d04e793adae6976a0",
"assets/assets/icons/gameController.svg": "56bdd68256c9686221748c4fdef2dfcd",
"assets/assets/icons/google.svg": "5789d0943ba877f253158ad4062a2032",
"assets/assets/icons/googleMaps.svg": "bd0db5db8780a0d5d256bdaeb6bcfad6",
"assets/assets/icons/groups.svg": "efe2dcf1207c883603556cfee79f7d94",
"assets/assets/icons/heart.svg": "11a22f83837fb2792f79a869614d4d9c",
"assets/assets/icons/home.svg": "1c7439940257e8d3e72f50908945857a",
"assets/assets/icons/importantDevices.svg": "356cf4dc2faef291375890e4fa8eb610",
"assets/assets/icons/law.svg": "f9b450fe91f6f8a61214021c7f2d9b39",
"assets/assets/icons/levelUp.svg": "f4199527e8740e2d43bc4c83166ae249",
"assets/assets/icons/localAtm.svg": "c5acfcd85be09dbdaa096f6d5e0ccf3c",
"assets/assets/icons/location.svg": "ca776b88291f8e01eb32e236c86fdeb3",
"assets/assets/icons/logo.svg": "b14997e48916868830f0361a0b264205",
"assets/assets/icons/match.svg": "c0bf23886f71f0c658e736cb49373f31",
"assets/assets/icons/medal.png": "7f5033ac8294491ee40c36141517d0c0",
"assets/assets/icons/message.png": "18418ce8e10a89991081a598e1a772d0",
"assets/assets/icons/milestone.png": "ba60f2679e6a0104221442361a093f63",
"assets/assets/icons/money.svg": "0e8aa3e6e659995dc495679981e6db22",
"assets/assets/icons/mood.png": "a1fe3a886d03deecd44faf5d0443af42",
"assets/assets/icons/morning.svg": "bb82f3588904e09f26aeb330df6759d7",
"assets/assets/icons/music.svg": "3469a3d54f0cf3640ab68fde575ffa33",
"assets/assets/icons/night.svg": "e456f061482a7b939739e6db50fd5963",
"assets/assets/icons/notifications.svg": "c55d96e16c896c0fba89833bdb63bc57",
"assets/assets/icons/ok.png": "3c2be143c69faf7877b5cd1ef00079f3",
"assets/assets/icons/past.svg": "ca05d60c5fbe88ac3fd610556e282bcf",
"assets/assets/icons/payment.svg": "e697fed832bae24df710241f802cee27",
"assets/assets/icons/pencil.svg": "69b332c53e0cfc8eb4fdb6ca95a7f1c9",
"assets/assets/icons/personAdd.svg": "ddcc699f8b7510e0d4e21bc40265cbf9",
"assets/assets/icons/profile.svg": "5d7a0f1f4f1373c9844b2d1dc3ffbd4e",
"assets/assets/icons/qr.svg": "93fc3ffceb03576a099b7cac8bb938ad",
"assets/assets/icons/qrSuccess.svg": "d47ed80f8d7b414e5d25c11d825edcf9",
"assets/assets/icons/question.svg": "4f9ece7a8528b82c9aa074cf219226a9",
"assets/assets/icons/respect.svg": "6ed0c7b836b8d3a6ab568d94853bc052",
"assets/assets/icons/rocket.svg": "a34dd39799570485e1262c37ede52479",
"assets/assets/icons/running.svg": "0845ecdd047cca09f4d72a5be07c1264",
"assets/assets/icons/search.svg": "4108d3297d6b59aa6b9a8c89cd5bb1d6",
"assets/assets/icons/share.png": "1bcc8b8f61ee95eff532bc4bb1820bb4",
"assets/assets/icons/shopAdd.svg": "bef2eac3a0f70fc0df23db41bbeb7d31",
"assets/assets/icons/slot.svg": "5bf841f0e569309f6be564f992678e6c",
"assets/assets/icons/smoking.svg": "7d85720b45d243c704e7fc28f4484199",
"assets/assets/icons/star.svg": "215aa49ef17863f39dc6f1ba20cfa741",
"assets/assets/icons/thumb.png": "2516e751186fd32ba6cad5c876329ec4",
"assets/assets/icons/thumbClock.svg": "6053add4eed22e0e6c6a6e64f4288c9e",
"assets/assets/icons/thumbsup.png": "b30de4fb31025648c0940e15b2a012a6",
"assets/assets/icons/tickUser.svg": "ba09d068508a8283caf0162258c49dd1",
"assets/assets/icons/upcoming.svg": "882e8f5f8c819340d6134449f81f0ad0",
"assets/assets/icons/veggies.svg": "90998b1a67c86b88d07c706108aa2f5b",
"assets/assets/icons/verifySvg.svg": "4266abeee8a7438b842b087dfe150313",
"assets/assets/icons/whatshot.png": "93f1a6b16ccfd198fa0cfefeecfc854e",
"assets/assets/icons/wifi.svg": "0a13a1efa348ab315f0f40cc2bc87039",
"assets/assets/icons.aroundu/airplane.png": "5134cc15136c5efc695cf210517cf065",
"assets/assets/icons.aroundu/atlas.png": "c4c5f9d651acf29287c19e59e998b6fc",
"assets/assets/icons.aroundu/badges.png": "d5643540e03326a0924658030bfa89d6",
"assets/assets/icons.aroundu/blacksmith.png": "309c30a2ebdb095b19141b9ae298d932",
"assets/assets/icons.aroundu/butterfly.png": "a2cd838c0c24a02a57b3a298553e0c59",
"assets/assets/icons.aroundu/caesar.png": "9845e816cc71efad68d8e1cfff0d7b1d",
"assets/assets/icons.aroundu/card_king_hearts.png": "51f043413e83040150893e36bae7ccf5",
"assets/assets/icons.aroundu/cityscape.png": "9142b1cae5b480515182899362ce5452",
"assets/assets/icons.aroundu/completed.png": "95261bfd7fe3dbdee570cf762752cad4",
"assets/assets/icons.aroundu/coronation.png": "40c1de3d758da1e69109fd4f186cac40",
"assets/assets/icons.aroundu/desk_lamp.png": "59b8c85038e975ed2c6a2aa8f4970dbb",
"assets/assets/icons.aroundu/diamond_trophy.png": "3d5f9299d2751ea4513b22e21799dfc9",
"assets/assets/icons.aroundu/empress.png": "455182378066470d4d074e3ffcd6328b",
"assets/assets/icons.aroundu/famicons_medal_sharp.png": "8ef68b671b972782dd65e6d0cca7e722",
"assets/assets/icons.aroundu/globe.png": "ddedcd41bfe2eba730fba6340db7d76d",
"assets/assets/icons.aroundu/locked_fortress.png": "b0e5acd5894b9e592477c6e7a3eab32d",
"assets/assets/icons.aroundu/megaphone.png": "b314923ace68b299c7c8bfe8876d91c7",
"assets/assets/icons.aroundu/minerals.png": "b864713a99a240fe71a435a21502535c",
"assets/assets/icons.aroundu/minions.png": "535d45d98a5b72073a29a6639a85ec27",
"assets/assets/icons.aroundu/mounted_knight.png": "8dc8d3c17a1e2886693194bcd5797d05",
"assets/assets/icons.aroundu/night_sky.png": "603a4b0c68e7fa1aed8e008195dcbdbb",
"assets/assets/icons.aroundu/round_table.png": "5e299c50bb943d3587c5297b29a9f1b3",
"assets/assets/icons.aroundu/shield_bash.png": "043bd94d9863943646a8f37f09426a50",
"assets/assets/icons.aroundu/solar_star_fall_bold.png": "f6a2316148e9542a0b39b539021783a4",
"assets/assets/icons.aroundu/sun_priest.png": "fad3d8f0c50980494274c54866d50468",
"assets/assets/icons.aroundu/swordwoman.png": "deb3383d9c199393d88de06bdaae7275",
"assets/assets/icons.aroundu/throne_king.png": "3aeb45e60486698a102f8f45043556fd",
"assets/assets/icons.aroundu/trophy.png": "5fa96078055d719f9e551c4fac94169f",
"assets/assets/icons.aroundu/wrestler.png": "96a6a262166e7a0ca8f5392b7efdd0ee",
"assets/assets/images/about_logo.png": "5c34e4c89ab3ecc4fc2294bb8de14412",
"assets/assets/images/account_settings.png": "59aba80ba96f6e09ebec7ae7e4f7d0d4",
"assets/assets/images/adhar_verify.png": "9f3d30892d9cb8c2aa94bd672e2a828d",
"assets/assets/images/aroundu-icon.jpeg": "3f80faff3c7785ee3bae02d2ed94efe4",
"assets/assets/images/aura_main_image.png": "eb090fc4a27b797107e883c318d37f82",
"assets/assets/images/aura_main_star.png": "77ce13464380c3ddbc88377b949a1cd2",
"assets/assets/images/auth_bg.png": "be533ca9be6f5944f99eb33eda6275c7",
"assets/assets/images/bg.svg": "d10e8cad6c1938e934b2ac70d222dd69",
"assets/assets/images/bgQrAdmin.png": "b3893bcbaf3e87c38ff3cbe949978ade",
"assets/assets/images/bgQrAttendee.png": "ae5a748919981cdc46f9b8f7557cc784",
"assets/assets/images/boost_your_visiblity.png": "043838d951fe4f12f8312f02da2ea3de",
"assets/assets/images/build_trust.png": "1af39fd6f16b0acfd841d5c04e0fd72b",
"assets/assets/images/calender.png": "68577c19756d2c0e0f547338ad567d55",
"assets/assets/images/cancel.png": "f6c22d1ca446e375c93c9db5cfc790d7",
"assets/assets/images/coins_zer_page.png": "640f1a4731ce580219e821af5c5d2217",
"assets/assets/images/create_paid_lobbies.png": "080fce3586c0fdcb7094cb047ffa050a",
"assets/assets/images/create_squads.png": "10f40294667dac9d5c3a82bd936b3c77",
"assets/assets/images/download_document.png": "156860503bb2afb735559d05116d13b9",
"assets/assets/images/earnbig.png": "6ac90860d094cbacb937e81a5c57c6b1",
"assets/assets/images/facebook.png": "2d949cc600bb586cf47d59ec52e8b6ab",
"assets/assets/images/Frame%25202.png": "711782debfb32282e12cac4bf6bbab09",
"assets/assets/images/Frame%2520427320024.png": "ef909c1132e30b47120ec0f285ee73f6",
"assets/assets/images/Gift.png": "07d37c02fc2b922544d00f459d70f500",
"assets/assets/images/gift_card.png": "8a6aae00680d6c2612be264fd84c372c",
"assets/assets/images/Group%252048095729.png": "9ef2e0ea7f6f7544bf8f5f6f81c25bfa",
"assets/assets/images/groups.png": "43c7d5800ad2f862a9118bbb33c60f2c",
"assets/assets/images/houseCard_bg.jpg": "f307cd349bfc719092850050e4810a35",
"assets/assets/images/house_coin.png": "9b4066b93f66300a8a21b34203fcfa80",
"assets/assets/images/insta.png": "7dc7c581ad076122c5a272e9a1c4507b",
"assets/assets/images/invite_friends.png": "459caf376a4024cc26537aaae4430a0c",
"assets/assets/images/is_account.png": "f487ebe79c679f9ad39374ba847c84a0",
"assets/assets/images/leader_board.png": "3c94df2493f742f7c0e734e3e289f8a5",
"assets/assets/images/lobby.gif": "7c39610da3363e32fd84d16b427d48c8",
"assets/assets/images/loby_ledgers.png": "4ac72deaa080f4a8e71106e140093e77",
"assets/assets/images/location.png": "eb80f4c6bb8eb2b8955068febbc072b2",
"assets/assets/images/logos_google-pay.png": "0cd06c80bf8d3e7ec6d97bdd88e2fc58",
"assets/assets/images/Mask_group.png": "1e6f26c5166d6c00fb2fca373c1426fa",
"assets/assets/images/medal.png": "f541f4f907111aa8209f865c3206041b",
"assets/assets/images/offer.png": "3c2885e9626279e6075203b882d12192",
"assets/assets/images/onboarding_1.png": "be7dd2ec9eaf0deae10e17dcbacaef33",
"assets/assets/images/onboarding_2.png": "6722c9db53d29629a56bf25c0f18fe3b",
"assets/assets/images/onboarding_3.png": "1d27c4b31a63325a9af0dfe8305cb74a",
"assets/assets/images/onboarding_4.png": "941bbba8c01024d478245a63ce47b9ce",
"assets/assets/images/onboarding_5.png": "fd7217aff8eccf2908fecb882c04d16b",
"assets/assets/images/panVerified.png": "6054473e75d6423870747c58a36829be",
"assets/assets/images/pan_upload_success.png": "2fee910bc28178d92276489f1fb6c046",
"assets/assets/images/party-friends-2018-celebrations.jpg": "4620716f057300b955e04b06e3e27ee6",
"assets/assets/images/payouttiming.png": "7e171da8f9ed20c45698140bfa9ff04a",
"assets/assets/images/peoples.gif": "a868460e18ed6f67ace8b367cae682f7",
"assets/assets/images/platformfee.png": "6bd9039de3748cee316862748241d8ac",
"assets/assets/images/pnb_logo.png": "d9070374e558b626f9cb053d9418a2ad",
"assets/assets/images/priority_access.png": "bbe526a2c28cf409ed26bd8db59ddf2f",
"assets/assets/images/privacy_policy.png": "e12ea85a1bfd7b848f433ec196782798",
"assets/assets/images/propfile_zero.png": "1e947cd944c161ca042b9105c92fbc59",
"assets/assets/images/rating_start.png": "e04d60ab5fd101954acaf09b15d2bb4c",
"assets/assets/images/refundpolicy.png": "0bcee86744f7795b7f02fb97aa482d67",
"assets/assets/images/review.gif": "99cfd28d269dbac9506eb1ce563cf0c2",
"assets/assets/images/securepay.png": "5bfc539e0c761af8a52ae0bf8adf10a7",
"assets/assets/images/servey_form.png": "ac5fc1e0f1b08b9c4e0e01caef3a55f2",
"assets/assets/images/settings.png": "b7701d4e33bd063fbe50965050317bd8",
"assets/assets/images/setup_payments.png": "422a865b69749a7dd2869645b375d2e2",
"assets/assets/images/set_up_payments.png": "ffed4f580fb8bf57a9ef54007952edc7",
"assets/assets/images/smoothsetup.png": "e32548cd47bc8b38c07df9dbbd825120",
"assets/assets/images/splash_bg.png": "fd351b083fa7318f4381c4e1139a5466",
"assets/assets/images/splash_bg_red.png": "ae59d747094249fd1549de8ce6d5452e",
"assets/assets/images/star.png": "f1dd84e5e8fa4230193afadedf5618d8",
"assets/assets/images/start.png": "a6843deb6ef032f863585cee43c61619",
"assets/assets/images/star_2.png": "fcff8187be14ba248197020fe812862c",
"assets/assets/images/star_3.png": "b6e3c9bd87d71ae8150015815ffa4c3d",
"assets/assets/images/success.png": "ca4cdc891b680ae2484a10fdb4ffb58d",
"assets/assets/images/t&c.png": "f2117c250a180b26e95f8f970db0488d",
"assets/assets/images/top_icon.png": "cc424edf10d52ed5682212b97892a281",
"assets/assets/images/transaction.png": "0abc3b7cf9f624796531df0976f8030d",
"assets/assets/images/transaction_image.png": "ad7cd859c20a5cb72dd416bc0b0a294c",
"assets/assets/images/upfrontpay.png": "cd7ea95365fe67cb8edd772fe8a627c2",
"assets/assets/images/Vector%2520(45).png": "803ecf61f488ef40b9f41ff9471643c3",
"assets/assets/images/vedio_varification.png": "5450045ae4fd2e7f288606423bf7ad7e",
"assets/assets/images/verify_aadhar.png": "de86dea080224aca63a8195843409b29",
"assets/assets/images/verify_pan_card.png": "866411bb580001c7f2591ed588b19be4",
"assets/assets/images/welcome.gif": "d6069c8f83312d7731d5eb21af050b19",
"assets/assets/images/welcome.png": "1fedb2c89722618fa10497e72b551e84",
"assets/assets/images/zero_page.png": "6b941d6aadd4321d214652e674cd7aea",
"assets/assets/images/zero_page_profile.png": "640f1a4731ce580219e821af5c5d2217",
"assets/FontManifest.json": "dd654f4cf6a67e86e7c9d8cee598bb07",
"assets/fonts/MaterialIcons-Regular.otf": "7ed2dde1b0022e669f97812b488ad4be",
"assets/fonts/poppins/Poppins_Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/fonts/poppins/Poppins_Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/fonts/poppins/Poppins_Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/fonts/poppins/Poppins_Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/fonts/poppins/Poppins_SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/NOTICES": "d24facc55552a5024c9414fbb109487b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6c293ea2fb78fb1ef4e09e19d8f8c229",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_cashfree_pg_sdk/assets/amex.png": "99f1d408e289af3e6359feffc5abc003",
"assets/packages/flutter_cashfree_pg_sdk/assets/credit-card-default.png": "e987949373676bb7b9a6bb85c19dba1b",
"assets/packages/flutter_cashfree_pg_sdk/assets/diners.png": "6bc0a26fbe98312d2cde3ca06a9b9518",
"assets/packages/flutter_cashfree_pg_sdk/assets/discover.png": "8fb5c3dd58ffb198644a9aac0d0a5da2",
"assets/packages/flutter_cashfree_pg_sdk/assets/jcb.png": "903e2793c61fc15e48fed184d6eadbe7",
"assets/packages/flutter_cashfree_pg_sdk/assets/maestro.png": "49f3167896883d38eb9770f6527fa961",
"assets/packages/flutter_cashfree_pg_sdk/assets/mastercard.png": "64dd58b0f24ee7bf272d964f508660bb",
"assets/packages/flutter_cashfree_pg_sdk/assets/rupay.png": "b6c88a3273204df54bc46e374b633570",
"assets/packages/flutter_cashfree_pg_sdk/assets/visa.png": "3442819455f79b208c50094bae6843e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "7c3f2cb8441fc8ea69d12a63418439a0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f1fbd9225c3951722cd33206d73c33e9",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "4123970ab8fcd2d16030d374b51bccb0",
"assets/packages/lucide_icons/assets/lucide.ttf": "03f254a55085ec6fe9a7ae1861fda9fd",
"assets/packages/quill_native_bridge_linux/assets/xclip": "d37b0dbbc8341839cde83d351f96279e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"cancellationrefund.html": "2eb75435cb5522d8687ab1832fa4d70a",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"contact.html": "0fa7c13b761298d349ca386453297bc2",
"deleteaccount.html": "49150f5f7b695b66c87376bda692fa7a",
"favicon.png": "77a3176365c9b04a4fd436d780e156bf",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "3b102fec164598766cd7005c3f202e32",
"icons/Icon-192.png": "96a4d880ea3fc2b1a302027ac36ac7a9",
"icons/Icon-512.png": "7c50b66bd0166a257da9ad89cc4a1493",
"icons/Icon-maskable-192.png": "96a4d880ea3fc2b1a302027ac36ac7a9",
"icons/Icon-maskable-512.png": "7c50b66bd0166a257da9ad89cc4a1493",
"index.html": "d048fe6fbbeb19cefb45a5fe8315bd4a",
"/": "d048fe6fbbeb19cefb45a5fe8315bd4a",
"main.dart.js": "f865350f25f46f30d82e1fd0006460d3",
"manifest.json": "3d737a73f0b1071b23e8da2475deaa36",
"netlify.toml": "db77f43cd4cce8632e63c172f479ca1e",
"privacy.html": "671f008229e3077b9fcd8a871e323b7c",
"terms.html": "28e84e619cd1258266a0edd5f73231a2",
"version.json": "eaa18ffe84a99fc28ddbe57b2bd386fc",
"_headers.txt": "3b0c9be75e4c558fbcc25a91dd9d962b",
"_redirects.txt": "7420e65c42bf943db3b7dcdfe7356dc7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
