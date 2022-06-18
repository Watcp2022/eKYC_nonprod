*** Settings ***
Library             RequestsLibrary
Library             Collections
Resource            ../Varriable/varriable.robot
Resource            ../keywords/Get_data_excel.robot
Resource            ../keywords/Get_Consent_API_page.robot

***Variables***



*** Keywords ***
Validate_customer
    ${body}=        To Json         ${CUSTOMER_DATA}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${response}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             ${RESPONSE_CODE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["message"]}         ${RESPONSE_MESSAGE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["remark"]}          ${RESPONSE_REMARK_NULL}
    Set global variable             ${TRANS_ID}             ${response.json()["data"]["trans_id"]}               
    Set global variable             ${MOBILE_NO}            ${response.json()["data"]["mobile_no"]}
    Log to console          ${TRANS_ID}

Validate_customer_Not_Found_Mobile_Number
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_UnHappyCase           ${row_in_excel}
    ${body}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "30-12-2550", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             1006
    # Should Be Equal                 ${response.json()["status"]["message"]}         Data Not Found
    # Should Be Equal                 ${response.json()["status"]["remark"]}          Mobile number not found.
    # Set global variable             ${MOBILE_NO}             ${response.json()["data"]["mobile_number"]}               
    # Set global variable             ${TRANS_ID}            ${response.json()["data"]["kyc_transaction"]}
    Set global variable             ${ERROR_VALIDATE}            ${response.json()["status"]["message"]}


Validate_customer_Invalid_Mobile_Number
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_UnHappyCase           ${row_in_excel}
    ${body}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "30-12-2550", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             0
    # Should Be Equal                 ${response.json()["status"]["message"]}         Data Not Found
    # Should Be Equal                 ${response.json()["status"]["remark"]}          CIF not found.
    Set global variable             ${MOBILE_NO}             ${response.json()["data"]["mobile_number"]}               
    Set global variable             ${TRANS_ID}            ${response.json()["data"]["kyc_transaction"]}

Validate_customer_Invalid_Param_Date_Not_Match_Format
    ${body}=        To Json         ${CUSTOMER_DATA_INVALIDPARAM_1}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    # Request Should Be Successful    response=${response}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}                ${RESPONSE_CODE_INVALID_PARAM}
    Should Be Equal                 ${response.json()["status"]["message"]}             ${RESPONSE_MESSAGE_INVALID_PARAM}
    # Should Be Equal                 ${response.json()["status"]["remark"]}              ${RESPONSE_REMARK_NULL}
    # Should Be Equal                 ${response.json()["data"]}
    # Set global variable             ${TRANS_ID}             ${response.json()["data"]["trans_id"]}               
    # Set global variable             ${MOBILE_NO}            ${response.json()["data"]["mobile_no"]}


