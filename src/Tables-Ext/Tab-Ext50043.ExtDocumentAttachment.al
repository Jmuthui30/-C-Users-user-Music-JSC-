tableextension 50043 "ExtDocument Attachment" extends "Document Attachment"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Portal File Path"; Text[250])
        {
            ExtendedDatatype = URL;
            Editable = false;
        }
        // Add changes to table fields here
        field(50001; "Attachment Type"; Option)
        {
            OptionMembers = "Member Application", "Loan Application";
        }
        field(50002; "Document Category"; code[20])
        {
        }
        field(50003; "Document Description"; Text[200])
        {
        }
        field(50004; Status;Enum "Document Status")
        {
        }
    }
}
