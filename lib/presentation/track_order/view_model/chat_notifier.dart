import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/data/models/chat_message_response/chat_message.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';

import '../../../data/repositories/interfaces/chat_repo_interface.dart';
import '../views/chat_sheet.dart';

class ChatNotifier extends StateNotifier<AppState<List<Message>>> {
  final IChatRepo chatRepo;
  final Ref ref;
  ChatNotifier({required this.chatRepo, required this.ref}) : super(const AppState.initial()) {
    getMessage();
  }

  Future<void> getMessage() async {
    final driverId = ref
        .read(createOrderNotifierProvider)
        .maybeWhen(orElse: () => 0, success: (data) => (data.driver?.id ?? 0).toInt());
    state = const AppState.loading();
    final result = await chatRepo.getMessage(userId: driverId);
    result.fold((failure) => state = AppState.error(failure), (data) {
      state = AppState.success(data.data);
      _scrollToBottom();
    });
  }

  Future<void> sendMessage({required TextEditingController message}) async {
    final String text = message.text.trim();
    await updateMsgList(text);
    message.clear();

    // final previousMessages = state.maybeWhen(
    //   success: (messages) => messages,
    //   orElse: () => [],
    // );

    // final user = await LocalStorageService().getSavedUser();
    final driverId = ref
        .read(createOrderNotifierProvider)
        .maybeWhen(orElse: () => 0, success: (data) => (data.driver?.id ?? 0).toInt());

    final result = await chatRepo.sendMessage(receiverId: driverId, message: text);

    result.fold(
      (failure) {
        state = AppState.error(failure);
      },
      (data) async {
        // state = AppState.success(updatedList);
      },
    );
  }

  void addMessage(Message message) {
    state.maybeWhen(
      success: (messages) {
        final updatedList = [...messages, message];
        state = AppState.success(updatedList);
        _scrollToBottom();
      },
      orElse: () {
        state = AppState.success([message]);
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> updateMsgList(String message) async {
    final prevMsg = state.whenOrNull(success: (data) => data) ?? [];
    final user = await LocalStorageService().getSavedUser();
    final driverId = ref
        .read(createOrderNotifierProvider)
        .maybeWhen(orElse: () => 0, success: (data) => (data.driver?.id ?? 0).toInt());
    state = AppState.success([
      ...prevMsg,
      Message(
        id: DateTime.now().millisecondsSinceEpoch,
        senderId: user?.id ?? 0,
        receiverId: driverId,
        message: message,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ]);
    _scrollToBottom();
  }
}