TEST_Validate_customer
    [Arguments]             ${row_in_excel}
    Get_Data_Customer           ${row_in_excel}
    ${body}=      To Json     {"title_th":"นาย","title_en":"Mr.","first_name_th":"ตัวอย่าง","first_name_en":"Sample","middle_name_th":"","middle_name_en":"","last_name_th":"สาธิตสกุล","last_name_en":"Satitsakul","house_no":"1/19-11","moo":"1","alley":"ตรอก-ปฐม","lane":"ซอย-สุขุมวิท","road":"สุขุมวิท","sub_district":"คลองเตย","district":"พระโขนง","province":"กรุงเทพมหานคร","sex":"ชาย","birth_date":"30-03-2508","cid":"${GET_CID}","date_of_issue":"30-12-2550","expired_date":"29-03-2565","img":"image/base64","request_no":"12345678901234","issue_by":"พระโขนง/กรุงเทพมหานคร","agent_id":"640000","device_name":"samsung/P355","latitude":"1234","longitude":"01234"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${response}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             ${RESPONSE_CODE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["message"]}         ${RESPONSE_MESSAGE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["remark"]}          ${RESPONSE_REMARK_NULL}
    Set global variable             ${TRANS_ID}             ${response.json()["data"]["trans_id"]}               
    Set global variable             ${MOBILE_NO}            ${response.json()["data"]["mobile_no"]}

Validate_customer_LN_FR
    [Arguments]                         ${row_in_excel}
    Get_Data_Customer_LN_FR           ${row_in_excel}
    ${body}=      To Json     {"title_th":"นาย","title_en":"Mr.","first_name_th":"ตัวอย่าง","first_name_en":"Sample","middle_name_th":"","middle_name_en":"","last_name_th":"สาธิตสกุล","last_name_en":"Satitsakul","house_no":"1/19-11","moo":"1","alley":"ตรอก-ปฐม","lane":"ซอย-สุขุมวิท","road":"สุขุมวิท","sub_district":"คลองเตย","district":"พระโขนง","province":"กรุงเทพมหานคร","sex":"ชาย","birth_date":"30-03-2508","cid":"${GET_CID}","date_of_issue":"30-12-2550","expired_date":"29-03-2565","img":"image/base64","request_no":"12345678901234","issue_by":"พระโขนง/กรุงเทพมหานคร","agent_id":"640000","device_name":"samsung/P355","latitude":"1234","longitude":"01234"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${response}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             ${RESPONSE_CODE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["message"]}         ${RESPONSE_MESSAGE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["remark"]}          ${RESPONSE_REMARK_NULL}
    Set global variable             ${TRANS_ID}             ${response.json()["data"]["trans_id"]}               
    Set global variable             ${MOBILE_NO}            ${response.json()["data"]["mobile_no"]}


Validate_customer_pass
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_MainCase           ${row_in_excel}
    # ${body}=        To Json         { "agent_id": 640001, "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "30-12-2550",, "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "latitude": 13.7711422, "longitude": 100.5719943, "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "agent_name":"QA Automate" , "img": "${IMG}"}

    ${body}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "04-06-2559", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}

    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Set global variable             ${MOBILE_NO}                      ${response.json()["data"]["mobile_number"]}               
    Set global variable             ${CONSENT_NEW_VERSION}            ${response.json()["data"]["consent_new_version"]}
    Run Keyword If                 '${CONSENT_NEW_VERSION}' == 'True'               Get_Consent_API_page.Agree_Consent

Validate_customer_pass_and_Disagree_Consent
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_MainCase           ${row_in_excel}
    ${body}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "04-06-2559", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Set global variable             ${MOBILE_NO}                      ${response.json()["data"]["mobile_number"]}               
    Set global variable             ${CONSENT_NEW_VERSION}            ${response.json()["data"]["consent_new_version"]}
    Run Keyword If                 '${CONSENT_NEW_VERSION}' == 'True'               Get_Consent_API_page.Disagree_Consent


Validate_customer_IAL_TEST
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_IAL           ${row_in_excel}
    ${body}=      To Json     {"title_th":"นาย","title_en":"Mr.","first_name_th":"${FIRST_NAME}","first_name_en":"Sample","middle_name_th":"","middle_name_en":"","last_name_th":"${SURNAME}","last_name_en":"Satitsakul","house_no":"1/19-11","moo":"1","alley":"ตรอก-ปฐม","lane":"ซอย-สุขุมวิท","road":"สุขุมวิท","sub_district":"คลองเตย","district":"พระโขนง","province":"กรุงเทพมหานคร","sex":"ชาย","birth_date":"${BIRTH_DATE}","cid":"${GET_CID}","date_of_issue":"30-12-2550","expired_date":"29-03-2565","img":"image/base64","request_no":"12345678901234","issue_by":"พระโขนง/กรุงเทพมหานคร","agent_id":"640000","device_name":"samsung/P355","latitude":"1234","longitude":"01234"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}    headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Request Should Be Successful    response=${response}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             ${RESPONSE_CODE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["message"]}         ${RESPONSE_MESSAGE_SUCCESS}
    # Should Be Equal                 ${response.json()["status"]["remark"]}          ${RESPONSE_REMARK_NULL}
    Set global variable             ${TRANS_ID}             ${response.json()["data"]["trans_id"]}               
    Set global variable             ${MOBILE_NO}            ${response.json()["data"]["mobile_no"]}

Validate_customer_Not_Customer
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_UnHappyCase           ${row_in_excel}
    ${body}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "30-12-2550", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             1005
    # Should Be Equal                 ${response.json()["status"]["message"]}         Data Not Found
    # Should Be Equal                 ${response.json()["status"]["remark"]}          CIF not found.
    Set global variable             ${ERROR_VALIDATE}            ${response.json()["status"]["message"]}
    # Set global variable             ${MOBILE_NO}             ${response.json()["data"]["mobile_number"]}               
    # Set global variable             ${TRANS_ID}            ${response.json()["data"]["kyc_transaction"]}

Validate_customer_for_Unhappy
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}

    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_UnHappyCase           ${row_in_excel}
    ${body}=        To Json        { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "30-12-2550", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Should Be Equal As Integers     ${response.json()["status"]["code"]}             0
    # Should Be Equal                 ${response.json()["status"]["message"]}         Data Not Found
    # Should Be Equal                 ${response.json()["status"]["remark"]}          CIF not found.
    Set global variable             ${MOBILE_NO}             ${response.json()["data"]["mobile_number"]}               
    # Set global variable             ${TRANS_ID}            ${response.json()["data"]["kyc_transaction"]}


Validate_customer_qr_code_journey
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_MainCase           ${row_in_excel}
    ${body}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"${GET_CID}", "date_of_issue": "30-12-2550", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}
    Set global variable             ${RESPONSE_CODE}              ${response.json()["status"]["code"]}             
    Set global variable             ${RESPONSE_MESSAGE}           ${response.json()["status"]["message"]}             
    Set global variable             ${RESPONSE_REMARK}            ${response.json()["status"]["remark"]}             
    Set global variable             ${RESPONSE_API}                                   ${response.content}
    Set global variable             ${RESPONSE_USERCODE}           ${response.json()["status"]["user_code"]}             
    Set global variable             ${RESPONSE_USER_EN}            ${response.json()["status"]["user_message_en"]}             
    Set global variable             ${RESPONSE_USER_TH}            ${response.json()["status"]["user_message_th"]}             


