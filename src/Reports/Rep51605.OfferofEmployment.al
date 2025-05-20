report 51605 "Offer of Employment"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Offer of Employment.rdl';

    dataset
    {
        dataitem(Applicant; Applicant)
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(OfferDate; Format(Today, 0, 4))
            {
            }
            column(FullName; Applicant."First Name" + ' ' + Applicant."Middle Name" + ' ' + Applicant."Last Name")
            {
            }
            column(POBox; Applicant."Postal Address")
            {
            }
            column(City; Applicant.City)
            {
            }
            column(FirstName; Applicant."First Name")
            {
            }
            column(Title; ReportTitle)
            {
            }
            column(BeforeTitle; BeforeTitle)
            {
            }
            column(JobTitle; Applicant."Position Applied For")
            {
            }
            column(EffectiveDate; Applicant."Employment Date")
            {
            }
            column(OfficeLocation; Applicant."Office Location")
            {
            }
            column(ProbationPeriod; Applicant."Probation Period")
            {
            }
            column(ProbationTerminationPeriod; Applicant."Probation Termination Notice")
            {
            }
            column(AnnualLeaveDays; Applicant."Annual Leave Days")
            {
            }
            column(LeaveNoticePeriod; Applicant."Leave Notice Period")
            {
            }
            column(ContractTerminationNotice; Applicant."Contract Termination Notice")
            {
            }
            column(HoursWorkedPerWeek; Applicant."Hours Worked Per Week")
            {
            }
            column(DaysWorkedPerWeek; Applicant."Days Worked Per Week")
            {
            }
            column(ReportingTime; Applicant."Reporting Time")
            {
            }
            column(ClosingTime; Applicant."Closing Time")
            {
            }
            column(LunchBreakDuration; Applicant."Lunch Break Duration")
            {
            }
            column(LunchStartTime; Applicant."Lunch Start Time")
            {
            }
            column(LunchEndTime; Applicant."Lunch End Time")
            {
            }
            column(FirstDayOfWeek; Applicant."Week Start Day")
            {
            }
            column(LastDayOfWeek; Applicant."Week End Day")
            {
            }
            column(OfferSignedBy; Applicant."Offer Signed By")
            {
            }
            column(Dimension1; Dimension1)
            {
            }
            column(AnnualSalary; Applicant."Annual Gross Salary")
            {
            }
            column(EarningOne; Earning[1])
            {
            }
            column(EarningTwo; Earning[2])
            {
            }
            column(EarningThree; Earning[3])
            {
            }
            column(AmountOne; EarningAmount[1])
            {
            }
            column(AmountTwo; EarningAmount[2])
            {
            }
            column(AmountThree; EarningAmount[3])
            {
            }
            column(LCYCode; GLSetup."LCY Code")
            {
            }
            column(AmountInWord; NumberText[1])
            {
            }
            column(HRName; HRName)
            {
            }
            column(HREmail; HREmail)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if CopyStr(Applicant."Position Applied For", 1, 1)in['A', 'a', 'E', 'e', 'I', 'i', 'O', 'o', 'U', 'u']then BeforeTitle:='an'
                else
                    BeforeTitle:='a';
                i:=0;
                ApplicantOffers.Reset;
                ApplicantOffers.SetRange("Applicant No.", Applicant."No.");
                if ApplicantOffers.Find('-')then begin
                    repeat i:=i + 1;
                        if Earn.Get(ApplicantOffers."Earning Code")then Earning[i]:=Earn.Description;
                        EarningAmount[i]:=ApplicantOffers.Amount;
                    until ApplicantOffers.Next = 0;
                end;
                GLSetup.Get;
                if RecruitmentNeed.Get(Applicant."Vacancy No.")then Dimension1:=RecruitmentNeed."Global Dimension 1 Code";
                If Applicant."Salary Currency" <> '' then CurrencyCodeText:=Applicant."Salary Currency"
                else
                    CurrencyCodeText:=GLSetup."LCY Code";
                InitTextVariable;
                FormatNoText(NumberText, Applicant."Annual Gross Salary", CurrencyCodeText);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Print Without Logo"; PrintWithoutLogo)
                {
                    ApplicationArea = All;
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
        if not PrintWithoutLogo then begin
            CompInfo.Get;
            CompInfo.CalcFields(Picture);
        end;
        HRSetUp.Get;
        If Emp.Get(HRSetUp."HR Manager")then begin
            HRName:=Emp.FullName();
            HREmail:=Emp."Company E-Mail";
        end;
    end;
    var CompInfo: Record "Company Information";
    PrintWithoutLogo: Boolean;
    ReportTitle: Label 'OFFER OF APPOINTMENT';
    BeforeTitle: Text;
    AmountInWord: Text;
    ApplicantOffers: Record "Applicant Offers";
    Earn: Record Earnings;
    Earning: array[3]of Text;
    EarningAmount: array[3]of Decimal;
    i: Integer;
    GLSetup: Record "General Ledger Setup";
    HRSetUp: Record "QuantumJumps HR Setup";
    Emp: Record Employee;
    HRName: Text;
    HREmail: Text;
    RecruitmentNeed: Record "Recruitment Needs";
    Dimension1: Code[20];
    NumberText: array[2]of Text[80];
    OnesText: array[20]of Text[30];
    TensText: array[10]of Text[30];
    ExponentText: array[5]of Text[30];
    Text026: Label 'ZERO';
    Text027: Label 'HUNDRED';
    Text028: Label 'AND';
    Text029: Label '%1 results in a written number that is too long.';
    CurrencyCodeText: Code[10];
    Text032: Label 'ONE';
    Text033: Label 'TWO';
    Text034: Label 'THREE';
    Text035: Label 'FOUR';
    Text036: Label 'FIVE';
    Text037: Label 'SIX';
    Text038: Label 'SEVEN';
    Text039: Label 'EIGHT';
    Text040: Label 'NINE';
    Text041: Label 'TEN';
    Text042: Label 'ELEVEN';
    Text043: Label 'TWELVE';
    Text044: Label 'THIRTEEN';
    Text045: Label 'FOURTEEN';
    Text046: Label 'FIFTEEN';
    Text047: Label 'SIXTEEN';
    Text048: Label 'SEVENTEEN';
    Text049: Label 'EIGHTEEN';
    Text050: Label 'NINETEEN';
    Text051: Label 'TWENTY';
    Text052: Label 'THIRTY';
    Text053: Label 'FORTY';
    Text054: Label 'FIFTY';
    Text055: Label 'SIXTY';
    Text056: Label 'SEVENTY';
    Text057: Label 'EIGHTY';
    Text058: Label 'NINETY';
    Text059: Label 'THOUSAND';
    Text060: Label 'MILLION';
    Text061: Label 'BILLION';
    procedure FormatNoText(var NoText: array[2]of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        Clear(NoText);
        NoTextIndex:=1;
        NoText[1]:='****';
        if No < 1 then AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else
        begin
            for Exponent:=4 downto 1 do begin
                PrintExponent:=false;
                Ones:=No div Power(1000, Exponent - 1);
                Hundreds:=Ones div 100;
                Tens:=(Ones mod 100) div 10;
                Ones:=Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end
                else if(Tens * 10 + Ones) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1)then AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;
        //AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        //AddToNoText(NoText, NoTextIndex, PrintExponent, Format(No * 100) + '/100');
        if CurrencyCode <> '' then AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
        AddToNoText(NoText, NoTextIndex, PrintExponent, '****');
    end;
    local procedure AddToNoText(var NoText: array[2]of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent:=true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1])do begin
            NoTextIndex:=NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText)then Error(Text029, AddText);
        end;
        NoText[NoTextIndex]:=DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;
    procedure InitTextVariable()
    begin
        OnesText[1]:=Text032;
        OnesText[2]:=Text033;
        OnesText[3]:=Text034;
        OnesText[4]:=Text035;
        OnesText[5]:=Text036;
        OnesText[6]:=Text037;
        OnesText[7]:=Text038;
        OnesText[8]:=Text039;
        OnesText[9]:=Text040;
        OnesText[10]:=Text041;
        OnesText[11]:=Text042;
        OnesText[12]:=Text043;
        OnesText[13]:=Text044;
        OnesText[14]:=Text045;
        OnesText[15]:=Text046;
        OnesText[16]:=Text047;
        OnesText[17]:=Text048;
        OnesText[18]:=Text049;
        OnesText[19]:=Text050;
        TensText[1]:='';
        TensText[2]:=Text051;
        TensText[3]:=Text052;
        TensText[4]:=Text053;
        TensText[5]:=Text054;
        TensText[6]:=Text055;
        TensText[7]:=Text056;
        TensText[8]:=Text057;
        TensText[9]:=Text058;
        ExponentText[1]:='';
        ExponentText[2]:=Text059;
        ExponentText[3]:=Text060;
        ExponentText[4]:=Text061;
    end;
}
