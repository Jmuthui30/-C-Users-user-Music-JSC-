tableextension 51435 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Tag Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        // //TableRelation = Table0;
        }
        field(50002; "Tag Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        //TableRelation = Table0;
        }
        field(50003; "Custodial Payment Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Minimum Float"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Maximum Float"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Petty Cash Holder"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Account type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,Cash';
            OptionMembers = Bank, Cash;
        }
    }
    var myInt: Integer;
}
