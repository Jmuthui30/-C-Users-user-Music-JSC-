table 51931 "Procurement Plan Header"
{
    //Ibrahim Wasiu
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Employee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                UsersRec.Reset;
                UsersRec.SetRange("Employee No.", "Employee Code");
                if UsersRec.FindFirst then begin
                    if EmpRec.Get(UsersRec."Employee No.")then begin
                        "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                        "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                        "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                    end;
                end;
                if NAVemp.Get("Employee Code")then "Employee Name":=NAVemp.FullName();
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; status;Enum "Document Status")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Plan No", "No.");
                if Lines.Find('-')then begin
                    repeat Lines."Plan Status":=Status;
                        Lines.Modify;
                    until Lines.Next = 0;
                end;
            end;
        }
        field(5; Description; text[100])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Procurement Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Raised By"; code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));

            trigger OnValidate()
            begin
            //Lines.Reset;
            //Lines.SetRange("Repair No", "No.");
            //if Lines.Find('-') then
            //Lines.ModifyAll("Global Dimension 1 Code", "Global Dimension 1 Code");
            end;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
            //Lines.Reset;
            //Lines.SetRange("Repair No", "No.");
            //if Lines.Find('-') then
            //Lines.ModifyAll("Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(11; "Global Dimension 3 Code"; code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(12; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51931), "Document No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(14; "Management App"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Pending Approvals"; Integer)
        {
            //DataClassification = ToBeClassified;
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51931), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(16; "SharePoint Link"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(17; AssistEdit; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; Verified; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Verified = true then "Verified By":=userid;
            end;
        }
        field(19; "Verified By"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                Validate(Verified);
            end;
        }
        field(20; "Empty No."; Boolean)
        {
            CalcFormula = Exist("Procurement Plan Lines" WHERE("No."=CONST(''), "Plan No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(30; "Financial Budget ID"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name";
        }
        field(31; "Financial Year Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Financial Year Code".Code where(Blocked=filter(false));

            trigger OnValidate()
            var
                FinYearCode: Record "Financial Year Code";
            begin
                FinYearCode.Reset();
                FinYearCode.SetRange(Code, "Financial Year Code");
                FinYearCode.SetRange(Blocked, false);
                if FinYearCode.FindFirst()then begin
                    "Starting Date":=FinYearCode."Start Date";
                    "End Date":=FinYearCode."End Dtae";
                end;
            end;
        }
        field(32; "Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; "Total Estimate"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("Procurement Plan Lines"."Estimated Cost" where("Plan No"=field("No.")));
            Editable = false;
        }
        field(35; "No. Of Items"; Integer)
        {
            // DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = count("Procurement Plan Lines" where("Plan No"=field("No.")));
            Editable = false;
        }
        field(36; "AGPO Reservation"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Procurement Plan Lines"."AGPO Reservation Est. Amnt." where("Plan No"=field("No.")));
        }
        field(37; "% of AGPO Reservation"; Decimal)
        {
            Editable = false;

            // FieldClass = FlowField;
            trigger OnValidate()
            var
                ProcLines: Record "Procurement Plan Lines";
            begin
                "% of AGPO Reservation":=(ProcLines."AGPO Reservation Est. Amnt." / ProcLines."Estimated Cost") * 100;
                Message('Agpo %1, Estimated  %2', ProcLines."AGPO Reservation Est. Amnt.", ProcLines."Estimated Cost");
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var PurchSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UsersRec: Record "User Setup";
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    Expenses: Record "Expense Codes";
    Lines: Record "Procurement Plan Lines";
    ProcurementPlanHeader: Record "Procurement Plan Header";
    ProcurementPlanLine: Record "Procurement Plan Lines";
    SupplierCategory: Record "Supplier Category";
    SumOfAmounts: Decimal;
    EstimatedAmount: Decimal;
    AGPOReservation: Decimal;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchSetup.Get;
            PurchSetup.TestField("Procurement Plan No.");
            NoSeriesMgt.InitSeries(PurchSetup."Procurement Plan No.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Raised by":=UserId;
        "Procurement Date":=Today;
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
