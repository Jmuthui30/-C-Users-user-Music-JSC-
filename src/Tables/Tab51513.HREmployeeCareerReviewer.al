table 51513 "HR_Employee Career Reviewer"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        // field(2; "Line No."; Integer)
        // {
        //     AutoIncrement = true;
        //     Caption = 'Line No.';
        //     DataClassification = ToBeClassified;
        //     NotBlank = true;
        // }
        field(2; "Eligible for Nomination"; Option)
        {
            OptionCaption = 'None,High Potential (Hi-Po) Pools,Succession Pool,Critical People Pool';
            OptionMembers = None, "High Potential (Hi-Po) Pools", "Succession Pool", "Critical People Pool";
            Caption = 'Do you consider the employee eligible for nomination into the following talent pools?';
            DataClassification = ToBeClassified;
        }
        field(3; "Nomination for Progression"; Option)
        {
            OptionCaption = 'No,Yes';
            OptionMembers = No, "Yes";
            Caption = 'Are you nominating this staff for progression/promotion?';
            DataClassification = ToBeClassified;
        }
        field(4; "Cause for Nomination"; Option)
        {
            OptionCaption = 'Pay Anomaly,Retention,Skills/Competency Improvement';
            OptionMembers = "Pay Anomaly", Retention, "Skills/Competency Improvement";
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = "HR_Prog Nomination Reason" where("Cause for Nomination"=field("Cause for Nomination"));

            trigger OnValidate()
            begin
                if Reasons.Get(Code)then Description:=Reasons.Description;
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Reason for Nomination"; Text[250])
        {
            Caption = 'Reason for nominaing staff for promotion/progression';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Reasons: Record "HR_Prog Nomination Reason";
    Employee: Record Employee;
}
