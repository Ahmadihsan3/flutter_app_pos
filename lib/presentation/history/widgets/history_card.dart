// import 'package:flutter/material.dart';
// import 'package:flutter_app_pos/core/components/spaces.dart';
// import 'package:flutter_app_pos/core/constants/colors.dart';

// import '../models/history_model.dart';

// class HistoryCard extends StatelessWidget {
//   final HistoryModel data;
//   final EdgeInsetsGeometry? padding;

//   const HistoryCard({
//     super.key,
//     required this.data,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: padding,
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, 2),
//             blurRadius: 48.0,
//             blurStyle: BlurStyle.outer,
//             spreadRadius: 0,
//             color: AppColors.black.withOpacity(0.06),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Metode Bayar',
//             style: TextStyle(color: AppColors.grey),
//           ),
//           const SpaceHeight(5.0),
//           Text(
//             data.payment.method,
//             textAlign: TextAlign.right,
//             style: const TextStyle(fontWeight: FontWeight.w700),
//           ),
//           const SpaceHeight(18.0),
//           const Text(
//             'Total Tagihan',
//             style: TextStyle(color: AppColors.grey),
//           ),
//           const SpaceHeight(5.0),
//           Text(
//             data.totalBillFormat,
//             textAlign: TextAlign.right,
//             style: const TextStyle(fontWeight: FontWeight.w700),
//           ),
//         ],
//       ),
//     );
//   }
// }
