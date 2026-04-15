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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
        }

        field(102; "Conference Amount"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds Conference"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Conference Amount';
            Editable = false;
            FieldClass = FlowField;
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
            end;
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
            trigger OnValidate()
            begin
                CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount",
                    "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount",
                    "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount",
                    "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount",
                    "Quarter Per Diem Amount", "Other Costs Amount");
                "Budget Available Amount" := "DSA Amount" +
                                            "Air Ticket Amount" +
                                            "Conference Amount" +
                                            "Ground Transport Amount" +
                                            "Accomodation Amount" +
                                            "Cordination Allowance Amount" +
                                            "Facilitator Allowance Amount" +
                                            "Secretariat Allowance Amount" +
                                            "Out ofPocket Allowance Amount" +
                                            "Rapporteur Allowance Amount" +
                                            "Driver Allowance Amount" +
                                            "Retreat Allowance Amount" +
                                            "Expert Allowance Amount" +
                                            "Tuition Fee Amount" +
                                            "Mileage Allowance Amount" +
                                            "Quarter Per Diem Amount" +
                                            "Other Costs Amount";
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





