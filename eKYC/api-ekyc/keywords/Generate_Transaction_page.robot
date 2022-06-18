*** Settings ***
Library             RequestsLibrary
Library             Collections
Resource            ../Varriable/varriable.robot



***Keywords***
Start_Generate_Transaction
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE}
    ${body}=        To Json        { "journey" : "JN001", "latitude" : 100.00, "longitude" : 90.00, "agent_id" : "QA", "agent_name" : "QA", "device_name" : "abc", "device_ip" : "000", "imei" : "xyz" }
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_GENERATE}   headers=&{HEADER_PLATFORM_KYC}    json=${body}      expected_status=anything
    Set global variable             ${TRANS_ID}            ${response.json()["data"]["kyc_trans_id"]}
    Log to console        ${TRANS_ID}