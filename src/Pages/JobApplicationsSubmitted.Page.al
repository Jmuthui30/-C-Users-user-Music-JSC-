page 57000 "Job Applications - Submitted'"
{
    ApplicationArea = All;
    Caption = 'Job Application List';
    PageType = List;
    SourceTable = "Job Application";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "Job Appl-Submitted Card";
    PromotedActionCategories = 'New,Process,Report,Applicant Profile';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field';
                }
                field("Applicant Types"; "Applicant Types")
                {
                    tooltip = 'Specifies the value of the Applicant Types field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field.';
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ToolTip = 'Specifies the value of the Applicant Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Job Applied Code"; Rec."Job Applied Code")
                {
                    ToolTip = 'Specifies the value of the Job Applied Code field.';
                }
                field("Recruitment Needs No."; "Recruitment Needs No.")
                {
                    ToolTip = 'Specifies the value of the Job Applied Code field.';
                    ApplicationArea = All;

                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                }

                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ToolTip = 'Specifies the value of the Date-Time Created field.';
                }
                field("Application Status"; Rec."Application Status")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("View Applicant Information")
            {
                Promoted = true;
                Image = View;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                //Applicant Submit-All 
                RunObject = page "Applicant Submit-All";
                RunPageLink = "No." = field("Applicant No.");
                RunPageMode = View;
                Caption = 'View Applicant Information';
            }
        }
    }
}






