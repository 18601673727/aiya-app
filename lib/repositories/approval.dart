import 'package:xml/xml.dart';
import 'package:http_plus/http_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:aiya/endpoints.dart';
import 'package:aiya/models/approval.dart';
import 'package:aiya/providers/hpc.dart';
import 'package:aiya/providers/auth.dart';

part 'approval.g.dart';

class ApprovalRepository {
  ApprovalRepository({required this.client, required this.sessionId});

  final HttpPlusClient client;
  final String sessionId;

  Future<List<Approval>> fetch() async {
    List<Approval> approvals = List.empty(growable: true);
    List<XmlNode> xmlNodes = List.empty();

    final payload = approvalListPayload(sessionId);
    final url = Uri.https('drm.aiyainfo.com:9443', '/tvud/rd');
    final body = {'xmlDoc': payload};
    final response = await client.post(url, body: body);
    final document = XmlDocument.parse(Uri.decodeFull(response.body));

    for (var element in document.findAllElements('PropertyObject')) {
      if (element.attributes[0].value == 'tw.com.trustview.tvsystem.vo.TVApplyVO_ARRAY') {
        xmlNodes = element.children;
      }
    }

    for (var xmlNode in xmlNodes) {
      List<XmlNode> propertyNodes = xmlNode.children;

      final approval = Approval(
        fileName: propertyNodes.where((element) => element.attributes[1].toString() == 'ObjectName="fileName"').first.attributes[2].value,
        userName: propertyNodes.where((element) => element.attributes[1].toString() == 'ObjectName="applyDisplayname"').first.attributes[2].value,
        actionType: propertyNodes.where((element) => element.attributes[1].toString() == 'ObjectName="applyType"').first.attributes[2].value == '4'
            ? '外发'
            : '解密',
        description: propertyNodes.where((element) => element.attributes[1].toString() == 'ObjectName="applyRemarks"').first.attributes[2].value,
        createdAt: propertyNodes.where((element) => element.attributes[1].toString() == 'ObjectName="applyDate"').first.attributes[2].value,
        fileId: int.parse(propertyNodes.where((element) => element.attributes[1].toString() == 'ObjectName="id"').first.attributes[2].value),
        userId: int.parse(propertyNodes.where((element) => element.attributes[1].toString() == 'ObjectName="applyUserid"').first.attributes[2].value),
      );

      approvals.add(approval);
    }

    return approvals;
  }
}

@riverpod
ApprovalRepository approvalRepository(ApprovalRepositoryRef ref) =>
    ApprovalRepository(client: ref.watch(hpcProvider), sessionId: ref.watch(sessionIdProvider));

@riverpod
Future<List<Approval>> fetchApproval(FetchApprovalRef ref) {
  final approvalRepo = ref.watch(approvalRepositoryProvider);
  return approvalRepo.fetch();
}
