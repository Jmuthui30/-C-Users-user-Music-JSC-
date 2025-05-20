table 51803 "Store Transaction Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Created By"; Code[50])
        {
        }
        field(4; Transaction; Option)
        {
            OptionCaption = ' ,Receive,Issue,Transfer';
            OptionMembers = " ", Receive, Issue, Transfer;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(7; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(8; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));
        }
        field(9; "Global Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Global Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5));
        }
        field(10; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; Posted; Boolean)
        {
            trigger OnValidate()
            begin
                if Posted = true then begin
                    Lines.Reset;
                    Lines.SetRange("No.", "No.");
                    if Lines.FindSet then Lines.ModifyAll(Posted, true);
                end
                else
                begin
                    Lines.Reset;
                    Lines.SetRange("No.", "No.");
                    if Lines.FindSet then Lines.ModifyAll(Posted, false);
                end;
            end;
        }
        field(12; "Posted Date"; Date)
        {
        }
        field(13; "Posted By"; Code[50])
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
            CertSetup.Get;
            CertSetup.TestField("Store Receipt Nos.");
            CertSetup.TestField("Store Issue Nos.");
            CertSetup.TestField("Store Transfer Nos.");
            if Transaction = Transaction::Issue then NoSeriesMgt.InitSeries(CertSetup."Store Issue Nos.", xRec."No.", 0D, "No.", "No. Series")
            else if Transaction = Transaction::Receive then NoSeriesMgt.InitSeries(CertSetup."Store Receipt Nos.", xRec."No.", 0D, "No.", "No. Series")
                else if Transaction = Transaction::Transfer then NoSeriesMgt.InitSeries(CertSetup."Store Transfer Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        Date:=Today;
        if UserSetup.Get(UserId)then if OurEmp.Get(UserSetup."Employee No.")then begin
                "Global Dimension 1 Code":=OurEmp."Global Dimension 1 Code";
                "Global Dimension 2 Code":=OurEmp."Global Dimension 2 Code";
                "Global Dimension 3 Code":=OurEmp."Global Dimension 3 Code";
            end;
    end;
    var CertSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Lines: Record "Store Transaction Lines";
    UserSetup: Record "User Setup";
    OurEmp: Record "Employee Master";
}
