***Settings***
Library             RequestsLibrary
Library             Collections
Resource            ../keywords/Get_data_excel.robot

***Variables***
${BOAT}         ujRZih21ppLBAmn3qt8JH3fLOYaA8J2qfMIB7OsQs0rzi4Ah/xTsfj0=
${AUM}          35sU6D/S33UB3c0CM0OxA6FqdQI2h0fUAtT3ko4p1TsvyoWuFbhjFko=
${KOI}          wdXdPUCCl30eKr3qLU16MAR/DsGzCdFyWoizTVBGkpEWY/Lcr9utr/w=
${PKK}          qSbxz05cpPBln16iEIgrC8f/x4G6Bc/SyadQXIz9lNr5g5aAXWpNRG4=
${DEVV}         fBifVxlGcNylGUEJ3TZ2vQsPwMGnR1t1guHCcE0egeytK/PNa2D1SiQ=
${OIL}          1ofkop0fuzCGXR0t17ks1jIve9pQklGKtqzk3qvSYM0ucUtgCAaIstQ=
${PEUNG}        FCHAgf1kJTBEJVewZTYU0QYitrClEHelurDliDwIRg1APOFVkpTVzgI=
${SON}          HQKwiSfqE4v1Z77hjzOoUi9NeG6aA8PF7eRisUcBQnGQCoNaDbCacLg=
${JARR}         6RMiea2qlgsunn3CSoZsQWQJeGOT/MQCSPwLMavI3y3zqpR6fUVmmGk=
${PEPSI}         BmUtvSRUK83HS7Mj176dXWMWj08kPj7cnYuklxfR2cj4oXmWxonOZ00=
${PUNCH}        WsRwDsyRZAzcQxc3semg89FFzwTFRLn9MRZO5poWC4QnZLsNr5F96xA=

