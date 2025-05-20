tableextension 50002 "Posted Purchase Receipt" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "Invoice No"; Code[100])
        {
            Caption = 'Invoice No';
            DataClassification = ToBeClassified;
        }
        field(50001; "Invoice Attachment"; Text[250])
        {
            Caption = 'Invoice Attachment';
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(50002; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = ToBeClassified;
        }
    }
}
