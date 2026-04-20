table 52361 "Training Needs Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Training Needs Lines';
    fields
    {
        field(1; "Document No."; Code[200])
        {
            TableRelation = "Training Need";
            Caption = 'Document No.';
        }
        field(3; "Expense Code"; Code[200])
        {
            TableRelation = "Training Budget"."No.";
            Caption = 'Expense Code';

            trigger OnValidate()
            var
                TrainingBudget: Record "Training Budget";
            begin
                TrainingBudget.Reset();
                TrainingBudget.SetRange(TrainingBudget."No.", "Expense Code");
                if TrainingBudget.Find('-') then begin
                    "Approved Budget" := TrainingBudget."Approved Budget";
                    "Expense name" := TrainingBudget.Description;
                    "Budget Line" := TrainingBudget."Source of Funds";
                    "Training Year" := TrainingBudget."Training Year";
                end;

            end;
        }
        field(4; "G/L Account"; Code[200])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'G/L Account';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                CurrencyRec.InitRoundingPrecision();

                if "Currency Code" = '' then
                    "Amount (LCY)" := Round(Amount, CurrencyRec."Amount Rounding Precision")
                else
                    "Amount (LCY)" := Round(
                        CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code",
                          Amount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                          CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(6; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
        }
        field(7; "Currency Code"; Code[100])
        {
            TableRelation = Currency;
            Caption = 'Currency Code';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(8; Committed; Boolean)
        {
            Caption = 'Committed';
        }
        field(9; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(10; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
        field(14; Status; Option)
        {
            CalcFormula = lookup("Training Need".Status where(Code = field("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'New,Closed,Application';
            OptionMembers = Open,Closed,Application;
            Caption = 'Status';
        }
        field(15; "Expense name"; Text[300])
        {
            Caption = 'Expense name';
        }
        field(16; "Budget Line"; Code[200])
        {
            TableRelation = "G/L Account";
            Caption = 'Budget Line';
        }
        field(17; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(117; "Approval Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Amount';
        }
        //"Approved Budget"
        field(118; "Approved Budget"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved Budget';
        }
        field(300; "Source of Funds DSA"; Boolean)
        {
            Caption = 'Source of Funds DSA';
            trigger OnValidate()
            begin


                ImprestSetup.Get();
                ImprestSetup.TestField("DSA Expense Code");

                IF "Source of Funds DSA" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."DSA Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                // Message('DSA amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "DSA Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0;
                    end
                    else
                        Message('No record found in Expense Codes for Air Ticket Expense Code %1', ImprestSetup."Air Ticket Expense Code");
                end;

            end;
        }
        field(1000; "DSA Available Budget"; Decimal)
        {
            Caption = 'DSA Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(100; "DSA Amount"; Decimal)
        {
            Caption = 'DSA Amount';
            trigger OnValidate()
            begin
                if "DSA Available Budget" > "DSA Amount" then
                    Message('Allocated amount for DSA has exceeded the available budget by %1. Available budget = %2', ("DSA Available Budget" - "DSA Amount"), "DSA Amount");
            end;
        }

        field(301; "Source of Funds Air Ticket"; Boolean)
        {
            Caption = 'Source of Funds Air Ticket';
            trigger OnValidate()
            begin
                ImprestSetup.Get();
                IF "Source of Funds Air Ticket" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Air Ticket Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                //Message('Air Ticket amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Air Ticket Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Air Ticket Expense Code %1', ImprestSetup."Air Ticket Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Air Ticket Expense Code %1', ImprestSetup."Air Ticket Expense Code");

                end;
            end;
        }
        field(1001; "Air Ticket Available Budget"; Decimal)
        {
            Caption = 'Air Ticket Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(101; "Air Ticket Amount"; Decimal)
        {

            Caption = 'Air Ticket Amount';

            trigger OnValidate()
            begin
                if "Air Ticket Available Budget" > "Air Ticket Amount" then
                    Message('Allocated amount for Air Ticket has exceeded the available budget by %1. Available budget = %2', ("Air Ticket Available Budget" - "Air Ticket Amount"), "Air Ticket Amount");
            end;
        }

        field(102; "Conference Amount"; Decimal)
        {

            Caption = 'Conference Amount';
            trigger OnValidate()
            begin
                if "Conference Available Budget" > "Conference Amount" then
                    Message('Allocated amount for Conference has exceeded the available budget by %1. Available budget = %2', ("Conference Available Budget" - "Conference Amount"), "Conference Amount");
            end;
        }
        field(302; "Source of Funds Conference"; Boolean)
        {
            Caption = 'Source of Funds Conference';
            trigger OnValidate()
            begin
                ImprestSetup.Get();
                IF "Source of Funds Conference" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."Conference Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                //Message('Conference amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Conference Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Conference Expense Code %1', ImprestSetup."Conference Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Conference Expense Code %1', ImprestSetup."Conference Expense Code");

                end;
            end;
        }
        field(1002; "Conference Available Budget"; Decimal)
        {
            Caption = 'Conference Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(103; "Ground Transport Amount"; Decimal)
        {
            Caption = 'Ground Transport Amount';
            trigger OnValidate()
            begin
                if "GTransport Available Budget" > "Ground Transport Amount" then
                    Message('Allocated amount for Ground Transport has exceeded the available budget by %1. Available budget = %2', ("GTransport Available Budget" - "Ground Transport Amount"), "Ground Transport Amount");
            end;
        }
        field(303; "Source of Funds GTransport"; Boolean)
        {
            Caption = 'Source of Funds GTransport';
            trigger OnValidate()
            begin

                ImprestSetup.Get();
                IF "Source of Funds Conference" = true then begin
                    if ExpenseCodes.Get(ImprestSetup."G.Transport Expense Code") then begin
                        GLBudget.Reset();
                        GLBudget.SetRange("G/L Account No.", ExpenseCodes."Account No");
                        GLBudget.SetRange("Budget Name", "Training Year");
                        IF GLBudget.Find('-') then
                            repeat
                                //Message('Conference amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "GTransport Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for G.Transport Expense Code %1', ImprestSetup."G.Transport Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for G.Transport Expense Code %1', ImprestSetup."G.Transport Expense Code");

                end;
            end;
        }
        field(1003; "GTransport Available Budget"; Decimal)
        {
            Caption = 'Ground Transport Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                         "Air Ticket Available Budget" +
                                         "Conference Available Budget" +
                                         "GTransport Available Budget" +
                                         "Accommodation Available Budget" +
                                         "Coordination Allowance Available Budget" +
                                         "Facilitator Allowance Available Budget" +
                                         "Secretariat Allowance Available Budget" +
                                         "Out of Pocket Allowance Available Budget" +
                                         "Rapporteur Allowance Available Budget" +
                                         "Driver Allowance Available Budget" +
                                         "Retreat Allowance Available Budget" +
                                         "Expert Allowance Available Budget" +
                                         "Tuition Fee Available Budget" +
                                         "Mileage Allowance Available Budget" +
                                         "Quarter Per Diem Available Budget" +
                                         "Other Costs Amount";
            end;
        }
        field(104; "Accomodation Amount"; Decimal)
        {

            Caption = 'Accommodation Amount';

            trigger OnValidate()
            begin
                if "Accommodation Available Budget" > "Accomodation Amount" then
                    Message('Allocated amount for Accommodation has exceeded the available budget by %1. Available budget = %2', ("Accommodation Available Budget" - "Accomodation Amount"), "Accomodation Amount");
            end;
        }
        field(304; "Source of Funds Accommodation"; Boolean)
        {
            Caption = 'Source of Funds Accommodation';
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
                                //Message('Accommodation amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Accommodation Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Accommodation Expense Code %1', ImprestSetup."Accomodation Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Accommodation Expense Code %1', ImprestSetup."Accomodation Expense Code");

                end;
            end;
        }
        field(1004; "Accommodation Available Budget"; Decimal)
        {
            Caption = 'Accommodation Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(105; "Cordination Allowance Amount"; Decimal)
        {
            Caption = 'Coordination Allowance Amount';

            trigger OnValidate()
            begin
                if "Coordination Allowance Available Budget" > "Cordination Allowance Amount" then
                    Message('Allocated amount for Coordination Allowance has exceeded the available budget by %1. Available budget = %2', ("Coordination Allowance Available Budget" - "Cordination Allowance Amount"), "Cordination Allowance Amount");
            end;
        }
        field(305; "Source of Funds Coordination"; Boolean)
        {
            Caption = 'Source of Funds Coordination';
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
                                //Message('Coordination amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Coordination Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Coordination Expense Code %1', ImprestSetup."Cord. Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Coordination Expense Code %1', ImprestSetup."Cord. Allow Expense Code");

                end;
            end;

        }
        field(1005; "Coordination Allowance Available Budget"; Decimal)
        {
            Caption = 'Coordination Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(106; "Facilitator Allowance Amount"; Decimal)
        {
            Caption = 'Facilitator Allowance Amount';
            trigger OnValidate()
            begin
                if "Facilitator Allowance Available Budget" > "Facilitator Allowance Amount" then
                    Message('Allocated amount for Facilitator Allowance has exceeded the available budget by %1. Available budget = %2', ("Facilitator Allowance Available Budget" - "Facilitator Allowance Amount"), "Facilitator Allowance Amount");
            end;
        }
        field(306; "Source of Funds Facilitator"; Boolean)
        {
            Caption = 'Source of Funds Facilitator';
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
                                //Message('Facilitator amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Facilitator Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Facilitator Allowance Expense Code %1', ImprestSetup."Facilitator Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Facilitator Allowance Expense Code %1', ImprestSetup."Facilitator Allow Expense Code");

                end;
            end;
        }
        field(1006; "Facilitator Allowance Available Budget"; Decimal)
        {
            Caption = 'Facilitator Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }

        field(107; "Secretariat Allowance Amount"; Decimal)
        {
            Caption = 'Secretariat Allowance Amount';
            trigger OnValidate()
            begin
                if "Secretariat Allowance Available Budget" > "Secretariat Allowance Amount" then
                    Message('Allocated amount for Secretariat Allowance has exceeded the available budget by %1. Available budget = %2', ("Secretariat Allowance Available Budget" - "Secretariat Allowance Amount"), "Secretariat Allowance Amount");
            end;
        }
        field(307; "Source of Funds Secretariat"; Boolean)
        {
            Caption = 'Source of Funds Secretariat';
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
                                //Message('Secretariat amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Secretariat Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Secretariat Allowance Expense Code %1', ImprestSetup."Secretariat Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Secretariat Allowance Expense Code %1', ImprestSetup."Secretariat Allow Expense Code");
                end;
            end;
        }
        field(1007; "Secretariat Allowance Available Budget"; Decimal)
        {
            Caption = 'Secretariat Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(108; "Out ofPocket Allowance Amount"; Decimal)
        {
            Caption = 'Out of Pocket Allowance Amount';
            trigger OnValidate()
            begin
                if "Out of Pocket Allowance Available Budget" > "Out ofPocket Allowance Amount" then
                    Message('Allocated amount for Out of Pocket Allowance has exceeded the available budget by %1. Available budget = %2', ("Out of Pocket Allowance Available Budget" - "Out ofPocket Allowance Amount"), "Out ofPocket Allowance Amount");
            end;
        }
        field(308; "Source of Funds Out of Pocket"; Boolean)
        {
            Caption = 'Source of Funds Out of Pocket Allowance';
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
                                //Message('Out of Pocket amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Out of Pocket Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Out of Pocket Allowance Expense Code %1', ImprestSetup."Out of Pocket Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Out of Pocket Allowance Expense Code %1', ImprestSetup."Out of Pocket Expense Code");

                end;
            end;
        }
        field(1008; "Out of Pocket Allowance Available Budget"; Decimal)
        {
            Caption = 'Out of Pocket Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(109; "Rapporteur Allowance Amount"; Decimal)
        {
            Caption = 'Rapporteur Allowance Amount';
            trigger OnValidate()
            begin
                if "Rapporteur Allowance Available Budget" > "Rapporteur Allowance Amount" then
                    Message('Allocated amount for Rapporteur Allowance has exceeded the available budget by %1. Available budget = %2', ("Rapporteur Allowance Available Budget" - "Rapporteur Allowance Amount"), "Rapporteur Allowance Amount");
            end;
        }
        field(309; "Source of Funds Rapporteur"; Boolean)
        {
            Caption = 'Source of Funds Rapporteur Allowance';
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
                                //Message('Rapporteur amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Rapporteur Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Rapporteur Allowance Expense Code %1', ImprestSetup."Rapporteur Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Rapporteur Allowance Expense Code %1', ImprestSetup."Rapporteur Allow Expense Code");

                end;
            end;
        }
        field(1009; "Rapporteur Allowance Available Budget"; Decimal)
        {
            Caption = 'Rapporteur Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }

        field(110; "Driver Allowance Amount"; Decimal)
        {
            Caption = 'Driver Allowance Amount';
            trigger OnValidate()
            begin
                if "Driver Allowance Available Budget" > "Driver Allowance Amount" then
                    Message('Allocated amount for Driver Allowance has exceeded the available budget by %1. Available budget = %2', ("Driver Allowance Available Budget" - "Driver Allowance Amount"), "Driver Allowance Amount");
            end;
        }
        field(310; "Source of Funds Driver"; Boolean)
        {
            Caption = 'Source of Funds Driver Allowance';
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
                                //Message('Driver amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Driver Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Driver Allowance Expense Code %1', ImprestSetup."Driver Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Driver Allowance Expense Code %1', ImprestSetup."Driver Allow Expense Code");

                end;
            end;
        }
        field(1010; "Driver Allowance Available Budget"; Decimal)
        {
            Caption = 'Driver Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }

        field(111; "Retreat Allowance Amount"; Decimal)
        {
            Caption = 'Retreat Allowance Amount';
            trigger OnValidate()
            begin
                if "Retreat Allowance Available Budget" > "Retreat Allowance Amount" then
                    Message('Allocated amount for Retreat Allowance has exceeded the available budget by %1. Available budget = %2', ("Retreat Allowance Available Budget" - "Retreat Allowance Amount"), "Retreat Allowance Amount");
            end;
        }
        field(311; "Source of Funds Retreat"; Boolean)
        {
            Caption = 'Source of Funds Retreat Allowance';
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
                                //Message('Retreat amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Retreat Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Retreat Allowance Expense Code %1', ImprestSetup."Retreat Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Retreat Allowance Expense Code %1', ImprestSetup."Retreat Allow Expense Code");

                end;
            end;
        }
        field(1011; "Retreat Allowance Available Budget"; Decimal)
        {
            Caption = 'Retreat Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(112; "Expert Allowance Amount"; Decimal)
        {
            Caption = 'Expert Allowance Amount';
            trigger OnValidate()
            begin
                if "Expert Allowance Available Budget" > "Expert Allowance Amount" then
                    Message('Allocated amount for Expert Allowance has exceeded the available budget by %1. Available budget = %2', ("Expert Allowance Available Budget" - "Expert Allowance Amount"), "Expert Allowance Amount");
            end;
        }
        field(312; "Source of Funds Expert"; Boolean)
        {
            Caption = 'Source of Funds Expert Allowance';
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
                                //Message('Expert amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Expert Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Expert Allowance Expense Code %1', ImprestSetup."Expert Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Expert Allowance Expense Code %1', ImprestSetup."Expert Allow Expense Code");

                end;
            end;
        }
        field(1012; "Expert Allowance Available Budget"; Decimal)
        {
            Caption = 'Expert Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }

        field(113; "Tuition Fee Amount"; Decimal)
        {
            Caption = 'Tuition Fee Amount';
            trigger OnValidate()
            begin
                if "Tuition Fee Available Budget" > "Tuition Fee Amount" then
                    Message('Allocated amount for Tuition Fee has exceeded the available budget by %1. Available budget = %2', ("Tuition Fee Available Budget" - "Tuition Fee Amount"), "Tuition Fee Amount");
            end;
        }
        field(313; "Source of Funds Tuition"; Boolean)
        {
            Caption = 'Source of Funds Tuition Fee';
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
                                //Message('Expert amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Tuition Fee Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Expert Allowance Expense Code %1', ImprestSetup."Expert Allow Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Expert Allowance Expense Code %1', ImprestSetup."Expert Allow Expense Code");

                end;
            end;

        }
        field(1013; "Tuition Fee Available Budget"; Decimal)
        {
            Caption = 'Tuition Fee Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(114; "Mileage Allowance Amount"; Decimal)
        {
            Caption = 'Mileage Allowance Amount';

            trigger OnValidate()
            begin
                if "Mileage Allowance Available Budget" > "Mileage Allowance Amount" then
                    Message('Allocated amount for Mileage Allowance has exceeded the available budget by %1. Available budget = %2', ("Mileage Allowance Available Budget" - "Mileage Allowance Amount"), "Mileage Allowance Amount");
            end;
        }
        field(314; "Source of Funds Mileage"; Boolean)
        {
            Caption = 'Source of Funds Mileage Allowance';
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
                                //Message('Mileage amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Mileage Allowance Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Mileage Allowance Expense Code %1', ImprestSetup."Mileage Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Mileage Allowance Expense Code %1', ImprestSetup."Mileage Expense Code");

                end;
            end;
        }
        field(1014; "Mileage Allowance Available Budget"; Decimal)
        {
            Caption = 'Mileage Allowance Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                                         "Air Ticket Available Budget" +
                                                         "Conference Available Budget" +
                                                         "GTransport Available Budget" +
                                                         "Accommodation Available Budget" +
                                                         "Coordination Allowance Available Budget" +
                                                         "Facilitator Allowance Available Budget" +
                                                         "Secretariat Allowance Available Budget" +
                                                         "Out of Pocket Allowance Available Budget" +
                                                         "Rapporteur Allowance Available Budget" +
                                                         "Driver Allowance Available Budget" +
                                                         "Retreat Allowance Available Budget" +
                                                         "Expert Allowance Available Budget" +
                                                         "Tuition Fee Available Budget" +
                                                         "Mileage Allowance Available Budget" +
                                                         "Quarter Per Diem Available Budget" +
                                                         "Other Costs Amount";
            end;
        }
        field(115; "Quarter Per Diem Amount"; Decimal)
        {
            Caption = 'Quarter Per Diem Amount';
            trigger OnValidate()
            begin
                if "Quarter Per Diem Available Budget" > "Quarter Per Diem Amount" then
                    Message('Allocated amount for Quarter Per Diem has exceeded the available budget by %1. Available budget = %2', ("Quarter Per Diem Available Budget" - "Quarter Per Diem Amount"), "Quarter Per Diem Amount");
            end;
        }
        field(315; "Source of Funds QPer Diem"; Boolean)
        {
            Caption = 'Source of Funds Quarter Per Diem';
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
                                //Message('Quarter Per Diem amount allocated for A/C no %1 is %2', ExpenseCodes."Account No", GLBudget.Amount);
                                "Quarter Per Diem Available Budget" := GLBudget.Amount;
                            UNTIL GLBudget.Next() = 0
                        else
                            Message('No budget amount found for Quarter Per Diem Expense Code %1', ImprestSetup."Qtr. Per Diem Expense Code");
                    end
                    else
                        Message('No record found in Expense Codes for Quarter Per Diem Expense Code %1', ImprestSetup."Qtr. Per Diem Expense Code");

                end;
            end;
        }
        field(1015; "Quarter Per Diem Available Budget"; Decimal)
        {
            Caption = 'Quarter Per Diem Available Budget';
            Editable = false;
            trigger OnValidate()
            begin
                "Budget Available Amount" := "DSA Available Budget" +
                                           "Air Ticket Available Budget" +
                                           "Conference Available Budget" +
                                           "GTransport Available Budget" +
                                           "Accommodation Available Budget" +
                                           "Coordination Allowance Available Budget" +
                                           "Facilitator Allowance Available Budget" +
                                           "Secretariat Allowance Available Budget" +
                                           "Out of Pocket Allowance Available Budget" +
                                           "Rapporteur Allowance Available Budget" +
                                           "Driver Allowance Available Budget" +
                                           "Retreat Allowance Available Budget" +
                                           "Expert Allowance Available Budget" +
                                           "Tuition Fee Available Budget" +
                                           "Mileage Allowance Available Budget" +
                                           "Quarter Per Diem Available Budget" +
                                           "Other Costs Amount";
            end;
        }
        field(116; "Other Costs Amount"; Decimal)
        {
            Caption = 'Other Costs Amount';

            trigger OnValidate()
            begin

            end;
        }
        field(316; "Source of Funds Other Costs"; Code[15])
        {
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        //BudgetAvailable
        field(317; "Budget Available Amount"; Decimal)
        {

            Caption = 'Budget Available Amount';

        }
        field(391; "Training Year"; Code[100])
        {
            Caption = 'Training Year';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Expense Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TrainingNeed.Get("Document No.");
        TrainingNeed.TestField("Start Date");
        TrainingNeed.TestField("End Date");
        "Start Date" := TrainingNeed."Start Date";
        "End Date" := TrainingNeed."End Date";
        "Shortcut Dimension 1 Code" := TrainingNeed."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := TrainingNeed."Shortcut Dimension 2 Code";
        "Dimension Set ID" := TrainingNeed."Dimension Set ID";
        "Currency Code" := TrainingNeed."Currency Code";
    end;

    var
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        TrainingNeed: Record "Training Need";
        DimMgt: Codeunit DimensionManagement;
        ImprestSetup: Record "Advanced Finance Setup";
        ExpenseCodes: Record "Expense Codes";
        GLBudget: Record "G/L Budget Entry";

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 %2', 'Training', "Document No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





