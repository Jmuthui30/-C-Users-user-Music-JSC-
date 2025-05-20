page 52417 "Job Academic Qualifications"
{
    PageType = ListPart;
    SourceTable = "Job Qualifications";
    SourceTableView = where("Qualification Type"=const(Academic));
    Caption = 'Academic Qualifications';

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                ShowCaption = false;

                field("Job Id"; Rec."Job Id")
                {
                    Visible = WebServiceVisibility;
                    ApplicationArea = All;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    Visible = WebServiceVisibility;
                    ApplicationArea = All;
                }
                field("Education Code"; Rec."Education Code")
                {
                    ApplicationArea = All;
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Area of Specialization"; Rec."Area of Specialization")
                {
                    ApplicationArea = All;
                }
                /*field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }*/
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Qualification Type":=Rec."Qualification Type"::Academic;
    end;
    trigger OnOpenPage()
    begin
        if LoginMgmt.IsWebServiceUser(UserId)then WebServiceVisibility:=true
        else
            WebServiceVisibility:=false;
    end;
    var LoginMgmt: Codeunit "Login Management Ext";
    WebServiceVisibility: Boolean;
}
