page 52986 "Training Needs Line"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Needs Lines";
    Caption = 'Training Needs Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Code"; Rec."Expense Code")
                {
                    ToolTip = 'Specifies the value of the Expense Code field';
                }
                field("Expense name"; Rec."Expense name")
                {
                    ToolTip = 'Specifies the value of the Expense name field';
                }
                field("Approval Amount"; "Approval Amount")
                {
                    ToolTip = 'Specifies the value of the Approval Amount field';
                }
                field("Approval Amount (LCY)"; "Approval Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Approval Amount (LCY) field';
                }
                field("Approved Budget"; "Approved Budget")
                {
                    ToolTip = 'Specifies the value of the Approved Budget field';
                    Editable = false;
                }
                field("Budget Available Amount"; "Budget Available Amount")
                {
                    Caption = 'Budget Available';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Budget Available field';
                }

                field("Source of Funds DSA"; "Source of Funds DSA")
                {
                    ToolTip = 'Specifies the value of the Source of Funds DSA field';
                }
                field("DSA Available Budget"; "DSA Available Budget")
                {
                    Caption = 'DSA Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the DSA Available Budget field';
                }
                field("DSA Amount"; "DSA Amount")
                {
                    ToolTip = 'Specifies the value of the DSA Amount field';
                }

                //"Air Ticket Amount"
                field("Source of Funds Air Ticket"; "Source of Funds Air Ticket")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Air Ticket';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Air Ticket Available Budget"; "Air Ticket Available Budget")
                {
                    Caption = 'Air Ticket Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Air Ticket Available Budget field';
                }
                field("Air Ticket Amount"; "Air Ticket Amount")
                {
                    ToolTip = 'Specifies the value of the Air Ticket Amount field';
                }

                //"Conference Amount"
                field("Source of Funds Conference"; "Source of Funds Conference")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Conference';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Conference Available Budget"; "Conference Available Budget")
                {
                    Caption = 'Conference Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Conference Available Budget field';
                }
                field("Conference Amount"; "Conference Amount")
                {
                    ToolTip = 'Specifies the value of the Conference Amount field';
                }

                // "Ground Transport Amount"
                field("Source of Funds GTransport"; "Source of Funds GTransport")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds GTransport';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("GTransport Available Budget"; "GTransport Available Budget")
                {
                    Caption = 'GTransport Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the GTransport Available Budget field';
                }
                field("Ground Transport Amount"; "Ground Transport Amount")
                {
                    ToolTip = 'Specifies the value of the Ground Transport Amount field';
                }

                // "Accomodation Amount"
                field("Source of Funds Accomodation"; "Source of Funds Accommodation")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Accomodation';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Accommodation Available Budget"; "Accommodation Available Budget")
                {
                    Caption = 'Accomodation Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Accomodation Available Budget field';
                }
                field("Accomodation Amount"; "Accomodation Amount")
                {
                    ToolTip = 'Specifies the value of the Accomodation Amount field';
                }

                //"Cordination Allowance Amount"
                field("Source of Funds Coordination"; "Source of Funds Coordination")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Coordination';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Coordination Allowance Available Budget"; "Coordination Allowance Available Budget")
                {
                    Caption = 'Coordination Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Coordination Available Budget field';
                }
                field("Cordination Allowance Amount"; "Cordination Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Cordination Allowance Amount field';
                }

                //"Facilitator Allowance Amount"
                field("Source of Funds Facilitator"; "Source of Funds Facilitator")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Facilitator';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Facilitator Allowance Available Budget"; "Facilitator Allowance Available Budget")
                {
                    Caption = 'Facilitator Allowance Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Facilitator Allowance Available Budget field';
                }
                field("Facilitator Allowance Amount"; "Facilitator Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Facilitator Allowance Amount field';
                }

                //"Secretariat Allowance Amount"
                field("Source of Funds Secretariat"; "Source of Funds Secretariat")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Secretariat';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Secretariat Allowance Available Budget"; "Secretariat Allowance Available Budget")
                {
                    Caption = 'Secretariat Allowance Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Secretariat Allowance Available Budget field';
                }
                field("Secretariat Allowance Amount"; "Secretariat Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Secretariat Allowance Amount field';
                }


                //"Rapporteur Allowance Amount"
                field("Source of Funds Rapporteur"; "Source of Funds Rapporteur")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Rapporteur';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Rapporteur Allowance Available Budget"; "Rapporteur Allowance Available Budget")
                {
                    Caption = 'Rapporteur Allowance Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Rapporteur Allowance Available Budget field';
                }
                field("Rapporteur Allowance Amount"; "Rapporteur Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Rapporteur Allowance Amount field';
                }

                //"Driver Allowance Amount"
                field("Source of Funds Driver Allowance"; "Source of Funds Driver")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Driver Allowance';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Driver Allowance Available Budget"; "Driver Allowance Available Budget")
                {
                    Caption = 'Driver Allowance Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Driver Allowance Available Budget field';
                }
                field("Driver Allowance Amount"; "Driver Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Driver Allowance Amount field';
                }

                //"Retreat Allowance Amount"
                field("Source of Funds Retreat"; "Source of Funds Retreat")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Retreat';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Retreat Allowance Available Budget"; "Retreat Allowance Available Budget")
                {
                    Caption = 'Retreat Allowance Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Retreat Allowance Available Budget field';
                }
                field("Retreat Allowance Amount"; "Retreat Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Retreat Allowance Amount field';
                }

                //"Expert Allowance Amount"
                field("Source of Funds Expert"; "Source of Funds Expert")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Expert';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Expert Allowance Available Budget"; "Expert Allowance Available Budget")
                {
                    Caption = 'Expert Allowance Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Expert Allowance Available Budget field';
                }
                field("Expert Allowance Amount"; "Expert Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Expert Allowance Amount field';
                }

                //"Tuition Fee Amount"
                field("Source of Funds Tuition"; "Source of Funds Tuition")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Tuition';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Tuition Fee Available Budget"; "Tuition Fee Available Budget")
                {
                    Caption = 'Tuition Fee Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Tuition Fee Available Budget field';
                }
                field("Tuition Fee Amount"; "Tuition Fee Amount")
                {
                    ToolTip = 'Specifies the value of the Tuition Fee Amount field';
                }

                //"Mileage Allowance Amount"
                field("Source of Funds Mileage"; "Source of Funds Mileage")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Mileage';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Mileage Allowance Available Budget"; "Mileage Allowance Available Budget")
                {
                    Caption = 'Mileage Allowance Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mileage Allowance Available Budget field';
                }
                field("Mileage Allowance Amount"; "Mileage Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Mileage Allowance Amount field';
                }

                //"Quarter Per Diem Amount"
                field("Source of Funds QPer Diem"; "Source of Funds QPer Diem")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds QPer Diem';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Quarter Per Diem Available Budget"; "Quarter Per Diem Available Budget")
                {
                    Caption = 'Quarter Per Diem Available Budget';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quarter Per Diem Available Budget field';
                }
                field("Quarter Per Diem Amount"; "Quarter Per Diem Amount")
                {
                    ToolTip = 'Specifies the value of the Quarter Per Diem Amount field';
                }

                //"Other Costs Amount"


                field("Other Costs Amount"; "Other Costs Amount")
                {
                    ToolTip = 'Specifies the value of the Other Costs Amount field';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount (LCY) field';
                }
                field(BudgetAmount; BudgetAmount)
                {
                    Caption = 'Budget Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Budget Amount field';

                    trigger OnDrillDown()
                    begin

                        // GLBudgetEntry.Reset();
                        // GLBudgetEntry.SetFilter("G/L Account No.", Rec."G/L Account");
                        // GLBudgetEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                        // GLBudgetEntry.SetRange(Date, BudgetStartDate, Rec."Start Date");
                        // Page.Run(Page::"G/L Budget Entries", GLBudgetEntry);
                    end;
                }
                field(Expenses; Expenses)
                {
                    Caption = 'Expenses';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Expenses field';

                    trigger OnDrillDown()
                    begin
                        // GLEntry.Reset();
                        // GLEntry.SetFilter("G/L Account No.", Rec."G/L Account");
                        // GLEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                        // GLEntry.SetRange("Posting Date", BudgetStartDate, Rec."Start Date");
                        // Page.Run(Page::"General Ledger Entries", GLEntry);
                    end;
                }
                field(TrainingAmount; TrainingAmount)
                {
                    Caption = 'Training Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Training Amount field';

                    trigger OnDrillDown()
                    begin
                        // TrainingNeedLines.Reset();
                        // TrainingNeedLines.SetRange("G/L Account", Rec."G/L Account");
                        // TrainingNeedLines.SetRange("Start Date", BudgetStartDate, Rec."Start Date");
                        // TrainingNeedLines.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                        // TrainingNeedLines.SetFilter(Status, '<>%1', TrainingNeedLines.Status::Open);
                        // Page.Run(Page::"Training Needs Line", TrainingNeedLines);
                    end;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        GetBudgetAvailable();
    end;

    trigger OnOpenPage()
    begin
        GetBudgetAvailable();
    end;

    var
        GLBudgetEntry: Record "G/L Budget Entry";
        GLEntry: Record "G/L Entry";
        TrainingNeedLines: Record "Training Needs Lines";
        BudgetStartDate: Date;
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        Expenses: Decimal;
        TrainingAmount: Decimal;

    local procedure GetBudgetAvailable()
    var
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        AccountNo: Code[20];
    begin
        //AccountNoFilter:='';
        AccountNo := '';
        BudgetAmount := 0;
        Expenses := 0;
        BudgetAvailable := 0;
        TrainingAmount := 0;
        GenLedSetup.Get();
        BudgetStartDate := GenLedSetup."Current Budget Start Date";
        GLAccount.Reset();
        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
        GLAccount.SetFilter(GLAccount."No.", Rec."G/L Account");
        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", Rec."Dimension Set ID");
        GLAccount.SetRange(GLAccount."Date Filter", BudgetStartDate, Rec."Start Date");
        if GLAccount.Find('-') then begin
            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
            BudgetAmount := GLAccount."Approved Budget";
            Expenses := GLAccount."Net Change";
        end;

        TrainingNeedLines.Reset();
        TrainingNeedLines.SetRange("G/L Account", Rec."G/L Account");
        TrainingNeedLines.SetRange("Start Date", BudgetStartDate, Rec."Start Date");
        TrainingNeedLines.SetRange("Dimension Set ID", Rec."Dimension Set ID");
        TrainingNeedLines.SetFilter(Status, '<>%1', TrainingNeedLines.Status::Open);
        if TrainingNeedLines.FindFirst() then begin
            TrainingNeedLines.CalcSums(Amount);
            TrainingAmount := TrainingNeedLines.Amount;
        end;

        BudgetAvailable := BudgetAmount - (Expenses + TrainingAmount);
    end;
}





