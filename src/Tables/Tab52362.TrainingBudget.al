table 52362 "Training Budget"
{
    DataClassification = CustomerContent;
    Caption = 'Training Budget';
    fields
    {
        field(1; "Training Year"; Code[100])
        {
            Caption = 'Training Year';
        }
        field(2; "Budget Item No"; Code[200])
        {
            //NotBlank = true;
            Caption = 'Budget Item No';
        }
        field(3; "Source of Funds"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(4; "Estimated Cost"; Decimal)
        {
            Caption = 'Estimated Cost';

            trigger OnValidate()
            begin
                GLSetup.Get();
                GLSetup.TestField("Current Budget");
                GLSetup.TestField("Current Budget Start Date");
                GLSetup.TestField("Current Budget End Date");

                GLBudget.SetCurrentKey("Budget Name", "G/L Account No.", Date, "Global Dimension 1 Code");
                GLBudget.SetRange(GLBudget."Budget Name", "Training Year");
                GLBudget.SetRange(GLBudget."G/L Account No.", "Source of Funds");
                if GLSetup."Use Dimensions For Budget" then
                    GLBudget.SetRange(GLBudget."Dimension Set ID", "Dimension Set ID");
                GLBudget.SetRange(GLBudget.Date, GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date");
                GLBudget.CalcSums(Amount);
                BudgetAmount := GLBudget.Amount;
                Message('Budget amount for A/C no %1 is %2', "Source of Funds", GLBudget.Amount);
                // "Approved Budget" := BudgetAmount;

                TrainingPlan.SetCurrentKey("Training Year", "Source of Funds");
                TrainingPlan.SetRange(TrainingPlan."Training Year", "Training Year");
                TrainingPlan.SetRange(TrainingPlan."Source of Funds", "Source of Funds");
                TrainingPlan.CalcSums("Estimated Cost");
                TrainingPlanAmount := TrainingPlan."Estimated Cost";
                Message('Total budgeted amount for A/C no %1 in training plan is %2', "Source of Funds", TrainingPlan."Estimated Cost");


                if "Estimated Cost" > (BudgetAmount - TrainingPlanAmount) then
                    Message('Overall budget amount for A/C no %1 has been exceeded by %2. Total Budgeted amount = %3', "Source of Funds",
                    ("Estimated Cost" - (BudgetAmount - TrainingPlanAmount)), BudgetAmount);
            end;
        }
        field(5; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "Approved Budget"; Decimal)
        {
            Caption = 'Approved Budget';
        }
        field(7; "Budget Status"; Option)
        {
            OptionMembers = " ",Open,Approved,Rejected;
            Caption = 'Budget Status';
        }
        field(8; "No."; Code[20])
        {
            Caption = 'No.';


            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get();
                    HRSetup.TestField("Training Budget Item Nos");
                    NoSeriesManagement.TestManual(HRSetup."Training Budget Item Nos");
                end;
            end;

        }
        field(9; Actual; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds"),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Actuals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Commitment; Decimal)
        {
            // CalcFormula = sum("Commitment Entries"."Committed Amount" where(No = field("Source of Funds"),
            //                                                                  "Commitment Date" = field("Date Filter"),
            //                                                                  "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Commitments';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(11; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                HRSetup.Get();
                HRSetup.TestField("Training Budget Item Nos");
                // if "Budget Item No" = '' then
                // NoSeriesMgt.InitSeries(HRSetup."Training Budget Item Nos", xRec."No. Series", 0D, "Budget Item No", "No. Series");
                // if NoSeriesMgt.AreRelated(HRSetup."Training Budget Item Nos", xRec."No. Series") then
                //     "No. Series" := xRec."No. Series"
                // else
                "No. Series" := HRSetup."Training Budget Item Nos";
                "No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate());
            end;
        }
        field(12; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(15; "Dimension Set ID"; Integer)
        {
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(16; "No. Series"; code[100])
        {
            Caption = 'No. Series';
        }

        field(300; "Source of Funds DSA"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(100; "DSA Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds DSA"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'DSA Amount';
            Editable = false;
            FieldClass = FlowField;
        }

        field(301; "Source of Funds Air Ticket"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(101; "Air Ticket Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Air Ticket"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Air Ticket Amount';
            Editable = false;
            FieldClass = FlowField;
        }

        field(102; "Conference Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Conference"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Conference Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(302; "Source of Funds Conference"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(103; "Ground Transport Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds GTransport"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Ground Transport Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(303; "Source of Funds GTransport"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(104; "Accomodation Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Accommodation"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Accommodation Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(304; "Source of Funds Accommodation"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(105; "Cordination Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Coordination"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Coordination Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(305; "Source of Funds Coordination"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(106; "Facilitator Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Facilitator"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Facilitator Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(306; "Source of Funds Facilitator"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }

        field(107; "Secretariat Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Secretariat"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Secretariat Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(307; "Source of Funds Secretariat"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(108; "Out ofPocket Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Out of Pocket"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Out of Pocket Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(308; "Source of Funds Out of Pocket"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(109; "Rapporteur Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Rapporteur"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Rapporteur Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(309; "Source of Funds Rapporteur"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }

        field(110; "Driver Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Driver"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Driver Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(310; "Source of Funds Driver"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }

        field(111; "Retreat Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Retreat"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Retreat Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(311; "Source of Funds Retreat"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(112; "Expert Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Expert"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Expert Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(312; "Source of Funds Expert"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }

        field(113; "Tuition Fee Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Tuition"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Tuition Fee Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(313; "Source of Funds Tuition"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }

        field(114; "Mileage Allowance Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Mileage"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Mileage Allowance Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(314; "Source of Funds Mileage"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(115; "Quarter Per Diem Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds QPer Diem"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Quarter Per Diem Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(315; "Source of Funds QPer Diem"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(116; "Other Costs Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Other Costs"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Other Costs Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(316; "Source of Funds Other Costs"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
    }

    keys
    {
        key(Key1; "Training Year", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Budget Item No", "No.")
        {
            Clustered = true;
            SumIndexFields = "Estimated Cost";
        }
        key(Key2; "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
        key(Key3; "No.")
        {
            SumIndexFields = "Estimated Cost";
        }
        key(Key4; "Training Year", "Shortcut Dimension 2 Code", "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Budget Item No", Description, "No.")
        {
        }
    }

    trigger OnInsert()
    begin
        /* PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Procurement Plan Item Nos");
        if "Plan Item No" = '' then begin
            NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Procurement Plan Item Nos", xRec."No. Series", 0D, "Plan Item No", "No. Series");
        end; */
        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Training Budget Item Nos");
            if NoSeriesManagement.AreRelated(HRSetup."Training Budget Item Nos", xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := HRSetup."Training Budget Item Nos";
            "No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate());
        end;
    end;




    var
        GLAcc: Record "G/L Account";
        GLBudget: Record "G/L Budget Entry";
        GLSetup: Record "General Ledger Setup";
        HRSetup: Record "Human Resources Setup";
        TrainingPlan: Record "Training budget";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit "No. Series";
        BudgetAmount: Decimal;
        TrainingPlanAmount: Decimal;
        NoSeriesManagement: Codeunit "No. Series";

    procedure GetQuarters()
    var
        AccPeriod: Record "Accounting Period";
        NewYear: Date;
        "1stQuarter": Decimal;
        "2ndQuarter": Decimal;
        "3rdQuarter": Decimal;
        "4thQuarter": Decimal;
    begin
        AccPeriod.Reset();
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-') then
            NewYear := AccPeriod."Starting Date";
        //Get 1st Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "1stQuarter" := "Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "2ndQuarter" := "Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "3rdQuarter" := "Estimated Cost";
        end;
        //Get 4th Quarter Budget
        SetRange("Budget Item No", "Budget Item No");
        SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Find('-') then begin
            CalcSums("Estimated Cost");
            "4thQuarter" := "Estimated Cost";
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





