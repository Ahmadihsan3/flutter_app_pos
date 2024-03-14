import 'package:flutter/material.dart';
import 'package:flutter_app_pos/core/assets/assets.gen.dart';
import 'package:flutter_app_pos/core/components/menu_button.dart';
import 'package:flutter_app_pos/core/components/spaces.dart';
import 'package:flutter_app_pos/core/constants/colors.dart';
import 'package:flutter_app_pos/core/extensions/build_context_ext.dart';
import 'package:flutter_app_pos/data/datasources/product_local_datasource.dart';
import 'package:flutter_app_pos/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_app_pos/presentation/setting/pages/manage_product_page.dart';
import 'package:flutter_app_pos/presentation/setting/pages/sync_data_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_pos/presentation/order/models/order_model.dart';

import '../../../data/datasources/auth_local_datasource.dart';
import '../../auth/pages/login_page.dart';
import '../../home/bloc/logout/logout_bloc.dart';
import 'manage_printer_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  MenuButton(
                    iconPath: Assets.images.manageProduct.path,
                    label: 'Kelola Produk',
                    onPressed: () => context.push(const ManageProductPage()),
                    isImage: true,
                  ),
                  const SpaceWidth(15.0),
                  MenuButton(
                    iconPath: Assets.images.managePrinter.path,
                    label: 'Kelola Printer',
                    onPressed: () {
                      context.push(const ManagePrinterPage());
                    },
                    isImage: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  // MenuButton(
                  //   iconPath: Assets.images.manageProduct.path,
                  //   label: 'QRIS Server Key',
                  //   onPressed: () => context.push(const SaveServerKeyPage()),
                  //   isImage: true,
                  // ),
                  const SpaceWidth(15.0),
                  MenuButton(
                    iconPath: Assets.images.produk.path,
                    label: 'Sinkronisasi Data',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SyncDataPage()),
                      );
                    },
                    isImage: true,
                  ),
                ],
              ),
            ),
            const SpaceHeight(60),
            const Divider(),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  success: (_) {
                    AuthLocalDatasource().removeAuthData();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                );
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text('Logout'),
                );
              },
            ),
            const Divider(),
          ],
        ));
  }
}
