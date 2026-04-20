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
                field("Source of Funds DSA Allocated"; "Source of Funds DSA Allocated")
                {
                    ToolTip = 'Specifies whether the DSA amount is allocated or not';
                }

                field("DSA Amount"; "DSA Amount")
                {
                    ToolTip = 'Specifies the value of the DSA Amount field';
                    Editable = false;

                }
                field("DSA Amount allocated"; "DSA Amount allocated")
                {
                    ToolTip = 'Specifies the value of the DSA Amount allocated field';
                }
                //"Air Ticket Amount"
                field("Air Ticket allocated"; "Air Ticket allocated")
                {
                    ToolTip = 'Specifies whether the Air Ticket amount is allocated or not';
                }
                field("Air Ticket Amount"; "Air Ticket Amount")
                {
                    ToolTip = 'Specifies the value of the Air Ticket Amount field';
                    Editable = false;
                }
                field("Air Ticket allocated Amount"; "Air Ticket allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Air Ticket allocated Amount field';
                }

                //"Conference Amount"
                field("Conference allocated"; "Conference allocated")
                {
                    ToolTip = 'Specifies whether the Conference amount is allocated or not';
                }
                field("Conference Amount"; "Conference Amount")
                {
                    ToolTip = 'Specifies the value of the Conference Amount field';
                    Editable = false;
                }
                field("Conference allocated Amount"; "Conference allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Conference allocated Amount field';
                }

                // "Ground Transport Amount"
                field("Ground Transport allocated"; "Source of Funds GTransport")
                {
                    ToolTip = 'Specifies whether the Ground Transport amount is allocated or not';
                }
                field("Ground Transport Amount"; "Ground Transport Amount")
                {
                    ToolTip = 'Specifies the value of the Ground Transport Amount field';
                    Editable = false;
                }
                field("Ground Transport allocated Amount"; "GroundT allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Ground Transport allocated Amount field';
                }

                // "Accomodation Amount"
                field("Source of Funds Accommodation"; "Source of Funds Accommodation")
                {
                    ToolTip = 'Specifies whether the Accomodation amount is allocated or not';
                }
                field("Accomodation Amount"; "Accomodation Amount")
                {
                    ToolTip = 'Specifies the value of the Accomodation Amount field';
                    Editable = false;
                }
                field("Accomodation allocated Amount"; "Accomodation allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Accomodation allocated Amount field';
                }


                //"Cordination Allowance Amount"
                field("Cordination Allowance allocated"; "Source of Funds Coordination")
                {
                    ToolTip = 'Specifies whether the Coordination Allowance amount is allocated or not';
                }
                field("Cordination Allowance Amount"; "Cordination Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Coordination Allowance Amount field';
                    Editable = false;
                }
                field("Coordination allocated Amount"; "Coordination allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Coordination Allowance allocated Amount field';
                }

                //"Facilitator Allowance Amount"
                field("Facilitator Allowance allocated"; "Source of Funds Facilitator")
                {
                    ToolTip = 'Specifies whether the Facilitator Allowance amount is allocated or not';
                }
                field("Facilitator Allowance Amount"; "Facilitator Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Facilitator Allowance Amount field';
                    Editable = false;
                }
                field("Facilitator allocated Amount"; "Facilitator allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Facilitator Allowance allocated Amount field';
                }


                //"Secretariat Allowance Amount"
                field("Secretariat Allowance allocated"; "Source of Funds Secretariat")
                {
                    ToolTip = 'Specifies whether the Secretariat Allowance amount is allocated or not';
                }
                field("Secretariat Allowance Amount"; "Secretariat Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Secretariat Allowance Amount field';
                    Editable = false;
                }
                field("Secretariat allocated Amount"; "Secretariat allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Secretariat Allowance allocated Amount field';
                }


                //"Rapporteur Allowance Amount"
                field("Rapporteur Allowance allocated"; "Source of Funds Rapporteur")
                {
                    ToolTip = 'Specifies whether the Rapporteur Allowance amount is allocated or not';
                }
                field("Rapporteur Allowance Amount"; "Rapporteur Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Rapporteur Allowance Amount field';
                    Editable = false;
                }
                field("Rapporteur allocated Amount"; "Rapporteur allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Rapporteur Allowance allocated Amount field';
                }


                //"Driver Allowance Amount"
                field("Driver Allowance allocated"; "Source of Funds Driver")
                {
                    ToolTip = 'Specifies whether the Driver Allowance amount is allocated or not';
                }
                field("Driver Allowance Amount"; "Driver Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Driver Allowance Amount field';
                    Editable = false;
                }
                field("Driver allocated Amount"; "Driver allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Driver Allowance allocated Amount field';
                }


                //"Retreat Allowance Amount"
                field("Retreat Allowance allocated"; "Source of Funds Retreat")
                {
                    ToolTip = 'Specifies whether the Retreat Allowance amount is allocated or not';
                }
                field("Retreat Allowance Amount"; "Retreat Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Retreat Allowance Amount field';
                    Editable = false;
                }
                field("Retreat allocated Amount"; "Retreat allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Retreat Allowance allocated Amount field';
                }



                //"Expert Allowance Amount"
                field("Expert Allowance allocated"; "Source of Funds Expert")
                {
                    ToolTip = 'Specifies whether the Expert Allowance amount is allocated or not';
                }
                field("Expert Allowance Amount"; "Expert Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Expert Allowance Amount field';
                    Editable = false;
                }
                field("Expert allocated Amount"; "Expert allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Expert Allowance allocated Amount field';
                }

                //"Tuition Fee Amount"
                field("Tuition Fee allocated"; "Source of Funds Tuition")
                {
                    ToolTip = 'Specifies whether the Tuition Fee amount is allocated or not';
                }
                field("Tuition Fee Amount"; "Tuition Fee Amount")
                {
                    ToolTip = 'Specifies the value of the Tuition Fee Amount field';
                    Editable = false;
                }
                field("Tuition allocated Amount"; "Tuition allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Tuition Fee allocated Amount field';
                }

                //"Mileage Allowance Amount"
                field("Mileage Allowance allocated"; "Source of Funds Mileage")
                {
                    ToolTip = 'Specifies whether the Mileage Allowance amount is allocated or not';
                }
                field("Mileage Allowance Amount"; "Mileage Allowance Amount")
                {
                    ToolTip = 'Specifies the value of the Mileage Allowance Amount field';
                    Editable = false;
                }
                field("Mileage allocated Amount"; "Mileage allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Mileage Allowance allocated Amount field';
                }

                //"Quarter Per Diem Amount"

                field("Quarter Per Diem allocated"; "Source of Funds QPer Diem")
                {
                    ToolTip = 'Specifies whether the Quarter Per Diem amount is allocated or not';
                }
                field("Quarter Per Diem Amount"; "Quarter Per Diem Amount")
                {
                    ToolTip = 'Specifies the value of the Quarter Per Diem Amount field';
                    Editable = false;
                }
                field("Quarter Per Diem allocated Amount"; "Quarter Per Diem allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Quarter Per Diem allocated Amount field';
                }

                //"Other Costs Amount"

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





