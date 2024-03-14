import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pos/core/components/spaces.dart';
import 'package:flutter_app_pos/presentation/history/models/history_model.dart';
import 'package:flutter_app_pos/presentation/history/models/history_transaction_model.dart';
import 'package:flutter_app_pos/presentation/history/widgets/history_transaction_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/history/history_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(const HistoryEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const Center(
              child: Text('No Data'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, success: (data) {
            if (data.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SpaceHeight(8.0),
              itemBuilder: (context, index) => HistoryTransactionCard(
                padding: paddingHorizontal,
                data: data[index],
              ),
            );
          });
          // return ListView.separated(
          //   padding: const EdgeInsets.symmetric(vertical: 30.0),
          //   itemCount: historyTransactions.length,
          //   separatorBuilder: (context, index) => const SpaceHeight(8.0),
          //   itemBuilder: (context, index) => HistoryTransactionCard(
          //     padding: paddingHorizontal,
          //     data: historyTransactions[index],
          //   ),
          // );
        },
      ),
    );
  }
}
