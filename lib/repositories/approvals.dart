import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:aiya/models/approval.dart';
import 'package:aiya/models/approvals.dart';
import 'package:aiya/providers/dio.dart';

part 'approvals.g.dart';

class ApprovalsRepository {
  ApprovalsRepository({required this.client, required this.apiKey});

  final Dio client;
  final String apiKey;

  Future<List<Approval>> fetch({required int pageNumber}) async {
    final response = await client.get('https://my-json-server.typicode.com/18601673727/tempmock/approvals');
    final entity = Approvals.fromJson({'approvalList': response.data});
    return entity.approvalList;
  }
}

@riverpod
ApprovalsRepository approvalsRepository(ApprovalsRepositoryRef ref) => ApprovalsRepository(client: ref.watch(dioProvider), apiKey: "");

@riverpod
Future<List<Approval>> fetchApprovals(
  FetchApprovalsRef ref, {
  required int pageNumber,
}) {
  final approvalsRepo = ref.watch(approvalsRepositoryProvider);
  return approvalsRepo.fetch(pageNumber: pageNumber);
}
