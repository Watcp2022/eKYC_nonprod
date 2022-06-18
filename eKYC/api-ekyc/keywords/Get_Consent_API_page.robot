*** Settings ***
Library             RequestsLibrary
Library             Collections

*** Keywords ***
Get_consent
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    ${response}=    GET On Session     alias=${ALIAS}      url=${URI_GET_CONSENT}      headers=&{HEADER_PLATFORM_KYC}
    Request Should Be Successful    response=${response}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}                 ${RESPONSE_CODE_SUCCESS}

    Set global variable     ${CONSENT_MESSAGE}         ${response.json()["status"]["message"]}             
    # Should Be Equal                 ${response.json()["status"]["message"]}              ${RESPONSE_MESSAGE_GET_TERM}
    # Should Be Equal                 ${response.json()["status"]["remark"]}               ${RESPONSE_REMARK_NULL}
    # Should Be Equal                 ${response.json()["data"]["type"]}                   ${RESPONSE_TYPE_eCONSENT}
    # Should Be Equal As Numbers      ${response.json()["data"]["onetrust_version"]}       ${RESPONSE_ONETRUST_VERSION}
    # Should Be Equal As Numbers      ${response.json()["data"]["econtent_version"]}       ${RESPONSE_ECONSENT_VERSION}
    # Should Be Equal                 ${response.json()["data"]["purpose_name"]}           ${RESPONSE_PURPOSE_NAME_GET_CONSENT}
    # Should Be Equal                 ${response.json()["data"]["content"]}                ${RESPONSE_CONTENT_GET_CONSENT}

Disagree_Consent
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    ${body}=        To Json         { "kyc_trans_id" : "${TRANS_ID}", "accept" : false }
    ${response}=    POST On Session        alias=${ALIAS}          url=${URI_GET_CONSENT}      headers=&{HEADER_PLATFORM_KYC}          json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}                 ${RESPONSE_CODE_SUCCESS}
    Set global variable             ${CONSENT_MESSAGE}         ${response.json()["status"]["message"]}             


Agree_Consent
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    ${body}=        To Json         { "kyc_trans_id" : "${TRANS_ID}", "accept" : true }
    ${response}=    POST On Session        alias=${ALIAS}          url=${URI_GET_CONSENT}      headers=&{HEADER_PLATFORM_KYC}          json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}                 ${RESPONSE_CODE_SUCCESS}
    Set global variable             ${CONSENT_MESSAGE}         ${response.json()["status"]["message"]}             

