String loginPayload(String username, String password) {
  return '''
    <?xml version="1.0" encoding="UTF-8"?>
    <TrustView>
      <Envelope>
        <EnvelopeHeader/>
        <EnvelopeBody>
          <Job Origin="" Destination="" RequestID="" Target="tw.com.trustview.tvsystem.trustserver.service.TVAuthenticationService">
            <JobDetail JobDetailID="">
              <Action>Authenticate</Action>
              <PropertyObject ClassName="tw.com.trustview.tvsystem.vo.TVAuthenticationVO">
                <PropertyObject ClassName="java.lang.String_ARRAY" ObjectName="authInfo">
                  <PropertyObject ClassName="java.lang.String" Value="$username"/>
                  <PropertyObject ClassName="java.lang.String" Value="$password"/></PropertyObject>
                <PropertyObject ClassName="int" ObjectName="clientType" Value="11"/>
                <PropertyObject ClassName="java.lang.String" ObjectName="moduleName" Value="TVDbSam"/>
              </PropertyObject>
            </JobDetail>
          </Job>
        </EnvelopeBody>
      </Envelope>
    </TrustView>
  '''
      .trim();
}

String decryptPayload(String sessionId, String docId, String docKey) {
  DateTime now = DateTime.now();
  String clientTime =
      '${now.year.toString().padLeft(4, '0')}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

  return '''
    <?xml version="1.0" encoding="UTF-8"?>
    <TrustView>
      <Envelope>
        <EnvelopeHeader UserID="" ServerTime="" ServerTimeOffset="" SessionID="$sessionId" ClientTime="$clientTime" Version="2.0.22.1216"/>
        <EnvelopeBody>
          <Job Origin="" Destination="" RequestID="" Target="tw.com.trustview.tvsystem.trustserver.service.TVDocumentService">
            <JobDetail JobDetailID="">
              <Action>ResolveDocument</Action>
              <PropertyObject ClassName="tw.com.trustview.tvsystem.vo.TVDocumentVO">
                <PropertyObject ClassName="int" ObjectName="docId" Value="$docId"/>
                <PropertyObject ClassName="java.lang.String" ObjectName="keyHex" Value="$docKey"/></PropertyObject>
            </JobDetail>
          </Job>
        </EnvelopeBody>
      </Envelope>
    </TrustView>
  '''
      .trim();
}

String approvalListPayload(String sessionId) {
  DateTime now = DateTime.now();
  String clientTime =
      '${now.year.toString().padLeft(4, '0')}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

  return '''
    <?xml version="1.0" encoding="UTF-8"?>
    <TrustView>
      <Envelope>
        <EnvelopeHeader UserID="" ServerTime="" ServerTimeOffset="" SessionID="$sessionId" ClientTime="$clientTime" Version="2.0.22.1216"/>
        <EnvelopeBody>
          <Job Origin="" Destination="" RequestID="" Target="tw.com.trustview.tvsystem.trustserver.service.TVApplyService">
            <JobDetail JobDetailID="">
              <Action>QueryApply</Action>
              <PropertyObject ClassName="tw.com.trustview.tvsystem.vo.TVApplyCriteriaVO">
                <PropertyObject ClassName="java.lang.String_ARRAY" ObjectName="approveUserId">
                <PropertyObject ClassName="java.lang.String" Value="990"/></PropertyObject>
                <PropertyObject ClassName="java.lang.String_ARRAY" ObjectName="applyStatus">
                <PropertyObject ClassName="java.lang.String" Value="990"/></PropertyObject>
              </PropertyObject>
            </JobDetail>
          </Job>
        </EnvelopeBody>
      </Envelope>
    </TrustView>
  '''
      .trim();
}
