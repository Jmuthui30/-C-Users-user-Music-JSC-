page 56615 "Job Qualified Int. Card"
{
    ApplicationArea = All;
    Caption = 'Job Application Card';
    DeleteAllowed = false;
    PageType = Card;
    Editable = true;
    //InsertAllowed = true;
    PromotedActionCategories = 'New,Submit,Report,Applicant Profile';
    SourceTable = "Job Application";
    layout
    {
        area(content)
        {
            group(General)
            {
                // Editable = not Rec.Submitted;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ToolTip = 'Specifies the value of the Applicant No. field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ToolTip = 'Specifies the value of the Applicant Name field.';
                    Editable = false;
                    Enabled = false;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    Enabled = false;
                }
                field("Job Applied Code"; Rec."Job Applied Code")
                {
                    ToolTip = 'Specifies the value of the Job Applied Code field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    Editable = false;
                    Enabled = false;

                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ToolTip = 'Specifies the value of the Date-Time Created field.';
                    Editable = false;
                    Enabled = false;
                }
                field(Submitted; Rec.Submitted)
                {
                    ToolTip = 'Specifies the value of the Submitted field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Interview Period"; "Interview Period")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                    Caption = 'Period';
                    Editable = true;
                    Enabled = true;
                }
                field("Invite Date"; "Invite Date")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                    Caption = 'Schedule Date';
                    Editable = true;
                    Enabled = true;
                }
                field(InviteTime; InviteTime)
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                    Caption = 'schedule Time';
                    Editable = true;
                    Enabled = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit Job Application")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = PurchaseTaxStatement;
                Caption = 'invite';
                //  Enabled = not Rec.Submitted;

                trigger OnAction()
                begin
                    if Confirm('Are you sure want to Invite %1 Job Interview?', false, "Applicant Name") then begin
                        HRMgt.SendOfferLetterViaMail(Rec);
                        "Application Status" := "Application Status"::Interview;
                        CurrPage.Close();
                    end;
                end;
            }
            action("View Applicant Information")
            {
                Promoted = true;
                Image = View;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Applicant Card-All";
                RunPageLink = "No." = field("Applicant No.");
                RunPageMode = View;
                Caption = 'View Applicant Information';
            }
        }
    }

    var
        HRMgt: Codeunit "HR Management";
}






