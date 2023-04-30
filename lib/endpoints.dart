String loginPayload(String username, String password) {
  DateTime now = DateTime.now();
  String clientTime =
      '${now.year.toString().padLeft(4, '0')}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

  return '''
    <?xml version="1.0" encoding="UTF-8"?>
    <TrustView>
        <Envelope>
            <EnvelopeHeader UserID="" ServerTime="" ServerTimeOffset="" SessionID="" ClientTime="$clientTime" Version="2.0.22.1216"/>
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
                            <PropertyObject ClassName="java.lang.String" ObjectName="macAddress" Value="B4%2DA9%2DFC%2D21%2D49%2D92"/></PropertyObject>
                    </JobDetail>
                </Job>
            </EnvelopeBody>
        </Envelope>
    </TrustView>
  ''';
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
  ''';
}
