import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/clients_viewmodel.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClientsViewModel>.reactive(
      viewModelBuilder: () => ClientsViewModel(),
      onViewModelReady: (viewModel) => viewModel.fetchClients(),
      builder: (context, viewModel, child) {
        if (viewModel.errorMessage != null) {
          return Center(child: Text(viewModel.errorMessage!));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Clients'),
          ),
          body: viewModel.isBusy
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: viewModel.clients.length,
                  itemBuilder: (context, index) {
                    final client = viewModel.clients[index];
                    return ListTile(
                      leading: client.photo != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(client.photo!),
                            )
                          : const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                      title: Text('${client.firstname} ${client.lastname}'),
                      subtitle: Text(client.email ?? ""),
                      trailing: const Icon(Icons.more_vert),
                    );
                  },
                ),
        );
      },
    );
  }
}
