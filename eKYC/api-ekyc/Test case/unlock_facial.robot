***Settings***
Library                 DatabaseLibrary
Library                 ExcelLibrary
Library                 OperatingSystem
Resource                ../keywords/Sent_SMS(OTP)API_page.robot
Resource                ../keywords/Validate_customer_API_page.robot
Resource                ../keywords/Verify_OTP_API_page.robot


*** Variables ***
${DBHost}         tcrb-bot-nprd-db.cluster-ckedyfslvwdh.ap-southeast-1.rds.amazonaws.com
${DBName}         bot_v2
${DBPass}         &6gh2#5ONWisCQ
${DBPort}         5432
${DBUser}         postgres


***Keywords***
unlock
    [Arguments]      ${cid}         
    Connect To Database     psycopg2     ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    Execute Sql String Sanstran	   UPDATE   image_db.customer_facial_lock   SET   permanent_lock=false WHERE     cid_hash='${cid}';
    Disconnect From Database



***Test Cases***
Start_Unlock
    unlock      88d903cf1259372980ec75cb3117a215a10f5ba040d33e64fc04164379e9fad1