Validate_customer_Fails
    Set To Dictionary       ${HEADER_PLATFORM_KYC}      Authorization=${LOGIN_IDTOKEN}
    Log                     ${HEADER_PLATFORM_KYC}
    Create Session          alias=${ALIAS}    url=${URL_CORE_SERVICE} 
    [Arguments]                             ${row_in_excel}
    Get_Data_Customer_MainCase           ${row_in_excel}
    ${body}=        To Json         { "kyc_trans_id":"${TRANS_ID}", "alley": " ", "birth_date": "${BIRTH_DATE}", "cid":"1100600292855", "date_of_issue": "30-12-2550", "district": "อำเภอบางกรวย", "expired_date": "26-07-2567", "first_name_en": "${FIRST_NAME_EN}", "first_name_th": "${FIRST_NAME}", "house_no": "425", "issue_by": "พระโขนง/กรุงเทพมหานคร", "lane": " ", "last_name_en": "${SURNAME_EN}", "last_name_th": "${SURNAME}", "middle_name_en": "middle", "middle_name_th": "กลาง", "moo": " ", "province": "บางกะปิ", "request_no": 123456789, "road": "นวมินทร์", "sex": "ชาย", "sub_district": "บางสีทอง", "title_en": "Mr.", "title_th": "นาย", "img": "${IMG}"}
    ${response}=    POST On Session     alias=${ALIAS}     url=${URI_POST_VALIDATE_CUSTOMER}   headers=&{HEADER_PLATFORM_KYC}    json=${body}