***Keywords***
Generate_QR_Code
    [Arguments]         ${row_gen_qrcode}
    Get_data_excel.Get_data_Generate_QRCODE            ${row_gen_qrcode}  

    Set To Dictionary       ${HEADER_GEN_QR}      partner-secret=${GET_PARTNER_SECRET}

    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary       cid=${GET_CID}      twin_status=${GET_TWIN__STATUS}     twins_gender=${GET_TWIN__GENDER}   journey_code=${GET_JOR_CODE}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_GEN_QRCODE}     headers=&{HEADER_GEN_QR}      json=${body}    expected_status=anything
    # Request Should Be Successful    response=${response}
    # Should Be Equal                 ${response.json()["status"]["message"]}           ${RESPONSE_MESSAGE_SUCCESS}

    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             

    Set global variable             ${QR_VALUE}                                       ${response.json()["data"]["qr"]}             
    Set global variable             ${QR_EXPIRE}                                      ${response.json()["data"]["qr_expired"]}             
    Set global variable             ${QR_STATUS}                                      ${response.json()["data"]["qr_status"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}


Validate_QR_Code
    [Arguments]         ${row_validate_qrcode}          ${excel_sheet}

    Get_data_excel.Get_data_Validate_QRCODE            ${row_validate_qrcode}            ${excel_sheet}

    Set To Dictionary       ${HEADER_VALIDATE_QR}      Authorization=${LOGIN_IDTOKEN}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    &{body}=        Create dictionary      qr=${GET_QR_STRING}     trans_ref=   cid=      latitude=13.8694526    longitude=100.7180486   agent_id=ekyc003     agent_name=TB0003     device_name=SM-P585Y/samsung    device_ip=192.168.2.42    imei=abc
    ${response}=    POST On Session       alias=${ALIAS}     url=${URI_VALIDATE_QRCODE}   headers=&{HEADER_VALIDATE_QR}    json=${body}

    Set global variable             ${RESPONSE_CODE}              ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}           ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}            ${response.json()["status"]["remark"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}
    Set global variable             ${RESPONSE_USERCODE}           ${response.json()["status"]["user_code"]}             
    Set global variable             ${RESPONSE_USER_EN}            ${response.json()["status"]["user_message_en"]}             
    Set global variable             ${RESPONSE_USER_TH}            ${response.json()["status"]["user_message_th"]}             


    Set global variable             ${JOURNEY_CODE}               ${response.json()["data"]["journey_code"]}             
    Set global variable             ${JOURNEY_NAME}               ${response.json()["data"]["journey_name"]}             
    Set global variable             ${TRANS_ID}                   ${response.json()["data"]["kyc_trans_id"]}             


Validate_qrcode_modify_api_journey
    [Arguments]         ${row}         

    Get_data_excel.Get_data_Modify_Validate_QR          ${row}      

    Set To Dictionary       ${HEADER_VALIDATE_QR}      Authorization=${LOGIN_IDTOKEN}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    &{body}=        Create dictionary      qr=${GET_QR_STRING}     trans_ref=   cid=      latitude=13.8694526    longitude=100.7180486   agent_id=ekyc003     agent_name=TB0003     device_name=SM-P585Y/samsung    device_ip=192.168.2.42    imei=abc
    ${response}=    POST On Session       alias=${ALIAS}     url=${URI_VALIDATE_QRCODE}   headers=&{HEADER_VALIDATE_QR}    json=${body}

    # Set global variable             ${RESPONSE_CODE}              ${response.json()["status"]["code"]}             
    # Set global variable             ${RESPONSE_MESSAGE}           ${response.json()["status"]["message"]}             
    # Set global variable             ${RESPONSE_REMARK}            ${response.json()["status"]["remark"]}             
    # Set global variable             ${RESPONSE_API}                                   ${response.content}
    # Set global variable             ${RESPONSE_USERCODE}           ${response.json()["status"]["user_code"]}             
    # Set global variable             ${RESPONSE_USER_EN}            ${response.json()["status"]["user_message_en"]}             
    # Set global variable             ${RESPONSE_USER_TH}            ${response.json()["status"]["user_message_th"]}             


    # Set global variable             ${JOURNEY_CODE}               ${response.json()["data"]["journey_code"]}             
    # Set global variable             ${JOURNEY_NAME}               ${response.json()["data"]["journey_name"]}             
    Set global variable             ${TRANS_ID}                   ${response.json()["data"]["kyc_trans_id"]}             


Generate_QR_Code_for_test_qrstamp_scene
    Set To Dictionary       ${HEADER_GEN_QR}      partner-secret=${GET_PARTNER_SECRET}
    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary       cid=${AUM}    twins_status=     twins_gender=   journey_code=JN003       consent_onetrust_version=            consent_internal_version=
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_GEN_QRCODE}     headers=&{HEADER_GEN_QR}      json=${body}    expected_status=anything
    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             
    Set global variable             ${QR_VALUE}                                       ${response.json()["data"]["qr"]}             
    Set global variable             ${QR_EXPIRE}                                      ${response.json()["data"]["qr_expired"]}             
    Set global variable             ${QR_STATUS}                                      ${response.json()["data"]["qr_status"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}


Generate_QR_Code_for_test_qrstamp_scene_2
    Set To Dictionary       ${HEADER_GEN_QR}      partner-secret=${GET_PARTNER_SECRET}

    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary       cid=jzoyaYvHxfMTTtRy9N/8jwBmZHBm3l6IkCmNcawbA8haeGlrOTb8Gpo=      twin_status=     twins_gender=   journey_code=JN004
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_GEN_QRCODE}     headers=&{HEADER_GEN_QR}      json=${body}    expected_status=anything

    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             

    Set global variable             ${QR_VALUE}                                       ${response.json()["data"]["qr"]}             
    Set global variable             ${QR_EXPIRE}                                      ${response.json()["data"]["qr_expired"]}             
    Set global variable             ${QR_STATUS}                                      ${response.json()["data"]["qr_status"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}


Validate_QR_Code_for_test_qrstamp_scene
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    &{body}=        Create dictionary      qr=${QR_VALUE}     trans_ref=   cid=      latitude=13.8694526    longitude=100.7180486   agent_id=ekyc003     agent_name=TB0003     device_name=SM-P585Y/samsung    device_ip=192.168.2.42    imei=abc
    ${response}=    POST On Session       alias=${ALIAS}     url=${URI_VALIDATE_QRCODE}   headers=&{HEADER_PLATFORM_KYC}    json=${body}

    Set global variable             ${RESPONSE_CODE}              ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}           ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}            ${response.json()["status"]["remark"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}
    Set global variable             ${RESPONSE_USERCODE}           ${response.json()["status"]["user_code"]}             
    Set global variable             ${RESPONSE_USER_EN}            ${response.json()["status"]["user_message_en"]}             
    Set global variable             ${RESPONSE_USER_TH}            ${response.json()["status"]["user_message_th"]}             
    # Set global variable             ${JOURNEY_CODE}               ${response.json()["data"]["journey_code"]}             
    # Set global variable             ${JOURNEY_NAME}               ${response.json()["data"]["journey_name"]}             
    Set global variable             ${TRANS_ID}                   ${response.json()["data"]["kyc_trans_id"]}             



Generate_QR_Code_Only
    [Arguments]         ${cid}
    Set To Dictionary       ${HEADER_GEN_QR}      partner-secret=${GET_PARTNER_SECRET}
    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary       cid=${cid}      twin_status=     twins_gender=   journey_code=JN003         
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_GEN_QRCODE}     headers=&{HEADER_GEN_QR}      json=${body}    expected_status=anything

    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             

    Set global variable             ${QR_VALUE}                                       ${response.json()["data"]["qr"]}             
    Set global variable             ${QR_EXPIRE}                                      ${response.json()["data"]["qr_expired"]}             
    Set global variable             ${QR_STATUS}                                      ${response.json()["data"]["qr_status"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}


Generate_QR_Code_for_support_test
    [Arguments]         ${cid}
    Set To Dictionary       ${HEADER_GEN_QR}      partner-secret=${GET_PARTNER_SECRET}
    Create Session          alias=${ALIAS}    url=${BOT_CORE_SERVICE}
    &{body}=        Create dictionary       cid=${${cid}}    twins_status=     twins_gender=   journey_code=JN003       consent_onetrust_version=            consent_internal_version=
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_GEN_QRCODE}     headers=&{HEADER_GEN_QR}      json=${body}    expected_status=anything
    Set global variable             ${RESPONSE_CODE}                                  ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}                               ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}                                ${response.json()["status"]["remark"]}             
    Set global variable             ${QR_VALUE}                                       ${response.json()["data"]["qr"]}             
    Set global variable             ${QR_EXPIRE}                                      ${response.json()["data"]["qr_expired"]}             
    Set global variable             ${QR_STATUS}                                      ${response.json()["data"]["qr_status"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}
