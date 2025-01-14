import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/di/injector.dart';
import 'package:defifundr_mobile/core/global/constants/app_icons.dart';
import 'package:defifundr_mobile/core/global/constants/app_images.dart';
import 'package:defifundr_mobile/core/global/constants/app_json.dart';
import 'package:defifundr_mobile/core/global/constants/app_texts.dart';
import 'package:defifundr_mobile/core/global/constants/size.dart';
import 'package:defifundr_mobile/core/global/helpers/enums.dart';
import 'package:defifundr_mobile/core/global/themes/color_scheme.dart';
import 'package:defifundr_mobile/core/routers/routes_constants.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/button/buttons.dart';
import 'package:defifundr_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defifundr_mobile/core/shared/textfield/search_textfield.dart';
import 'package:defifundr_mobile/core/utils/loading_overlay.dart';
import 'package:defifundr_mobile/features/authentication/presentation/login/states/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:defifundr_mobile/features/home/domain/entities/campaigns/campaigns_entity.dart';
import 'package:defifundr_mobile/features/home/domain/entities/donors_entity/donors_entity.dart';
import 'package:defifundr_mobile/features/home/presentation/state/campaigns/bloc/campaigns_bloc.dart';
import 'package:defifundr_mobile/features/home/presentation/state/get_donors/bloc/get_donors_bloc.dart';
import 'package:defifundr_mobile/features/home/presentation/widget/donation_widget.dart';
import 'package:defifundr_mobile/features/home/presentation/widget/error_state_widget.dart';
import 'package:defifundr_mobile/features/home/presentation/widget/loading_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'state/categories_bloc/bloc/categories_bloc_bloc.dart';
import 'state/get_current_eth_price_bloc/bloc/current_eth_price_bloc.dart';
import 'state/make_donation_bloc/bloc/make_donations_bloc.dart';



part '../presentation/view/discover_campaign.dart';
part '../presentation/view/donation_view.dart';
part '../presentation/view/home.dart';
part 'view/latest_funding_screen.dart';
part '../presentation/view/view_donation_screen.dart';
part '../presentation/view/amount_to_donate.dart';
part '../presentation/view/confirm_donation_details.dart';
part '../presentation/view/success_screen.dart';
part '../presentation/view/search_campaign_screen.dart';
part '../presentation/widget/linear_percentage.dart';
part '../presentation/widget/custom_keyboard.dart';
part '../presentation/widget/text_keys.dart';
