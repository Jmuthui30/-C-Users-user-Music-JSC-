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
                        DiffString := '%1 Years, %2 Months & %3 Days';
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
                        DiffString := '%1 Months & %2 Days';
                        DiffString := StrSubstNo(DiffString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        DiffString := '%1 Years';
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
                        DiffString := '%1 Years, %2 Months & %3 Days';
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
                        DiffString := '%1 Years & %2 Months';
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
                        DiffString := '%1 Years';
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
                        DiffString := '%1 Years';
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
                        DiffString := '%1 Years';
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
                        DiffString := '%1 Years';
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
        Y, M, D : Integer;
        DecimalAge: Decimal;
        YearPos: Integer;
        MonthPos: Integer;
        DayPos: Integer;
        AmpersandPos: Integer;
        CommaPos: Integer;
        TempText: Text[100];
        StartPos: Integer;
    begin
        Y := 0;
        M := 0;
        D := 0;

        // Normalize format
        DiffString := DelChr(DiffString, '=', ' '); // remove all spaces
        DiffString := UpperCase(DiffString); // standardize casing

        // Find position markers - look for various formats
        YearPos := StrPos(DiffString, 'Y');
        if YearPos = 0 then
            YearPos := StrPos(DiffString, 'YEAR');

        MonthPos := StrPos(DiffString, 'M');
        if MonthPos = 0 then
            MonthPos := StrPos(DiffString, 'MONTH');

        DayPos := StrPos(DiffString, 'D');
        if DayPos = 0 then
            DayPos := StrPos(DiffString, 'DAY');

        AmpersandPos := StrPos(DiffString, '&');
        CommaPos := StrPos(DiffString, ',');

        // Extract Year (from start to first separator or Y/YEAR)
        if YearPos > 1 then begin
            TempText := CopyStr(DiffString, 1, YearPos - 1);
            if Evaluate(Y, TempText) then; // safely evaluate
        end;

        // Extract Month
        StartPos := 1;
        if (CommaPos > 0) then
            StartPos := CommaPos + 1
        else if (YearPos > 0) then
            StartPos := YearPos + 1;

        if MonthPos > StartPos then begin
            TempText := CopyStr(DiffString, StartPos, MonthPos - StartPos);
            // Clean any non-numeric characters
            TempText := DelChr(TempText, '=', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ,&');
            if Evaluate(M, TempText) then; // safely evaluate
        end;

        // Extract Day
        StartPos := 1;
        if (AmpersandPos > 0) then
            StartPos := AmpersandPos + 1
        else if (MonthPos > 0) then
            StartPos := MonthPos + 1
        else if (YearPos > 0) then
            StartPos := YearPos + 1;

        if DayPos > StartPos then begin
            TempText := CopyStr(DiffString, StartPos, DayPos - StartPos);
            // Clean any non-numeric characters
            TempText := DelChr(TempText, '=', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ,&');
            if Evaluate(D, TempText) then; // safely evaluate
        end;

        // Convert to decimal
        DecimalAge := Round(Y + (M / 12) + (D / 365), 0.01);
        exit(DecimalAge);
    end;

}
