import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_to_excel/bloc/feed_back_bloc.dart';

class GetFeedBacksPage extends StatefulWidget {
  const GetFeedBacksPage({super.key});

  @override
  State<GetFeedBacksPage> createState() => _GetFeedBacksPageState();
}

class _GetFeedBacksPageState extends State<GetFeedBacksPage> {
  @override
  void initState() {
    context.read<FeedBackBloc>().add(GetFeedBacks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: BlocBuilder<FeedBackBloc, FeedBackState>(
          builder: (context, state) {
            final loading = state.isLoading;
            final feedBackData = state.feedbackList;
            if (loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Check if the list has at least one element
            if (feedBackData.isEmpty || feedBackData.length == 1) {
              return const Center(
                child: Text("No Feedback Available"),
              );
            }

            // Remove the last index by adjusting the itemCount
            return ListView.separated(
              itemCount: feedBackData.length - 1,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final feedbackItems = feedBackData[index];
                return ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${feedbackItems.name}"),
                      Text("Email: ${feedbackItems.email}"),
                      Text("Phone: ${feedbackItems.mobileNo}"),
                    ],
                  ),
                  subtitle: Text("Feedback: ${feedbackItems.feedback}"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
