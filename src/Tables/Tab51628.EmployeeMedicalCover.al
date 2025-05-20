table 51628 "Employee Medical Cover"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No.")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                    Validate(Scale, EmpRec.Scale);
                    Validate(Level, EmpRec.Level);
                end;
                if NAVemp.Get("Employee No.")then begin
                    "Employee Name":=NAVemp."Last Name" + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Cover Type"; Option)
        {
            OptionCaption = 'Outsourced,In-House';
            OptionMembers = Outsourced, "In-House";
        }
        field(5; Cover; Code[10])
        {
            TableRelation = "Medical Schemes" WHERE(Type=FIELD("Cover Type"));

            trigger OnValidate()
            begin
                if CoversRec.Get(Cover)then begin
                    Description:=CoversRec.Description;
                    "Settled By":=CoversRec."Settled By";
                    "Pay Claim To":=CoversRec."Pay Claim To";
                    GetCoverAmount;
                end;
            end;
        }
        field(6; Description; Text[30])
        {
        }
        field(7; "Policy Start Date"; Date)
        {
        }
        field(8; "Policy End Date"; Date)
        {
        }
        field(9; "Cover Amount"; Decimal)
        {
        }
        field(10; Expenditure; Decimal)
        {
            CalcFormula = Sum("Medical Claim"."Claim Amount" WHERE(Policy=FIELD("No."), Status=CONST(Released), "Claim Date"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(11; Balance; Decimal)
        {
        }
        field(12; "Cover Status"; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active, Inactive;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(15; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(16; Scale; Code[10])
        {
            TableRelation = "Salary Scale";

            trigger OnValidate()
            begin
                GetCoverAmount;
            end;
        }
        field(17; Level; Code[10])
        {
            TableRelation = "Salary Level";

            trigger OnValidate()
            begin
                GetCoverAmount;
            end;
        }
        field(18; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(19; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20; "Created By"; Code[50])
        {
        }
        field(21; "Created Date"; Date)
        {
        }
        field(22; "Settled By"; Option)
        {
            OptionCaption = 'Insurance,Our Organization';
            OptionMembers = Insurance, "Our Organization";
        }
        field(23; "Pay Claim To"; Option)
        {
            OptionCaption = 'Service Provider,Employee';
            OptionMembers = "Service Provider", Employee;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Employee No.", Cover, "Policy Start Date", "Policy End Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            CoverSetup.Get;
            CoverSetup.TestField("Cover Nos.");
            NoSeriesMgt.InitSeries(CoverSetup."Cover Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        "Created Date":=Today;
    end;
    var NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    CoversRec: Record "Medical Schemes";
    CoverLimits: Record "Medical Cover Limits";
    CoverSetup: Record "Medical Covers Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure GetCoverAmount()
    begin
        CoverLimits.Reset;
        CoverLimits.SetRange(Cover, Cover);
        CoverLimits.SetRange(Scale, Scale);
        CoverLimits.SetRange(Level, Level);
        if CoverLimits.FindFirst then "Cover Amount":=CoverLimits.Amount;
    end;
}
