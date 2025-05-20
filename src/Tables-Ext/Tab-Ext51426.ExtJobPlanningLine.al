tableextension 51426 "ExtJob Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(51423; "Posting Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Approved,Approval Pending,Committed,Disapproved,,,,,Fulfilled,Canceled';
            OptionMembers = New, Approved, "Approval Pending", Committed, Disapproved, , , , , Fulfilled, Canceled;
        }
        field(51424; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(51425; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    var myInt: Integer;
}
