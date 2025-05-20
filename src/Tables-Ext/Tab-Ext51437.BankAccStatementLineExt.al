tableextension 51437 "Bank Acc Statement Line Ext" extends "Bank Account Statement Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Reconciled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Cheque Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    var myInt: Integer;
}
