table 51619 "Internal Memo"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Created By"; Code[50])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; From; Text[30])
        {
        }
        field(5; "To"; Code[10])
        {
            TableRelation = "Mail Distribution Lists";

            trigger OnValidate()
            begin
                if DistributionList.Get("To")then begin
                    if DistributionList.Email = '' then Error(Text000);
                    "Group Name":=DistributionList.Description;
                    "Group Email":=DistributionList.Email;
                end;
            end;
        }
        field(6; Subject; Text[30])
        {
        }
        field(7; Memo; Text[250])
        {
        }
        field(8; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; Archived; Boolean)
        {
        }
        field(11; "Posted By"; Code[50])
        {
        }
        field(12; "Archived By"; Code[50])
        {
        }
        field(13; "Group Name"; Text[30])
        {
        }
        field(14; "Group Email"; Text[80])
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            InternalMemoSetup.Get;
            InternalMemoSetup.TestField("Internal Memo Nos.");
            NoSeriesMgt.InitSeries(InternalMemoSetup."Internal Memo Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        Date:=Today;
        if UsersRec.Get(UserSecurityId)then From:=UsersRec."Full Name";
    end;
    var DistributionList: Record "Mail Distribution Lists";
    Text000: Label 'The distribution group selected does not have an email address';
    InternalMemoSetup: Record "Internal Memo Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UsersRec: Record User;
}
