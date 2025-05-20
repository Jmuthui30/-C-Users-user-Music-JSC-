report 52200 "Accrued Expenses Schedule"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSRS/Accrued Expenses Schedule.rdlc';

    dataset
    {
        dataitem("Amortization Header"; "Amortization Header")
        {
            DataItemTableView = WHERE(Type=CONST("Accrued Expenses"));
            RequestFilterFields = No, "Vendor No";

            column(Logo; CompInfo.Picture)
            {
            }
            column(Title; Title)
            {
            }
            column(Description; "Amortization Header".Description)
            {
            }
            column(PrepaymentAmount; "Amortization Header"."Prepayment Amount")
            {
            }
            column(Additions; "Amortization Header"."Total Addition")
            {
            }
            column(BF; BF)
            {
            }
            column(PeriodsCovered; "Amortization Header"."No of Periods")
            {
            }
            column(PeriodName1; PeriodName[1])
            {
            }
            column(PeriodAmount1; PeriodAmount[1])
            {
            }
            column(PeriodName2; PeriodName[2])
            {
            }
            column(PeriodAmount2; PeriodAmount[2])
            {
            }
            column(PeriodName3; PeriodName[3])
            {
            }
            column(PeriodAmount3; PeriodAmount[3])
            {
            }
            column(PeriodName4; PeriodName[4])
            {
            }
            column(PeriodAmount4; PeriodAmount[4])
            {
            }
            column(PeriodName5; PeriodName[5])
            {
            }
            column(PeriodAmount5; PeriodAmount[5])
            {
            }
            column(PeriodName6; PeriodName[6])
            {
            }
            column(PeriodAmount6; PeriodAmount[6])
            {
            }
            column(PeriodName7; PeriodName[7])
            {
            }
            column(PeriodAmount7; PeriodAmount[7])
            {
            }
            column(PeriodName8; PeriodName[8])
            {
            }
            column(PeriodAmount8; PeriodAmount[8])
            {
            }
            column(PeriodName9; PeriodName[9])
            {
            }
            column(PeriodAmount9; PeriodAmount[9])
            {
            }
            column(PeriodName10; PeriodName[10])
            {
            }
            column(PeriodAmount10; PeriodAmount[10])
            {
            }
            column(PeriodName11; PeriodName[11])
            {
            }
            column(PeriodAmount11; PeriodAmount[11])
            {
            }
            column(PeriodName12; PeriodName[12])
            {
            }
            column(PeriodAmount12; PeriodAmount[12])
            {
            }
            column(CF; CF)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Amortization Header".CalcFields("Total Addition");
                PeriodAmount[1]:=0;
                PeriodAmount[2]:=0;
                PeriodAmount[3]:=0;
                PeriodAmount[4]:=0;
                PeriodAmount[5]:=0;
                PeriodAmount[6]:=0;
                PeriodAmount[7]:=0;
                PeriodAmount[8]:=0;
                PeriodAmount[9]:=0;
                PeriodAmount[10]:=0;
                PeriodAmount[11]:=0;
                PeriodAmount[12]:=0;
                //End date
                //EndDate
                if "Amortization Header"."Starting Period" <> 0D then begin
                    if "Amortization Header"."No of Periods" = 0 then Error('No. of Periods the schedule %1 cannot be zero!', "Amortization Header".Description);
                    if "Amortization Header"."Period Length" = "Amortization Header"."Period Length"::Monthly then EndDate:=CalcDate('11M', StartDate)
                    else if "Amortization Header"."Period Length" = "Amortization Header"."Period Length"::Quarterly then EndDate:=CalcDate('4Q', StartDate - 31)
                        else if "Amortization Header"."Period Length" = "Amortization Header"."Period Length"::"Semi-Annually" then EndDate:=CalcDate('11M', StartDate)
                            else if "Amortization Header"."Period Length" = "Amortization Header"."Period Length"::Annually then EndDate:=CalcDate('1Y', StartDate - 31);
                end;
                //BF
                BF:=0;
                PrepLines.Reset;
                PrepLines.SetCurrentKey(No, Period);
                PrepLines.SetRange(No, "Amortization Header".No);
                PrepLines.SetFilter(Period, '%1..%2', 0D, StartDate - 1);
                PrepLines.CalcSums(Amount);
                BF:=PrepLines.Amount;
                //Current Period
                i:=1;
                PrepLines.Reset;
                PrepLines.SetCurrentKey(No, Period);
                PrepLines.SetRange(No, "Amortization Header".No);
                PrepLines.SetFilter(Period, '%1..%2', StartDate, EndDate);
                if PrepLines.Find('-')then begin
                    repeat PeriodName[i]:=PrepLines."Period Name";
                        PeriodAmount[i]:=PrepLines.Amount;
                        i:=i + 1;
                    until PrepLines.Next = 0 end;
                //CF
                CF:=0;
                PrepLines.Reset;
                PrepLines.SetCurrentKey(No, Period);
                PrepLines.SetRange(No, "Amortization Header".No);
                PrepLines.SetFilter(Period, '>%1', EndDate);
                PrepLines.CalcSums(Amount);
                CF:=PrepLines.Amount;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(YearStartDate; YearStartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Financial Year Start Date';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        if YearStartDate = 0D then Error('Please a start date for the year.');
        StartDate:=DMY2Date(1, Date2DMY(YearStartDate, 2), Date2DMY(YearStartDate, 3));
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        Title:=StrSubstNo(Text000, UpperCase(Format(StartDate, 0, '<Month Text,3>-<Year4>')));
    end;
    var YearStartDate: Date;
    StartDate: Date;
    PrepLines: Record "Amortization Lines";
    BF: Decimal;
    i: Integer;
    PeriodName: array[20]of Text;
    PeriodAmount: array[20]of Decimal;
    EndDate: Date;
    CF: Decimal;
    CompInfo: Record "Company Information";
    Periods: Integer;
    Text000: Label 'ACCRUED EXPENSES ANALYSIS AS AT %1';
    Title: Text;
}
