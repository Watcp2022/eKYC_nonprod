*** Settings ***
Library         RequestsLibrary
Resource       ../keywords/Get_term_and_conditionAPI_page.robot
Resource       ../keywords/validate_customer_API_page.robot
Resource       ../keywords/Get_Consent_API_page.robot
Resource       ../keywords/sent_SMS(OTP)API_page.robot
Resource       ../keywords/verify_OTP_API_page.robot
Resource       ../keywords/Check_DOPA_API_page.robot
Resource       ../keywords/Validate_imageAPI_page.robot
Resource       ../Varriable/varriable.robot
Resource		../keywords/save_data_excel_page.robot
Resource		../Varriable/img.robot
Resource		../keywords/Save_LN_FR_Page.robot
Resource		../keywords/LivenessAPI_page.robot
# Resource		../Varriable/api_varriable.robot
Resource		../Varriable/Tablet_varriable.robot
Resource        ../keywords/Save_IAL_Level.robot
Resource        ../keywords/IAL_Page.robot
Resource		../keywords/Twin_page.robot
Resource        ../keywords/IAL_Page.robot
Resource        ../keywords/Generate_Transaction_page.robot
Resource        ../keywords/QR_code_page.robot
Resource		../Main/Main.robot
Resource        ../keywords/Facial_authen_page.robot
Resource        ../keywords/Generate_Partner_Secret_page.robot

Suite Setup         Generate_Partner_Secret


***Test Cases***
##### LIVENESS AUTHEN #####
Liveness_Authen_1
    [Documentation]   ทดสอบระบบ Liveness Verify กรณี verrify สำเร็จส่งค่าถูกต้อง
    Run Keyword And Ignore Error                        Facial_authen_page.Liveness_authen_api                    3
    [Teardown]      Run Keyword And Ignore Error        save_data_excel_page.Save_Result_Facial_authen          3

Liveness_Authen_2
    [Documentation]   ทดสอบระบบ Liveness Verify กรณี ส่ง Base 64 ของภาพมาด้วยขนาดที่ใหญ่กว่า 1mb
    Run Keyword And Ignore Error                        Facial_authen_page.Liveness_authen_api                    4
    [Teardown]      Run Keyword And Ignore Error        save_data_excel_page.Save_Result_Facial_authen          4

Liveness_Authen_3
    [Documentation]   ทดสอบระบบ Liveness Verify กรณี ส่ง cid  ที่ไม่มีอยู่ในระบบ ekyc มา
    Run Keyword And Ignore Error                        Facial_authen_page.Liveness_authen_api                    5
    [Teardown]      Run Keyword And Ignore Error        save_data_excel_page.Save_Result_Facial_authen          5

Liveness_Authen_4    
    [Documentation]   ทดสอบระบบ Liveness Verify กรณี ไม่ส่งค่า base 64 มาที่ request body
    Run Keyword And Ignore Error                        Facial_authen_page.Liveness_authen_api                    6
    [Teardown]      Run Keyword And Ignore Error        save_data_excel_page.Save_Result_Facial_authen          6

Liveness_Authen_5    
    [Documentation]   ทดสอบระบบ Liveness Verify กรณี ส่งภาพที่คะแนนต่ำเข้ามาในระบบ
    Run Keyword And Ignore Error                        Facial_authen_page.Liveness_authen_api                    7
    [Teardown]      Run Keyword And Ignore Error        save_data_excel_page.Save_Result_Facial_authen          7


##### FACIAL AUTHEN #####

Liveness_Authen_6    
    [Documentation]   ทดสอบระบบ Face Recognition verify สำเร็จส่งค่าถูกต้อง
    Run Keyword And Ignore Error                        Facial_authen_page.Facial_authen_10_Pic                 8
    [Teardown]      Run Keyword And Ignore Error        save_data_excel_page.Save_Result_Facial_authen          8

Liveness_Authen_7    
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณี ส่ง Base 64 ของภาพมาด้วยขนาดที่ใหญ่กว่า 1mb

Liveness_Authen_8    
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณี ส่ง cid และ customer_id  ที่ไม่มีอยู่ในระบบ ekyc มา

Liveness_Authen_9    
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณี ไม่ส่งค่า base 64 มาที่ request body

Liveness_Authen_10
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณี ส่งภาพที่มีคะแนนต่ำเข้ามาในระบบ

Liveness_Authen_11
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณีถ่ายส่งมาเก็บภาพที่หลังบ้านจำนวน 10 รูป
    Run Keyword And Ignore Error                        Facial_authen_page.Facial_authen_10_Pic                 11
    # Random_base_64
    # [Teardown]      Run Keyword And Ignore Error        save_data_excel_page.Save_Result_Facial_authen          11

Liveness_Authen_12
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณีถ่ายส่งมาเก็บภาพที่หลังบ้านเกินจำนวน 11 รูป

Liveness_Authen_13
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณีถ่ายส่งมาเก็บภาพที่หลังบ้านเกินจำนวน 12 รูป

Liveness_Authen_14
    [Documentation]   ทดสอบระบบ Face Recognition verify กรณีถ่ายภาพ จากคนละคน กับที่ถ่ายยืนยันไว้ในระบบ kyc
