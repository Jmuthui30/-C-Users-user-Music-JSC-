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
            Caption = 'DSA Available budget';

        }
        field(1000; "DSA Amount allocated"; Decimal)
        {
            Caption = 'DSA Amount';
            trigger OnValidate()
            begin
                //CalcFields("DSA Amount");
                if "DSA Amount allocated" > "DSA Amount" then
                    Message('Allocated amount for DSA has exceeded the available budget by %1. Available budget = %2', ("DSA Amount allocated" - "DSA Amount"), "DSA Amount");
            end;


        }
        field(1001; "Source of Funds DSA Allocated"; Boolean)
        {

            Caption = 'DSA Allocated';
            trigger OnValidate()
            begin
                ImprestSetup.Get();
                ImprestSetup.TestField("DSA Expense Code");

                IF "Source of Funds DSA Allocated" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."DSA Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                Message('DSA amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "DSA Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0;
                    end;
                    // GLBudget.Get(ExpenseCodes."Account No");
                end;
            end;
        }

        field(301; "Source of Funds Air Ticket"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(101; "Air Ticket Amount"; Decimal)
        {
            Caption = 'Air Ticket Available budget';

        }
        field(1002; "Air Ticket allocated"; Boolean)
        {
            Caption = 'Air Ticket Allocated';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Air Ticket allocated" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Air Ticket Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                //Message('Air Ticket amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Air Ticket Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Air Ticket Expense Code %1', ImprestSetup."Air Ticket Expense Code");
                    end;
                end;
            end;
        }
        field(1003; "Air Ticket allocated Amount"; Decimal)
        {
            Caption = 'Air Ticket Amount';
            trigger OnValidate()
            begin
                // CalcFields("Air Ticket Amount");
                if "Air Ticket allocated Amount" > "Air Ticket Amount" then
                    Message('Allocated amount for Air Ticket has exceeded the available budget by %1. Available budget = %2', ("Air Ticket allocated Amount" - "Air Ticket Amount"), "Air Ticket Amount");
            end;
        }

        field(102; "Conference Amount"; Decimal)
        {
            Caption = 'conference Available budget';
        }
        field(302; "Source of Funds Conference"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(1004; "Conference allocated Amount"; Decimal)
        {
            Caption = 'Conference Amount';
            trigger OnValidate()
            begin
                // CalcFields("Conference Amount");
                if "Conference allocated Amount" > "Conference Amount" then
                    Message('Allocated amount for Conference has exceeded the available budget by %1. Available budget = %2', ("Conference allocated Amount" - "Conference Amount"), "Conference Amount");
            end;
        }
        field(1005; "Conference allocated"; Boolean)
        {
            Caption = 'Conference Allocated';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Conference allocated Amount" > 0 then begin
                    if ExpenseCodes.Get(ImprestSetup."Conference Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Conference Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Conference Expense Code %1', ImprestSetup."Conference Expense Code");
                    end;
                end;
            end;
        }

        field(103; "Ground Transport Amount"; Decimal)
        {
            Caption = 'Ground Transport Available budget';
        }
        field(303; "Source of Funds GTransport"; Boolean)
        {
            Caption = 'Ground Transport';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds GTransport" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."G.Transport Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Ground Transport Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Ground Transport Expense Code %1', ImprestSetup."G.Transport Expense Code");
                    end;
                end;
            end;

        }
        field(1006; "GroundT allocated Amount"; Decimal)
        {
            Caption = 'Ground Transport Amount';

            trigger OnValidate()
            begin
                if "GroundT allocated Amount" > "Ground Transport Amount" then
                    Message('Allocated amount for Ground Transport has exceeded the available budget by %1. Available budget = %2', ("GroundT allocated Amount" - "Ground Transport Amount"), "Ground Transport Amount");
            end;
        }


        field(104; "Accomodation Amount"; Decimal)
        {
            Caption = 'Accommodation Available budget';
        }
        field(304; "Source of Funds Accommodation"; Boolean)
        {
            Caption = 'Accommodation';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Accommodation" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Accomodation Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Accomodation Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Accommodation Expense Code %1', ImprestSetup."Accomodation Expense Code");
                    end;
                end;
            end;
        }
        field(1027; "Accomodation allocated Amount"; Decimal)
        {
            Caption = 'Accommodation Amount';
            trigger OnValidate()
            begin
                if "Accomodation allocated Amount" > "Accomodation Amount" then
                    Message('Allocated amount for Accommodation has exceeded the available budget by %1. Available budget = %2', ("Accomodation allocated Amount" - "Accomodation Amount"), "Accomodation Amount");
            end;
        }
        field(105; "Cordination Allowance Amount"; Decimal)
        {
            Caption = 'Coordination Allowance Available budget';
        }
        field(305; "Source of Funds Coordination"; Boolean)
        {
            Caption = 'Coordination';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Coordination" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Cord. Allow Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Cordination Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Coordination Expense Code %1', ImprestSetup."Cord. Allow Expense Code");
                    end;
                end;
            end;
        }
        field(1007; "Coordination allocated Amount"; Decimal)
        {
            Caption = 'Coordination Allowance Amount';
            trigger OnValidate()
            begin
                if "Coordination allocated Amount" > "Cordination Allowance Amount" then
                    Message('Allocated amount for Coordination Allowance has exceeded the available budget by %1. Available budget = %2', ("Coordination allocated Amount" - "Cordination Allowance Amount"), "Cordination Allowance Amount");
            end;
        }
        field(106; "Facilitator Allowance Amount"; Decimal)
        {
            Caption = 'Facilitator Allowance Available budget';
        }
        field(306; "Source of Funds Facilitator"; Boolean)
        {
            Caption = 'Facilitator';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Facilitator" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Facilitator Allow Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Facilitator Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Facilitator Allowance Expense Code %1', ImprestSetup."Facilitator Allow Expense Code");
                    end;
                end;
            end;
        }
        field(1008; "Facilitator allocated Amount"; Decimal)
        {
            Caption = 'Facilitator Allowance Amount';
            trigger OnValidate()
            begin
                if "Facilitator allocated Amount" > "Facilitator Allowance Amount" then
                    Message('Allocated amount for Facilitator Allowance has exceeded the available budget by %1. Available budget = %2', ("Facilitator allocated Amount" - "Facilitator Allowance Amount"), "Facilitator Allowance Amount");
            end;
        }

        field(107; "Secretariat Allowance Amount"; Decimal)
        {
            Caption = 'Secretariat Allowance Available budget';
        }
        field(307; "Source of Funds Secretariat"; Boolean)
        {
            Caption = 'Secretariat';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Secretariat" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Secretariat Allow Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Secretariat Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Secretariat Allowance Expense Code %1', ImprestSetup."Secretariat Allow Expense Code");
                    end;
                end;
            end;
        }
        field(1009; "Secretariat allocated Amount"; Decimal)
        {
            Caption = 'Secretariat Allowance Amount';
            trigger OnValidate()
            begin
                if "Secretariat allocated Amount" > "Secretariat Allowance Amount" then
                    Message('Allocated amount for Secretariat Allowance has exceeded the available budget by %1. Available budget = %2', ("Secretariat allocated Amount" - "Secretariat Allowance Amount"), "Secretariat Allowance Amount");
            end;
        }
        field(108; "Out ofPocket Allowance Amount"; Decimal)
        {
            Caption = 'Out of Pocket Allowance Available budget';
        }
        field(308; "Source of Funds Out of Pocket"; Boolean)
        {
            Caption = 'Out of Pocket';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Out of Pocket" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Out of Pocket Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Out ofPocket Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Out of Pocket Allowance Expense Code %1', ImprestSetup."Out of Pocket Expense Code");
                    end;
                end;
            end;
        }
        field(1010; "Out of Pocket allocated Amount"; Decimal)
        {
            Caption = 'Out of Pocket Allowance Amount';
            trigger OnValidate()
            begin
                if "Out of Pocket allocated Amount" > "Out ofPocket Allowance Amount" then
                    Message('Allocated amount for Out of Pocket Allowance has exceeded the available budget by %1. Available budget = %2', ("Out of Pocket allocated Amount" - "Out ofPocket Allowance Amount"), "Out ofPocket Allowance Amount");
            end;
        }
        field(109; "Rapporteur Allowance Amount"; Decimal)
        {
            Caption = 'Rapporteur Allowance Available budget';
        }
        field(309; "Source of Funds Rapporteur"; Boolean)
        {
            Caption = 'Rapporteur';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Rapporteur" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Rapporteur Allow Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Rapporteur Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Rapporteur Allowance Expense Code %1', ImprestSetup."Rapporteur Allow Expense Code");
                    end;
                end;
            end;
        }
        field(1011; "Rapporteur allocated Amount"; Decimal)
        {
            Caption = 'Rapporteur Allowance Amount';
            trigger OnValidate()
            begin
                if "Rapporteur allocated Amount" > "Rapporteur Allowance Amount" then
                    Message('Allocated amount for Rapporteur Allowance has exceeded the available budget by %1. Available budget = %2', ("Rapporteur allocated Amount" - "Rapporteur Allowance Amount"), "Rapporteur Allowance Amount");
            end;
        }

        field(110; "Driver Allowance Amount"; Decimal)
        {
            Caption = 'Driver Allowance Available budget';
        }
        field(310; "Source of Funds Driver"; Boolean)
        {
            Caption = 'Driver';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Driver" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Driver Allow Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Driver Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Driver Allowance Expense Code %1', ImprestSetup."Driver Allow Expense Code");
                    end;
                end;
            end;
        }
        field(1012; "Driver allocated Amount"; Decimal)
        {
            Caption = 'Driver Allowance Amount';
            trigger OnValidate()
            begin
                if "Driver allocated Amount" > "Driver Allowance Amount" then
                    Message('Allocated amount for Driver Allowance has exceeded the available budget by %1. Available budget = %2', ("Driver allocated Amount" - "Driver Allowance Amount"), "Driver Allowance Amount");
            end;
        }

        field(111; "Retreat Allowance Amount"; Decimal)
        {
            Caption = 'Retreat Allowance Available budget';
        }
        field(311; "Source of Funds Retreat"; Boolean)
        {
            Caption = 'Retreat';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Retreat" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Retreat Allow Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Retreat Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Retreat Allowance Expense Code %1', ImprestSetup."Retreat Allow Expense Code");
                    end;
                end;
            end;
        }
        field(1013; "Retreat allocated Amount"; Decimal)
        {
            Caption = 'Retreat Allowance Amount';
            trigger OnValidate()
            begin
                if "Retreat allocated Amount" > "Retreat Allowance Amount" then
                    Message('Allocated amount for Retreat Allowance has exceeded the available budget by %1. Available budget = %2', ("Retreat allocated Amount" - "Retreat Allowance Amount"), "Retreat Allowance Amount");
            end;
        }
        field(112; "Expert Allowance Amount"; Decimal)
        {
            Caption = 'Expert Allowance Available budget';
        }
        field(312; "Source of Funds Expert"; Boolean)
        {
            Caption = 'Expert';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Expert" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Expert Allow Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Expert Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Expert Allowance Expense Code %1', ImprestSetup."Expert Allow Expense Code");
                    end;
                end;
            end;
        }
        field(1014; "Expert allocated Amount"; Decimal)
        {
            Caption = 'Expert Allowance Amount';
            trigger OnValidate()
            begin
                if "Expert allocated Amount" > "Expert Allowance Amount" then
                    Message('Allocated amount for Expert Allowance has exceeded the available budget by %1. Available budget = %2', ("Expert allocated Amount" - "Expert Allowance Amount"), "Expert Allowance Amount");
            end;
        }

        field(113; "Tuition Fee Amount"; Decimal)
        {
            Caption = 'Tuition Fee Available budget';
        }
        field(313; "Source of Funds Tuition"; Boolean)
        {
            Caption = 'Tuition Fee';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Tuition" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Tuition Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Tuition Fee Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Tuition Fee Expense Code %1', ImprestSetup."Tuition Expense Code");
                    end;
                end;
            end;
        }
        field(1015; "Tuition allocated Amount"; Decimal)
        {
            Caption = 'Tuition Fee Amount';
            trigger OnValidate()
            begin
                if "Tuition allocated Amount" > "Tuition Fee Amount" then
                    Message('Allocated amount for Tuition Fee has exceeded the available budget by %1. Available budget = %2', ("Tuition allocated Amount" - "Tuition Fee Amount"), "Tuition Fee Amount");
            end;
        }

        field(114; "Mileage Allowance Amount"; Decimal)
        {
            Caption = 'Mileage Allowance Available budget';
        }
        field(314; "Source of Funds Mileage"; Boolean)
        {
            Caption = 'Mileage Allowance';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds Mileage" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Mileage Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Mileage Allowance Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Mileage Allowance Expense Code %1', ImprestSetup."Mileage Expense Code");
                    end;
                end;
            end;
        }
        field(1016; "Mileage allocated Amount"; Decimal)
        {
            Caption = 'Mileage Allowance Amount';
            trigger OnValidate()
            begin
                if "Mileage allocated Amount" > "Mileage Allowance Amount" then
                    Message('Allocated amount for Mileage Allowance has exceeded the available budget by %1. Available budget = %2', ("Mileage allocated Amount" - "Mileage Allowance Amount"), "Mileage Allowance Amount");
            end;
        }
        field(115; "Quarter Per Diem Amount"; Decimal)
        {
            Caption = 'Quarter Per Diem Available budget';
        }
        field(315; "Source of Funds QPer Diem"; Boolean)
        {
            Caption = 'Quarter Per Diem';
            trigger OnValidate()
            begin
                ImprestSetup.Get();

                IF "Source of Funds QPer Diem" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Qtr. Per Diem Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                "Quarter Per Diem Amount" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Quarter Per Diem Expense Code %1', ImprestSetup."Qtr. Per Diem Expense Code");
                    end;
                end;
            end;
        }
        field(1017; "Quarter Per Diem allocated Amount"; Decimal)
        {
            Caption = 'Quarter Per Diem Amount';
            trigger OnValidate()
            begin
                if "Quarter Per Diem allocated Amount" > "Quarter Per Diem Amount" then
                    Message('Allocated amount for Quarter Per Diem has exceeded the available budget by %1. Available budget = %2', ("Quarter Per Diem allocated Amount" - "Quarter Per Diem Amount"), "Quarter Per Diem Amount");
            end;
        }
        field(116; "Other Costs Amount"; Decimal)
        {
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("Source of Funds Other Costs"),
                                                        Date = field("Date Filter")));
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
        // "Budget Item No" is often blank in uploaded/approved budget lines.
        // Keep "No." first because Training Needs Lines."Expense Code" validates against it.
        fieldgroup(DropDown; "No.", Description, "Approved Budget", "Source of Funds", "Training Year")
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
        ImprestSetup: Record "Advanced Finance Setup";
        ExpenseCodes: Record "Expense Codes";
        CMSetup: Record "Cash Management Setups";

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





