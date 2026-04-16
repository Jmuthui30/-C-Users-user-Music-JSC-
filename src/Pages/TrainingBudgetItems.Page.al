page 52286 "Training Budget Items"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Budget";
    Caption = 'Training Budget Items';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Budget Item No"; Rec."Budget Item No")
                {
                    // Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Budget Item No field';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }
                field("Approved Budget"; Rec."Approved Budget")
                {
                    ToolTip = 'Specifies the value of the Approved Budget field';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Estimated Cost field';
                }
                field(Actual; Rec.Actual)
                {
                    ToolTip = 'Specifies the value of the Actuals field';
                }
                field(Commitment; Rec.Commitment)
                {
                    ToolTip = 'Specifies the value of the Commitments field';
                }
                field("Source of Funds DSA"; "Source of Funds DSA")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds DSA';
                    ToolTip = 'Specifies the value of the Source of Funds field';
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
                field("Quarter Per Diem Amount"; "Quarter Per Diem Amount")
                {
                    ToolTip = 'Specifies the value of the Quarter Per Diem Amount field';
                }

                //"Other Costs Amount"
                field("Source of Funds Other Costs"; "Source of Funds Other Costs")
                {
                    TableRelation = "G/L Account";
                    Caption = 'Source of Funds Other Costs';
                    ToolTip = 'Specifies the value of the Source of Funds field';
                }

                field("Other Costs Amount"; "Other Costs Amount")
                {
                    ToolTip = 'Specifies the value of the Other Costs Amount field';
                }


                field("1stQuarter"; "1stQuarter")
                {
                    Caption = '1st Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 1st Quarter field';
                }
                field("2ndQuarter"; "2ndQuarter")
                {
                    Caption = '2nd Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 2nd Quarter field';
                }
                field("3rdQuarter"; "3rdQuarter")
                {
                    Caption = '3rd Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 3rd Quarter field';
                }
                field("4thQuarter"; "4thQuarter")
                {
                    Caption = '4th Quarter';
                    Visible = false;
                    ToolTip = 'Specifies the value of the 4th Quarter field';
                }
                field("Budget Year"; Rec."Training Year")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Training Year field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //GetQuarters;
    end;

    trigger OnOpenPage()
    begin
        //GetQuarters;
    end;

    var
        AccPeriod: Record "Accounting Period";
        TrainingBudget: Record "Training Budget";
        NewYear: Date;
        "1stQuarter": Decimal;
        "2ndQuarter": Decimal;
        "3rdQuarter": Decimal;
        "4thQuarter": Decimal;

    procedure GetQuarters1()
    begin
        AccPeriod.Reset();
        AccPeriod.SetRange(Closed, false);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('-') then
            NewYear := AccPeriod."Starting Date";
        //Get 1st Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, NewYear, CalcDate('1Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "1stQuarter" := Rec."Estimated Cost";
        end;
        //Get 2nd Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('1Q', NewYear) - 1, CalcDate('2Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "2ndQuarter" := Rec."Estimated Cost";
        end;
        //Get 3rd Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('2Q', NewYear) - 1, CalcDate('3Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "3rdQuarter" := Rec."Estimated Cost";
        end;
        //Get 4th Quarter Budget
        TrainingBudget.SetRange("Budget Item No", Rec."Budget Item No");
        TrainingBudget.SetRange(Date, CalcDate('3Q', NewYear) - 1, CalcDate('4Q', NewYear));
        if Rec.Find('-') then begin
            Rec.CalcSums("Estimated Cost");
            "4thQuarter" := Rec."Estimated Cost";
        end;
    end;
}





