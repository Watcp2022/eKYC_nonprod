***Settings***
Library                 Process
Library                 ExcelLibrary
Library                 OperatingSystem
Library                 String
Library                 DatabaseLibrary
Resource                ../keywords/Sent_SMS(OTP)API_page.robot
Resource                ../keywords/Validate_customer_API_page.robot
Resource                ../keywords/Verify_OTP_API_page.robot


*** Variables ***
${DBHost}         tcrb-bot-nprd-db.cluster-ckedyfslvwdh.ap-southeast-1.rds.amazonaws.com
${DBName}         bot_v2
${DBPass}         &6gh2#5ONWisCQ
${DBPort}         5432
${DBUser}         postgres
${PATH_JAR}            tcrb-ekyc-partner-1.8.jar




***Keywords***
withdraw_bio
    [Arguments]     ${input_cid_hash}           
    Connect To Database     psycopg2     ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    Execute Sql String      UPDATE kyc_db.kyc_transaction SET ial_level='' WHERE cid_hash='${input_cid_hash}' And ial_level='2.3'
    Disconnect From Database



Gen_cid_hash
    [Arguments]         ${cid}
    Run Process     java   -jar     ${PATH_JAR}     hash      ${cid}             file     file      alias=myproc
    ${TextFileContent}          Get File           hashing.txt
    Set global variable         ${GET_CID_HASH}           ${TextFileContent}


Check_have_bio2_3
    [Arguments]     ${input_cid_hash}           
    Connect To Database     psycopg2     ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    @{queryResults_from_cs_info} =  Query    SELECT x.* FROM kyc_db.kyc_transaction x WHERE ial_level IN ('2.3') AND cid_hash IN ('${input_cid_hash}')
    ${ial_score_from_kyc_tran}          Get From List                   @{queryResults_from_cs_info}       	10

Process_withDraw_bio
    [Arguments]     ${cid}
    Gen_cid_hash            ${cid}
    withdraw_bio            ${GET_CID_HASH} 
    # Check_have_bio2_3       ${GET_CID_HASH} 