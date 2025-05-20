tableextension 51423 "ExtCompany Information" extends "Company Information"
{
    fields
    {
        field(50000; Picture2; Blob)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PictureUpdated := TRUE;
            end;
        }
        field(50001; "Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Branch Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Branch Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Branch City"; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50005; "Branch Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Branch Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50007; "KRA PIN"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "E-Mail Signature"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
            Caption = 'E-Mail Signature';
        }
    }
    var
        PostCode: Record "Post Code";
        PictureUpdated: Boolean;
}
