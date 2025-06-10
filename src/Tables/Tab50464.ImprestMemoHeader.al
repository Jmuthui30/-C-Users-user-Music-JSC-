table 50464 "Imprest Memo Header"
{
    Caption = 'Imprest Memo Header';
    DataClassification = ToBeClassified;

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
        field(4; From; Code[20])
        {
            trigger OnValidate()
            begin
                if Rec."From" <> '' then begin
                    Staff.Reset();
                    Staff.SetRange("Job Id", Rec."From");
                    Staff.SetRange(Status, Staff.Status::Active);
                    if Staff.FindLast() then begin
                        Rec."Recipient Name" := Staff."Job Title";
                        Rec."Recipient Email" := Staff."Company E-Mail";
                        if Rec."Recipient Email" = '' then Error(Text000);
                    end;
                end;
            end;
        }
        field(5; "To"; Code[10])
        {
            TableRelation = "Company Jobs";

            trigger OnValidate()
            begin
                if Rec."To" <> '' then begin
                    Staff.Reset();
                    Staff.SetRange("Job Id", Rec."To");
                    Staff.SetRange(Status, Staff.Status::Active);
                    if Staff.FindLast() then begin
                        Rec."Recipient Name" := Staff."Job Title";
                        Rec."Recipient Email" := Staff."Company E-Mail";
                        if Rec."Recipient Email" = '' then Error(Text000);
                    end
                    else
                        error('There is no staff occupying this job position currently. Please select a different recipient.');
                end;
            end;
        }
        field(6; Subject; Text[50])
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
        field(13; "Recipient Name"; Text[30])
        {
        }
        field(14; "Recipient Email"; Text[80])
        {
        }
        field(15; "Sender Name"; Text[30])
        {
        }
        field(16; "Sender Email"; Text[80])
        {
        }
        field(17; Purpose; Code[150])
        {
        }
        field(18; "Activity Location"; Code[10])
        {
            TableRelation = "Travel Locations";

            trigger OnValidate()
            begin
                TravelLocation.Get(Rec."Activity Location");
                Rec.International := TravelLocation.International;
            end;
        }
        field(19; "Departure Location"; Text[30])
        {
        }
        field(20; "Departure Date"; Date)
        {
        }
        field(21; "Return Location"; Text[30])
        {
        }
        field(22; "Return Date"; Date)
        {
        }
        field(23; Justification; Text[150])
        {
        }
        field(24; "Imprest Type"; Option)
        {
            OptionCaption = ' ,Standing, Temporary, special';
            OptionMembers = " ","Standing","Temporary","Special";
            NotBlank = true;
        }
        field(25; "Start Date"; Date)
        {
            NotBlank = true;
        }
        field(26; "Total Days in the Field"; Integer)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Total Days in the Field" <> 0 then "End Date" := "Start Date" + "Total Days in the Field" - 1;
            end;
        }
        field(27; "End Date"; Date)
        {
            Editable = false;
        }
        field(28; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = CONST(50464), "Document No." = FIELD("No."), Status = FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
            Editable = false;
        }
        field(29; "International"; Boolean)
        {
        }
        field(30; "DSA"; Boolean)
        {
            //Automate
        }
        field(31; "Air Ticket"; Boolean)
        {
            //Manual
        }
        field(32; "Conference"; Boolean)
        {
            //Manual
        }
        field(33; "Ground Transport"; Boolean)
        {
            //Manual
        }
        field(34; "Accomodation"; Boolean)
        {
            //Manual
            trigger OnValidate()
            begin
                if Rec.Accomodation <> xRec.Accomodation then
                    if Rec.Accomodation = true then begin
                        Rec."Out of Pocket Allowance" := true;
                        Rec."Retreat Allowance" := true;
                    end
                    else
                        Rec."Out of Pocket Allowance" := false;
            end;
        }
        field(35; "Cordination Allowance"; Boolean)
        {
            //Automate - Max 2 People
        }
        field(36; "Facilitator Allowance"; Boolean)
        {
            //Automate
        }
        field(37; "Secretariat Allowance"; Boolean)
        {
            //Automate
        }
        field(38; "Out of Pocket Allowance"; Boolean)
        {
            //Automate
        }
        field(39; "Rapporteur Allowance"; Boolean)
        {
            //Automate
        }
        field(40; "Driver Allowance"; Boolean)
        {
            //Automate
        }
        field(41; "Retreat Allowance"; Boolean)
        {
            //Automate - Max 10 Participants
        }
        field(42; "Expert Allowance"; Boolean)
        {
            //Automate - If Accomodated
        }
        field(43; "Tuition Fee"; Boolean)
        {
            //Manual
        }
        field(44; "Mileage Allowance"; Boolean)
        {
            //Manual
        }
        field(45; "Quarter Per Diem"; Boolean)
        {
            //Manual
        }
        field(55; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Amount LCY" where("No." = FIELD("No.")));
            editable = false;
        }
        field(56; "Budget Available"; Boolean)
        {
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(60; Status; Enum "Document Status")
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger Onvalidate()
            begin
                CommitmentMgt.InsertImprestBudgetAnalysis(Rec);
            end;
        }
        field(62; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger Onvalidate()
            begin
                CommitmentMgt.InsertImprestBudgetAnalysis(Rec);
            end;
        }
        field(63; "Budget Line"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Account Type" = const(Posting));

            trigger OnValidate()
            begin
                if "Budget Line" <> '' then begin
                    Rec."Amount on Budget" := CommitmentMgt.GetAvailableBudget(Rec."Budget Line", Rec.Date, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code");
                    Rec.CalcFields("Total Amount");
                    if Rec."Amount on Budget" > "Total Amount" then Rec."Budget Available" := true;
                end;
            end;
        }
        field(64; "Amount on Budget"; Decimal)
        {
            editable = false;
            DataClassification = ToBeClassified;
        }
        field(65; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Budget Checked"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec."Budget Checked By" := UserId;
            end;
        }
        field(67; "Budget Checked By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(68; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69; "PR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Payroll Claim No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //Total Amounts
        field(100; "DSA Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines".DSA where("No." = FIELD("No.")));
            editable = false;
        }
        field(101; "Air Ticket Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Air Ticket" where("No." = FIELD("No.")));
            editable = false;
        }
        field(102; "Conference Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines".Conference where("No." = FIELD("No.")));
            editable = false;
        }
        field(103; "Ground Transport Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Ground Transport" where("No." = FIELD("No.")));
            editable = false;
        }
        field(104; "Accomodation Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines".Accomodation where("No." = FIELD("No.")));
            editable = false;
        }
        field(105; "Cordination Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Cordination Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(106; "Facilitator Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Facilitator Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(107; "Secretariat Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Secretariat Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(108; "Out ofPocket Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Out of Pocket Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(109; "Rapporteur Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Rapporteur Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(110; "Driver Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Driver Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(111; "Retreat Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Retreat Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(112; "Expert Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Expert Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(113; "Tuition Fee Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Tuition Fee" where("No." = FIELD("No.")));
            editable = false;
        }
        field(114; "Mileage Allowance Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Mileage Allowance" where("No." = FIELD("No.")));
            editable = false;
        }
        field(115; "Quarter Per Diem Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Quarter Per Diem" where("No." = FIELD("No.")));
            editable = false;
        }
        field(116; "Other Costs Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Memo Lines"."Other Costs" where("No." = FIELD("No.")));
            editable = false;
        }
        field(117; "Message body"; Text[2048]
        )
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Message body 1"; Text[2048]
        )
        {
            DataClassification = ToBeClassified;
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
            ImprestMemoSetup.Get;
            ImprestMemoSetup.TestField("Imprest Memo Nos");
            NoSeriesMgt.InitSeries(ImprestMemoSetup."Imprest Memo Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created By" := UserId;
        Rec.Date := Today;
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Employee No.");
            Staff.Get(UserSetup."Employee No.");
            Rec.From := Staff."Job Id";
            Rec."Sender Name" := Staff."Job Title";
            Rec."Sender Email" := Staff."Company E-Mail";
            if Rec."Sender Email" = '' then Error(Text001);
        end
        else
            Error(Text001);
        //Automatic Fields
        Rec.DSA := true;
        Rec."Cordination Allowance" := true;
        Rec."Facilitator Allowance" := true;
        Rec."Secretariat Allowance" := true;
        Rec."Rapporteur Allowance" := true;
        Rec."Driver Allowance" := true;
        Rec."Retreat Allowance" := true;
        Rec."Expert Allowance" := true;
        CommitmentMgt.InsertImprestBudgetAnalysis(Rec);
    end;

    var
        DistributionList: Record "Mail Distribution Lists";
        Text000: Label 'The person selected does not have an email address. Please contact the Administrator';
        ImprestMemoSetup: Record "Advanced Finance Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UsersRec: Record User;
        Staff: Record Employee;
        UserSetup: Record "User Setup";
        Text001: Label 'Your employee card does not have an email address. Please contact the Administrator';
        TravelLocation: Record "Travel Locations";
        CommitmentMgt: Codeunit "Commitment Management";
}
