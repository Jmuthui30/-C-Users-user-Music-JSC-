tableextension 51428 "ExtPurchase Line" extends "Purchase Line"
{
    fields
    {
        field(50000; "RFQ No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; MFR; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Catalog No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Status;Enum "Purchase Document Status")
        {
            DataClassification = ToBeClassified;
        }
    }
}
