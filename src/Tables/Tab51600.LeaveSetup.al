table 51600 "Leave Setup"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
            end;
        }
        field(3; Days; Decimal)
        {
        }
        field(4; "Acrue Days"; Boolean)
        {
        }
        field(5; "Unlimited Days"; Boolean)
        {
        }
        field(6; Gender;Enum "Employee Gender")
        {
        // OptionCaption = 'Both,Male,Female';
        // OptionMembers = Both,Male,Female;
        }
        field(7; Balance; Option)
        {
            OptionCaption = 'Ignore,Carry Forward,Convert to Cash';
            OptionMembers = Ignore, "Carry Forward", "Convert to Cash";
        }
        field(8; "Inclusive of Holidays"; Boolean)
        {
        }
        field(9; "Inclusive of Saturday"; Boolean)
        {
        }
        field(10; "Inclusive of Sunday"; Boolean)
        {
        }
        field(11; "Off/Holidays Days Leave"; Boolean)
        {
        }
        field(12; "Max Carry Forward Days"; Decimal)
        {
            trigger OnValidate()
            begin
                if Balance <> Balance::"Carry Forward" then "Max Carry Forward Days":=0;
            end;
        }
        field(13; "Conversion Rate Per Day"; Decimal)
        {
        }
        field(14; "Annual Leave"; Boolean)
        {
        }
        field(15; Status; Option)
        {
            OptionMembers = Active, Inactive;
        }
        field(16; "Eligible Staff"; Option)
        {
            OptionCaption = 'Both,Permanent,Temporary';
            OptionMembers = Both, Permanent, "Temporary";
        }
        field(17; "Advance Notice(Days)"; Decimal)
        {
        }
        field(18; "Reserved Days"; Decimal)
        {
        }
        field(19; "Notify on Application"; Boolean)
        {
        }
        field(20; "Email Address"; Text[80])
        {
        }
        field(21; "Leave Fiscal Year Difference"; DateFormula)
        {
        }
        field(22; "Adjustment Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    var CauseOfInactivity: Record "Cause of Inactivity";
    local procedure UpdateCauseOfInactivity()
    begin
        If CauseOfInactivity.Get(Code)then begin
        end;
    end;
}
