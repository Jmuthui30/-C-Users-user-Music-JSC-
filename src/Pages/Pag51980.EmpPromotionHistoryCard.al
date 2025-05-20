page 51980 "Emp Promotion History Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field(LengthOfService; LengthOfService)
                {
                    ApplicationArea = All;
                    Caption = 'Length Of Service';
                }
            }
            part(Control1; "Promotion History Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No"=FIELD("No.");
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        LengthOfService:='';
        if(Rec."Employment Date" <> 0D)then LengthOfService:=Dates.DetermineAge(Rec."Employment Date", Today);
    end;
    trigger OnOpenPage()
    begin
        LengthOfService:='';
        if(Rec."Employment Date" <> 0D)then LengthOfService:=Dates.DetermineAge(Rec."Employment Date", Today);
    end;
    var Dates: Codeunit "HR Dates";
    LengthOfService: Text[100];
}
