table 51848 "Employee Disciplinary Cases"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Refference No"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Disciplinary Case"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Disciplinary Cases".Code;
        }
        field(5; "Recommended Action"; Code[20])
        {
            TableRelation = "Disciplinary Actions".Code;
        }
        field(6; "Case Description"; Text[250])
        {
        }
        field(7; "Accused Defence"; Text[250])
        {
        }
        field(8; "Witness #1"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(9; "Witness #2"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(10; "Action Taken"; Code[20])
        {
            TableRelation = "Disciplinary Actions".Code;
        }
        field(11; "Date Taken"; Date)
        {
        }
        field(12; "Document Link"; Text[200])
        {
        }
        field(13; "Disciplinary Remarks"; Code[50])
        {
            TableRelation = "Disciplinary Remarks".Remark;
        }
        field(14; Comments; Text[250])
        {
        }
        field(15; "Cases Discusion"; Boolean)
        {
        }
        field(16; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(17; Status;Enum "Disciplinary Status")
        {
        }
         field(18; "Hearing"; Text[100])
        {
            Caption = 'Hearing';
        }
        field(19; "Capability"; Text[60])
        {
            Caption = 'Capability';
        }
        field(20; "Witness Type"; Option)
        {
            OptionCaption = ' ,Staff,Others';
            OptionMembers = " ",Staff,Others;
            Caption = 'Witness Type';
        }
        field(21; "Witness Name"; Text[60])
        {
            Caption = 'Witness Name';
        }
         field(22; "Action Description"; Text[30])
        {
            Caption = 'Action Description';
        }
        field(23; Attachment; Boolean)
        {
            Caption = 'Attachment';
        }
        field(24; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(25; "RecAction Description"; Text[100])
        {
            Caption = 'RecAction Description';
        }
    }
    keys
    {
        key(Key1; "Line No", "Employee No", "Refference No")
        {
        }
    }
    fieldgroups
    {
    }
}
