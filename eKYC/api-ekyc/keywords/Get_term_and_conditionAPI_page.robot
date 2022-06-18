*** Settings ***
Library             RequestsLibrary
Library             Collections


*** Keywords ***   
Get_term_and_conditions
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    ${response}=    GET On Session        alias=${ALIAS}          url=${URI_GET_TERM_AND_CONDITION}      headers=&{HEADER_PLATFORM_KYC}
    Request Should Be Successful       response=${response}
    #  Log                 ${response.content}
     Should Be Equal As Integers        ${response.json()["status"]["code"]}                ${RESPONSE_CODE_SUCCESS}
     Should Be Equal                    ${response.json()["status"]["message"]}             ${RESPONSE_MESSAGE_SUCCESS}
     # Should Be Equal                    ${response.json()["status"]["remark"]}              ${RESPONSE_REMARK_NULL}
     # Should Be Equal                    ${response.json()["data"]["type"]}                  ${RESPONSE_TYPE}
    #  Should Be Equal As Numbers         ${response.json()["data"]["econsent_version"]}      ${RESPONSE_ECONSENT_VERSION}
     # Should Be Equal                    ${response.json()["data"]["purpose_name"]}          ${RESPONSE_PURPOSE_NAME_GET_TERM}
     # Should Be Equal                    ${response.json()["data"]["consent"]}               ${RESPONSE_CONTENT}

    # Set global variable                 ${RESPONES_CODE}                                ${response.json()["status"]["code"]} 
    Set global variable                 ${GETTERM_RESPONES_MESSAGE}                      ${response.json()["status"]["message"]}

Disagree_term_and_conditions
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    ${body}=        To Json         {"kyc_trans_id" : "${TRANS_ID}", "accept" : false }
    ${response}=    POST On Session        alias=${ALIAS}          url=${URI_GET_TERM_AND_CONDITION}      headers=&{HEADER_PLATFORM_KYC}          json=${body}
    Should Be Equal As Integers        ${response.json()["status"]["code"]}                ${RESPONSE_CODE_SUCCESS}
    Should Be Equal                    ${response.json()["status"]["message"]}             ${RESPONSE_MESSAGE_SUCCESS}
    Set global variable                 ${GETTERM_RESPONES_MESSAGE}                      ${response.json()["status"]["message"]}

Agree_term_and_conditions
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    ${body}=        To Json         {"kyc_trans_id" : "${TRANS_ID}", "accept" : true }
    ${response}=    POST On Session        alias=${ALIAS}          url=${URI_GET_TERM_AND_CONDITION}      headers=&{HEADER_PLATFORM_KYC}          json=${body}
    Should Be Equal As Integers        ${response.json()["status"]["code"]}                ${RESPONSE_CODE_SUCCESS}
    Should Be Equal                    ${response.json()["status"]["message"]}             ${RESPONSE_MESSAGE_SUCCESS}
    Set global variable                 ${GETTERM_RESPONES_MESSAGE}                      ${response.json()["status"]["message"]}
