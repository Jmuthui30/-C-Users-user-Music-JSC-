table 50022 "Applicant Language"
{
    Caption = 'Applicant Language';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            Caption = 'Applicant No.';
            TableRelation = Applicant."No.";
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = Language.Code;

            trigger OnValidate()
            var
                Lnaguages: Record Language;
            begin
                Lnaguages.Reset();
                Lnaguages.SetRange(Code, Rec.Code);
                if Lnaguages.FindSet()then begin
                    Description:=Lnaguages.Name;
                end;
            end;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Language';
            DataClassification = CustomerContent;
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Applicant No.", Code)
        {
            Clustered = true;
        }
    }
}
