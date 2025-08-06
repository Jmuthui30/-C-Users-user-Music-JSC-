codeunit 50003 "HR Dates Mgt"
{
    trigger OnRun()
    begin
    end;

    procedure DetermineDatesDiffrence(FromDate: Date; ToDate: Date) DiffString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        if ((FromDate <> 0D) and (ToDate <> 0D)) then begin
            dayB := Date2DMY(FromDate, 1);
            monthB := Date2DMY(FromDate, 2);
            yearB := Date2DMY(FromDate, 3);
            dayJ := Date2DMY(ToDate, 1);
            monthJ := Date2DMY(ToDate, 2);
            yearJ := Date2DMY(ToDate, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else if (dayJ < dayB) then begin
                            Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                            Month := Month - 1;
                        end;
                        DiffString := '%1Y, %2M & %3D';
                        DiffString := StrSubstNo(DiffString, Year, Month, Day);
                    end;
                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then begin
                            if monthJ >= monthB then
                                Month := monthJ - monthB
                            else
                                Error('The wrong date category!');
                        end;
                        if (dayJ <> dayB) then begin
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;
                        end;
                        DiffString := '%1M & %2D';
                        DiffString := StrSubstNo(DiffString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        DiffString := '%1Y';
                        DiffString := StrSubstNo(DiffString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else if (dayJ < dayB) then begin
                            Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                            monthJ := monthJ - 1;
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        DiffString := '%1Y, %2M & %3D';
                        DiffString := StrSubstNo(DiffString, Year, Month, Day);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        DiffString := '%1Y & %2M';
                        DiffString := StrSubstNo(DiffString, Year, Month);
                    end;
                else
                    DiffString := '';
            end;
        end
        else
            Message('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;
    //***********************************************************************************
    procedure DetermineYearDiffrence(FromDate: Date; ToDate: Date) DiffString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        if ((FromDate <> 0D) and (ToDate <> 0D)) then begin
            dayB := Date2DMY(FromDate, 1);
            monthB := Date2DMY(FromDate, 2);
            yearB := Date2DMY(FromDate, 3);
            dayJ := Date2DMY(ToDate, 1);
            monthJ := Date2DMY(ToDate, 2);
            yearJ := Date2DMY(ToDate, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else if (dayJ < dayB) then begin
                            Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                            Month := Month - 1;
                        end;
                        DiffString := '%1Y';
                        DiffString := StrSubstNo(DiffString, Year);
                    end;
                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then begin
                            if monthJ >= monthB then
                                Month := monthJ - monthB
                            else
                                Error('The wrong date category!');
                        end;
                        if (dayJ <> dayB) then begin
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;
                        end;
                        DiffString := '%1M & %2D';
                        DiffString := StrSubstNo(DiffString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        DiffString := '%1Y';
                        DiffString := StrSubstNo(DiffString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else if (dayJ < dayB) then begin
                            Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                            monthJ := monthJ - 1;
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        DiffString := '%1Y';
                        DiffString := StrSubstNo(DiffString, Year);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        DiffString := '%1Y';
                        DiffString := StrSubstNo(DiffString, Year);
                    end;
                else
                    DiffString := '';
            end;
        end
        else
            Message('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;

    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer
    begin
        if ((EYear > BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 1
        else if ((EYear = BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
            Category := 2
        else if ((EYear = BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
            Category := 3
        else if ((EYear > BYear) and (EMonth = BMonth) and (EDay = BDay)) then
            Category := 4
        else if ((EYear > BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
            Category := 5
        else if ((EYear > BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
            Category := 6
        else if ((EYear = BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 7
        else if ((EYear = BYear) and (EMonth = BMonth) and (EDay = BDay)) then
            Category := 3
        else begin
            Category := 0;
            //ERROR('The start date cannot be after the end date.');
        end;
        exit;
    end;

    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer
    begin
        case (Month) of
            1:
                DaysInMonth := 31;
            2:
                begin
                    if (LeapYear(Year)) then
                        DaysInMonth := 29
                    else
                        DaysInMonth := 28;
                end;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            else
                Message('Not valid date. The month must be between 1 and 12');
        end;
        exit;
    end;

    procedure LeapYear(Year: Integer) LY: Boolean
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year mod 100 = 0;
        DivByFour := Year mod 4 = 0;
        if ((not CenturyYear and DivByFour) or (Year mod 400 = 0)) then
            LY := true
        else
            LY := false;
    end;
    procedure GetDecimalFromDiffString(DiffString: Text): Decimal
var
    Y, M, D: Integer;
    YearPos: Integer;
    MonthPos: Integer;
    DayPos: Integer;
    Comma1Pos: Integer;
    AmpersandPos: Integer;
    TempText: Text[10];
    DecimalAge: Decimal;
begin
    // Clean the text
    DiffString := DelChr(DiffString, '=', ' ');

    // Get positions of markers
    YearPos := StrPos(DiffString, 'Y');
    MonthPos := StrPos(DiffString, 'M');
    DayPos := StrPos(DiffString, 'D');
    Comma1Pos := StrPos(DiffString, ',');     // between Y and M
    AmpersandPos := StrPos(DiffString, '&');  // between M and D

    // Extract Year
    if YearPos > 1 then begin
        TempText := CopyStr(DiffString, 1, YearPos - 1); // gets value before 'Y'
        Evaluate(Y, TempText);
    end;

    // Extract Month (between comma and 'M')
    if (Comma1Pos > 0) and (MonthPos > 0) then begin
        TempText := CopyStr(DiffString, Comma1Pos + 2, MonthPos - (Comma1Pos + 2)); // gets value before 'M'
        Evaluate(M, TempText);
    end;

    // Extract Day (between '&' and 'D')
    if (AmpersandPos > 0) and (DayPos > 0) then begin
        TempText := CopyStr(DiffString, AmpersandPos + 2, DayPos - (AmpersandPos + 2));
        Evaluate(D, TempText);
    end;

    // Round the months if D > 15
    if D > 15 then
        M += 1;

    // Convert 12 months into a year
    if M = 12 then begin
        Y += 1;
        M := 0;
    end;

    DecimalAge := Y + (M / 12);
    exit(DecimalAge);
end;

}
