page 51977 "Leave Recall_ Approved"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Employee Off/Holidays";
    SourceTableView = WHERE(Recalled=CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Application"; Rec."Leave Application")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ApplicationArea = All;
                    NotBlank = true;

                    trigger OnLookup(var Text: Text): Boolean begin
                    /*s
                        frmcalendar.SetDate("Recalled From");
                        frmcalendar.RUNMODAL;
                        d := frmcalendar.GetDate;
                        CLEAR(frmcalendar);
                        IF d <> 0D THEN
                         "Recalled From" := d;
                        VALIDATE("Recalled From");
                          */
                    end;
                }
                field("No. of Off Days"; Rec."No. of Off Days")
                {
                    ApplicationArea = All;
                    Caption = 'No. of Recalled Days';
                    Editable = true;
                }
                field("Leave Ending Date"; Rec."Leave Ending Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }
                field("Head Of Department"; Rec."Head Of Department")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    ApplicationArea = All;
                    NotBlank = true;

                    trigger OnLookup(var Text: Text): Boolean begin
                    /*
                        frmcalendar.SetDate("Recalled To");
                        frmcalendar.RUNMODAL;
                        d := frmcalendar.GetDate;
                        CLEAR(frmcalendar);
                        IF d <> 0D THEN
                          "Recalled To" := d;
                        VALIDATE("Recalled To");
                           */
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
        }
    }
}
