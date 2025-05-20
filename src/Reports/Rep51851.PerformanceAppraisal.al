report 51851 "Performance Appraisal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Performance Appraisal.rdlc';

    dataset
    {
        dataitem("Employee Appraisals"; "Employee Appraisals")
        {
            DataItemTableView = SORTING("Employee No", "Appraisal Type", "Appraisal Period");
            RequestFilterFields = "Employee No", "Appraisal Type", "Appraisal Period";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            /*column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }*/
            column(USERID; UserId)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(Employee_Appraisals1__Appraisal_Period_; "Appraisal Period")
            {
            }
            column(Employee_Appraisals1__Appraisee_Name_; "Appraisee Name")
            {
            }
            column(Employee_Appraisals1__Job_ID_; "Job ID")
            {
            }
            column(Employee_Appraisals1__Employee_No_; "Employee No")
            {
            }
            column(Employee_Appraisals1__Appraisers_Name_; "Appraisers Name")
            {
            }
            column(V1stapprover_; "1stapprover")
            {
            }
            column(UserRecApp1_Picture; UserRecApp1.Signature)
            {
            }
            column(V1stapproverdate_; "1stapproverdate")
            {
            }
            column(V2ndapprover_; "2ndapprover")
            {
            }
            column(UserRecApp2_Picture; UserRecApp2.Signature)
            {
            }
            column(V2ndapproverdate_; "2ndapproverdate")
            {
            }
            column(V3rdapprover_; "3rdapprover")
            {
            }
            column(UserRecApp3_Picture; UserRecApp3.Signature)
            {
            }
            column(V3rdapproverdate_; "3rdapproverdate")
            {
            }
            column(PERFORMANCE_APPRAISAL_FORMCaption; PERFORMANCE_APPRAISAL_FORMCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Appraisals1__Appraisal_Period_Caption; FieldCaption("Appraisal Period"))
            {
            }
            column(Employee_Appraisals1__Appraisee_Name_Caption; FieldCaption("Appraisee Name"))
            {
            }
            column(Employee_Appraisals1__Job_ID_Caption; FieldCaption("Job ID"))
            {
            }
            column(Employee_Appraisals1__Employee_No_Caption; FieldCaption("Employee No"))
            {
            }
            column(Employee_Appraisals1__Appraisers_Name_Caption; FieldCaption("Appraisers Name"))
            {
            }
            column(APPROVALCaption; APPROVALCaptionLbl)
            {
            }
            column(APPRAISEECaption; APPRAISEECaptionLbl)
            {
            }
            column(SIGNATURECaption; SIGNATURECaptionLbl)
            {
            }
            column(APPRAISERCaption; APPRAISERCaptionLbl)
            {
            }
            column(SIGNATURECaption_Control1000000056; SIGNATURECaption_Control1000000056Lbl)
            {
            }
            column(DATE__________________________________________________Caption; DATE__________________________________________________CaptionLbl)
            {
            }
            column(DG_HODCaption; DG_HODCaptionLbl)
            {
            }
            column(SIGNATURE_Caption; SIGNATURE_CaptionLbl)
            {
            }
            column(DATE__________________________________________________Caption_Control1000000064; DATE__________________________________________________Caption_Control1000000064Lbl)
            {
            }
            column(Employee_Appraisals1_Appraisal_No; "Appraisal No")
            {
            }
            dataitem(Objectives; "Appraisal Objectives Lines")
            {
                DataItemLink = "Employee No"=FIELD("Employee No"), "Appraisal Period"=FIELD("Appraisal Period");

                //The property 'DataItemTableView' shouldn't have an empty value.
                //DataItemTableView = '';
                column(Objectives__No__; "No.")
                {
                }
                column(Objectives__Key_Responsibility_; "Key Responsibility")
                {
                }
                column(Objectives__Key_Indicators_; "Key Indicators")
                {
                }
                column(Objectives__Agreed_Target_Date_; "Agreed Target Date")
                {
                }
                column(Objectives_Weighting; Weighting)
                {
                }
                column(ObjectivesCaption; ObjectivesCaptionLbl)
                {
                }
                column(Action_Plan__List_specific_activities_Caption; Action_Plan__List_specific_activities_CaptionLbl)
                {
                }
                column(Time_FrameCaption; Time_FrameCaptionLbl)
                {
                }
                column(Performance_Rating__Weight_Caption; Performance_Rating__Weight_CaptionLbl)
                {
                }
                column(Objectives_Appraisal_No; "Appraisal No")
                {
                }
                column(Objectives_Line_No; "Line No")
                {
                }
                column(Objectives_Employee_No; "Employee No")
                {
                }
                column(Objectives_Appraisal_Period; "Appraisal Period")
                {
                }
            }
            dataitem(CoreValues; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No"=FIELD("Appraisal No");
                DataItemTableView = SORTING("Appraisal No", "Line No")WHERE("Appraisal Heading Type"=CONST("Core Values"));

                column(CoreValues_Description; Description)
                {
                }
                column(CoreValues__Appraiser_s_Comments_; "Appraiser's Comments")
                {
                }
                column(CoreValues__Appraisee_s_comments_; "Appraisee's comments")
                {
                }
                column(Core_ValuesCaption; Core_ValuesCaptionLbl)
                {
                }
                column(Appraiser_s_RemarksCaption; Appraiser_s_RemarksCaptionLbl)
                {
                }
                column(Appraisee_s_RemarksCaption; Appraisee_s_RemarksCaptionLbl)
                {
                }
                column(CoreValues_Appraisal_No; "Appraisal No")
                {
                }
                column(CoreValues_Line_No; "Line No")
                {
                }
            }
            dataitem(CoreCompetency; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No"=FIELD("Appraisal No");
                DataItemTableView = SORTING("Appraisal No", "Line No")WHERE("Appraisal Heading Type"=CONST("Core Competencies"));

                column(CoreCompetency_Description; Description)
                {
                }
                column(CoreCompetency__Appraiser_s_Comments_; "Appraiser's Comments")
                {
                }
                column(CoreCompetency__Appraisee_s_comments_; "Appraisee's comments")
                {
                }
                column(Core_CompetenciesCaption; Core_CompetenciesCaptionLbl)
                {
                }
                column(Appraiser_s_RemarksCaption_Control1000000039; Appraiser_s_RemarksCaption_Control1000000039Lbl)
                {
                }
                column(Appraisee_s_RemarksCaption_Control1000000040; Appraisee_s_RemarksCaption_Control1000000040Lbl)
                {
                }
                column(CoreCompetency_Appraisal_No; "Appraisal No")
                {
                }
                column(CoreCompetency_Line_No; "Line No")
                {
                }
            }
            dataitem(Managerial; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No"=FIELD("Appraisal No");
                DataItemTableView = SORTING("Appraisal No", "Line No")WHERE("Appraisal Heading Type"=CONST("Managerial and Supervisory"));

                column(Managerial_Description; Description)
                {
                }
                column(Managerial__Appraiser_s_Comments_; "Appraiser's Comments")
                {
                }
                column(Managerial__Appraisee_s_comments_; "Appraisee's comments")
                {
                }
                column(Managerial___SupervisoryCaption; Managerial___SupervisoryCaptionLbl)
                {
                }
                column(Appraiser_s_RemarksCaption_Control1000000042; Appraiser_s_RemarksCaption_Control1000000042Lbl)
                {
                }
                column(Appraisee_s_RemarksCaption_Control1000000043; Appraisee_s_RemarksCaption_Control1000000043Lbl)
                {
                }
                column(Managerial_Appraisal_No; "Appraisal No")
                {
                }
                column(Managerial_Line_No; "Line No")
                {
                }
            }
            dataitem(Narrative; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No"=FIELD("Appraisal No");
                DataItemTableView = SORTING("Appraisal No", "Line No")WHERE("Appraisal Heading Type"=CONST("Annual Appraisal"));

                column(Narrative_Description; Description)
                {
                }
                column(Narrative_Description_Control1000000044; Description)
                {
                }
                column(Narrative_Appraisal_No; "Appraisal No")
                {
                }
                column(Narrative_Line_No; "Line No")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                ApprovalEntries.Reset;
                ApprovalEntries.SetRange(ApprovalEntries."Table ID", 69143);
                ApprovalEntries.SetRange(ApprovalEntries."Document No.", "Employee Appraisals"."Appraisal No");
                ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-')then begin
                    i:=0;
                    repeat i:=i + 1;
                        if i = 1 then begin
                            "1stapprover":=ApprovalEntries."Approver ID";
                            "1stapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp1.Get("1stapprover")then UserRecApp1.CalcFields(UserRecApp1.Signature);
                        end;
                        if i = 2 then begin
                            "2ndapprover":=ApprovalEntries."Approver ID";
                            "2ndapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp2.Get("2ndapprover")then UserRecApp2.CalcFields(UserRecApp2.Signature);
                        end;
                        if i = 3 then begin
                            "3rdapprover":=ApprovalEntries."Approver ID";
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp3.Get("3rdapprover")then UserRecApp3.CalcFields(UserRecApp3.Signature);
                        end;
                    //END;
                    until ApprovalEntries.Next = 0;
                end;
            end;
            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var CompInfo: Record "Company Information";
    ApprovalEntries: Record "Approval Entry";
    "1stapprover": Text[30];
    "2ndapprover": Text[30];
    i: Integer;
    "1stapproverdate": DateTime;
    "2ndapproverdate": DateTime;
    UserRec: Record "User Setup";
    UserRecApp1: Record "User Setup";
    UserRecApp2: Record "User Setup";
    UserRecApp3: Record "User Setup";
    "3rdapprover": Text[30];
    "3rdapproverdate": DateTime;
    PERFORMANCE_APPRAISAL_FORMCaptionLbl: Label 'PERFORMANCE APPRAISAL FORM';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    APPROVALCaptionLbl: Label 'APPROVAL';
    APPRAISEECaptionLbl: Label 'APPRAISEE';
    SIGNATURECaptionLbl: Label 'SIGNATURE';
    APPRAISERCaptionLbl: Label 'APPRAISER';
    SIGNATURECaption_Control1000000056Lbl: Label 'SIGNATURE';
    DATE__________________________________________________CaptionLbl: Label 'DATE _________________________________________________';
    DG_HODCaptionLbl: Label 'DG/HOD';
    SIGNATURE_CaptionLbl: Label 'SIGNATURE ';
    DATE__________________________________________________Caption_Control1000000064Lbl: Label 'DATE _________________________________________________';
    ObjectivesCaptionLbl: Label 'Objectives';
    Action_Plan__List_specific_activities_CaptionLbl: Label 'Action Plan (List specific activities)';
    Time_FrameCaptionLbl: Label 'Time Frame';
    Performance_Rating__Weight_CaptionLbl: Label 'Performance Rating (Weight)';
    Core_ValuesCaptionLbl: Label 'Core Values';
    Appraiser_s_RemarksCaptionLbl: Label 'Appraiser''s Remarks';
    Appraisee_s_RemarksCaptionLbl: Label 'Appraisee''s Remarks';
    Core_CompetenciesCaptionLbl: Label 'Core Competencies';
    Appraiser_s_RemarksCaption_Control1000000039Lbl: Label 'Appraiser''s Remarks';
    Appraisee_s_RemarksCaption_Control1000000040Lbl: Label 'Appraisee''s Remarks';
    Managerial___SupervisoryCaptionLbl: Label 'Managerial & Supervisory';
    Appraiser_s_RemarksCaption_Control1000000042Lbl: Label 'Appraiser''s Remarks';
    Appraisee_s_RemarksCaption_Control1000000043Lbl: Label 'Appraisee''s Remarks';
}
