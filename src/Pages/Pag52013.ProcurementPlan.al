page 52013 "Procurement Plan"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "G/L Budget Name";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Department Filter"; Rec."Department Filter")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control1; "Procurement Plan items")
            {
                ApplicationArea = All;
                SubPageLink = "Plan Year"=FIELD(Name), "Department Code"=FIELD("Department Filter");
            }
        }
    }
    actions
    {
    }
}
