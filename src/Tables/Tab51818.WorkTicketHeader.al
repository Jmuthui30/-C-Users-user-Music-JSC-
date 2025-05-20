table 51818 "Work Ticket Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Vehicle; Code[20])
        {
            TableRelation = Vehicle;

            trigger OnValidate()
            begin
                if Fleet.Get(Vehicle)then begin
                    if "Global Dimension 1 Code" = '' then "Global Dimension 1 Code":=Fleet."Global Dimension 1 Code";
                    if "Global Dimension 2 Code" = '' then "Global Dimension 2 Code":=Fleet."Global Dimension 2 Code";
                end;
            end;
        }
        field(3; "Issued Date"; Date)
        {
        }
        field(4; "Closed Date"; Date)
        {
        }
        field(5; "Authorising Officer"; Code[50])
        {
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                Users.Reset;
                Users.SetRange("User Name", "Authorising Officer");
                if Users.FindFirst then "Authorising Officer Name":=Users."Full Name";
            end;
        }
        field(6; "Authorising Officer Name"; Text[100])
        {
        }
        field(7; "Created Date"; Date)
        {
        }
        field(8; "Created By"; Code[50])
        {
        }
        field(9; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        //field(12; Status; Option)
        field(12; Status;Enum "Document Status")
        {
        /*OptionCaption = 'Open,Issued,Closed,Canceled';
            OptionMembers = Open,Issued,Closed,Canceled;*/
        }
        field(13; "Issued By"; Code[50])
        {
        }
        field(14; "Issued DateTime"; DateTime)
        {
        }
        field(15; "Closed By"; Code[50])
        {
        }
        field(16; "Closed DateTime"; DateTime)
        {
        }
        field(17; "Canceled By"; Code[50])
        {
        }
        field(18; "Canceled DateTime"; DateTime)
        {
        }
        field(19; "Total Distance Covered (Km)"; Decimal)
        {
            CalcFormula = Sum("Work Ticket Lines"."Distance Covered (KM)" WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(20; "Total Cost of Fuel"; Decimal)
        {
            trigger OnValidate()
            begin
                CalcFields("Total Distance Covered (Km)");
                if("Total Distance Covered (Km)" <> 0) and ("Total Cost of Fuel" <> 0)then "Cost of Fuel per Km":=Round("Total Cost of Fuel" / "Total Distance Covered (Km)", 0.01);
            end;
        }
        field(21; "Cost of Fuel per Km"; Decimal)
        {
        }
        field(22; "Dim One Missing"; Boolean)
        {
            CalcFormula = Exist("Work Ticket Lines" WHERE("Global Dimension 1 Code"=CONST(''), "No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(23; "Dim Two Missing"; Boolean)
        {
            CalcFormula = Exist("Work Ticket Lines" WHERE("Global Dimension 2 Code"=CONST(''), "No."=FIELD("No.")));
            FieldClass = FlowField;
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
        if("No." = '')then begin
            PurchaseSetup.Get;
            PurchaseSetup.TestField("Work Ticket Nos");
            NoSeriesMgt.InitSeries(PurchaseSetup."Work Ticket Nos", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        "Created Date":=Today;
    end;
    var PurchaseSetup: Record "Motorpool Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Users: Record User;
    Fleet: Record Vehicle;
}
