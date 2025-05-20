page 51485 "Employee Import Header-Posted"
{
    // version THL- Client Payroll 1.0
    Caption = 'Created Employee Details';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Employee Import Header";
    SourceTableView = WHERE(Posted=CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control12; "Employee Import Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control14; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var EmpData: XMLport "Import Employee Details";
    Employee: Record "Client Employee Master";
    Lines: Record "Employee Import Lines";
    Emp: Record "Client Employee Master";
}
