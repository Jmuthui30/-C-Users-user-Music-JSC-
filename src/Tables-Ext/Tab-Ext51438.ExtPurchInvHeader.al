tableextension 51438 "ExtPurch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(51800; "Payment Requested"; Boolean)
        {
            Editable = false;
        }
        field(51801; Decision; Option)
        {
            OptionMembers = " ", New, "Append";

            trigger OnValidate()
            begin
                "Decision By":=UserId;
                if Decision <> Decision::"Append" then Target:=''
                else if Decision = Decision::Append then Error(Text000);
            end;
        }
        field(51802; Target; Code[20])
        {
            TableRelation = "Request for Payment" where("Creditor No."=field("Buy-from Vendor No."), "PV Generated"=const(false), Status=const(Open));
        }
        field(51803; "Partial Payment Request"; Boolean)
        {
            Editable = false;
        }
        field(51804; "Amount Remaining To Request"; Decimal)
        {
            Editable = false;
            Caption = 'Remaining Amount';
        }
        field(51805; "Amount To Request"; Decimal)
        {
            Caption = 'Requested Amount';

            trigger OnValidate()
            begin
                if "Amount To Request" > "Amount Remaining To Request" then Error('You cant request more than the Remaining Amount!');
            end;
        }
        field(51806; "Decision By"; Code[50])
        {
        }
    }
    var Text000: Label 'Append Option have been deactivated Please use New Option to create a new Payment Request';
}
