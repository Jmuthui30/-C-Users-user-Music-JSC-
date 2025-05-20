page 56015 "Job Application Card"
{
    ApplicationArea = All;
    Caption = 'Job Application Card';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Submit,Report,Applicant Profile';
    SourceTable = "Job Application";
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Submitted;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = true;
                    Enabled = false;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field.';
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
                    Enabled = false;
                }
                field("Job Applied Code"; Rec."Job Applied Code")
                {
                    ToolTip = 'Specifies the value of the Job Applied Code field.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    Enabled = false;
                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ToolTip = 'Specifies the value of the Date-Time Created field.';
                }
                field(Submitted; Rec.Submitted)
                {
                    ToolTip = 'Specifies the value of the Submitted field.';
                    Editable = true;
                    Enabled = false;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ToolTip = 'Specifies the value of the Application Status field.';
                    Editable = true;
                    Enabled = false;
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
                Caption = 'Accept Job Application';
                Enabled = not Rec.Submitted;

                trigger OnAction()
                begin
                    if Confirm('Are you sure want to submit your job application?', false) then begin
                        HRMgt.SubmitJobApplication(Rec);
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






