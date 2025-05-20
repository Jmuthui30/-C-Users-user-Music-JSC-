table 50465 "Imprest Memo Lines"
{
    Caption = 'Imprest Memo Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Type"; Option)
        {
            OptionMembers = Staff, Expert;
            Caption = 'Type';
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = Employee where(Status=const(Active));

            trigger OnValidate()
            begin
                CheckEmployeeValidity(Rec."Account No.");
            end;
        }
        field(5; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; Title; Text[50])
        {
            Caption = 'Title';
        }
        field(9; Cordinator; Boolean)
        {
            Caption = 'Cordinator';

            trigger OnValidate()
            begin
                if(Rec.Cordinator <> xRec.Cordinator) and (Rec.Cordinator = true)then begin
                    if Rec.Secretary then Error('One cannot be a Secretary and Cordinator at the same event!');
                    GetHeader();
                    if not Header."Cordination Allowance" then Error('Cordination Allowance should be enabled on the Memo Options above for you to nominate a cordinator.');
                    ImprestSetup.Get();
                    MemoLines.Reset();
                    MemoLines.SetRange("No.", Header."No.");
                    MemoLines.SetRange(Cordinator, true);
                    if MemoLines.Count > ImprestSetup."Max. No. of Cordinators" - 1 then Error('Maximum Number of Cordinators per event cannot be more than ' + Format(ImprestSetup."Max. No. of Cordinators"));
                end;
                GetDefaultAllowances(Rec);
            end;
        }
        field(10; Facilitator; Boolean)
        {
            Caption = 'Facilitator';

            trigger OnValidate()
            begin
                if(Rec.Facilitator <> xRec.Facilitator) and (Rec.Facilitator = true)then begin
                    GetHeader();
                    if not Header."Facilitator Allowance" then Error('Facilitator Allowance should be enabled on the Memo Options above for you to nominate a facilitator.');
                    ImprestSetup.Get();
                    MemoLines.Reset();
                    MemoLines.SetRange("No.", Header."No.");
                    MemoLines.SetRange(Facilitator, true);
                    if MemoLines.Count > ImprestSetup."Max. No. of Facilitators" - 1 then Error('Maximum Number of Facilitators per event cannot be more than ' + Format(ImprestSetup."Max. No. of Facilitators"));
                end;
                GetDefaultAllowances(Rec);
            end;
        }
        field(11; Secretary; Boolean)
        {
            Caption = 'Secretary';

            trigger OnValidate()
            begin
                if(Rec.Secretary <> xRec.Secretary) and (Rec.Secretary = true)then begin
                    GetHeader();
                    if not Header."Secretariat Allowance" then Error('Secretariat Allowance should be enabled on the Memo Options above for you to nominate a Seceretary.');
                    if Rec.Cordinator then Error('One cannot be a Secretary and Cordinator at the same event!');
                    ImprestSetup.Get();
                    MemoLines.Reset();
                    MemoLines.SetRange("No.", Header."No.");
                    MemoLines.SetRange(Secretary, true);
                    if MemoLines.Count > ImprestSetup."Max. No. of Secretaries" - 1 then Error('Maximum Number of Secretaries per event cannot be more than ' + Format(ImprestSetup."Max. No. of Secretaries"));
                end;
                GetDefaultAllowances(Rec);
            end;
        }
        field(12; Rapporteur; Boolean)
        {
            Caption = 'Rapporteur';

            trigger OnValidate()
            begin
                if(Rec.Rapporteur <> xRec.Rapporteur) and (Rec.Rapporteur = true)then begin
                    GetHeader();
                    if not Header."Rapporteur Allowance" then Error('Rapporteur Allowance should be enabled on the Memo Options above for you to nominate a Rapporteur.');
                    ImprestSetup.Get();
                    MemoLines.Reset();
                    MemoLines.SetRange("No.", Header."No.");
                    MemoLines.SetRange(Rapporteur, true);
                    if MemoLines.Count > ImprestSetup."Max. No. of Rapporteurs" - 1 then Error('Maximum Number of Rapporteurs per event cannot be more than ' + Format(ImprestSetup."Max. No. of Rapporteurs"));
                end;
                GetDefaultAllowances(Rec);
            end;
        }
        field(13; Driver; Boolean)
        {
            Caption = 'Driver';

            trigger OnValidate()
            begin
                if(Rec.Driver <> xRec.Driver) and (Rec.Driver = true)then begin
                    GetHeader();
                    if not Header."Driver Allowance" then Error('Driver Allowance should be enabled on the Memo Options above for you to nominate a Driver.');
                    ImprestSetup.Get();
                    MemoLines.Reset();
                    MemoLines.SetRange("No.", Header."No.");
                    MemoLines.SetRange(Driver, true);
                    if MemoLines.Count > ImprestSetup."Max. No. of Drivers" - 1 then Error('Maximum Number of Drivers per event cannot be more than ' + Format(ImprestSetup."Max. No. of Drivers"));
                end;
                GetDefaultAllowances(Rec);
            end;
        }
        field(14; Expert; Boolean)
        {
            Caption = 'Expert';

            trigger OnValidate()
            begin
                GetHeader();
                if not Header."Expert Allowance" then Error('Expert Allowance should be enabled on the Memo Options above for you to nominate an Expert.');
                if Rec.Type <> Rec.Type::Expert then error('This participant is a staff!');
                GetDefaultAllowances(Rec);
            end;
        }
        field(15; "Job Group"; Code[20])
        {
            Caption = 'Job Group';
        }
        field(16; Location; Code[20])
        {
            Caption = 'Location';
        }
        field(17; International; Boolean)
        {
            Caption = 'International';
        }
        field(18; Days; Integer)
        {
            Caption = 'Days';
        }
        field(19; Email; Text[100])
        {
            Caption = 'Email';
        }
        field(20; "Pay DSA"; Boolean)
        {
            Caption = 'Pay DSA';

            trigger OnValidate()
            begin
                if(Rec."Pay DSA" <> xRec."Pay DSA") and (Rec."Pay DSA" = true)then begin
                    GetHeader();
                    if not Header.DSA then Error('DSA Allowance should be enabled on the Memo Options above.');
                    if Rec.Type = Rec.Type::Expert then if Confirm('DSA is only payable to staff. Do you still want to pay DSA to an Expert?', false) = true then GetDefaultAllowances(Rec)
                        else
                            error('Aborted');
                end;
            end;
        }
        field(30; DSA; Decimal)
        {
            Caption = 'DSA';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField(DSA, true);
                GetTotals();
            end;
        }
        field(31; "Air Ticket"; Decimal)
        {
            Caption = 'Air Ticket';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Air Ticket", true);
                GetTotals();
            end;
        }
        field(32; Conference; Decimal)
        {
            Caption = 'Conference';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField(Conference, true);
                GetTotals();
            end;
        }
        field(33; "Ground Transport"; Decimal)
        {
            Caption = 'Ground Transport';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Ground Transport", true);
                GetTotals();
            end;
        }
        field(34; "Cordination Allowance"; Decimal)
        {
            Caption = 'Cordination Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Cordination Allowance", true);
                GetTotals();
            end;
        }
        field(35; "Facilitator Allowance"; Decimal)
        {
            Caption = 'Facilitator Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Facilitator Allowance", true);
                GetTotals();
            end;
        }
        field(36; "Secretariat Allowance"; Decimal)
        {
            Caption = 'Secretariat Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Secretariat Allowance", true);
                GetTotals();
            end;
        }
        field(37; "Out of Pocket Allowance"; Decimal)
        {
            Caption = 'Out of Pocket Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField(Accomodation, true);
                GetTotals();
            end;
        }
        field(38; "Rapporteur Allowance"; Decimal)
        {
            Caption = 'Rapporteur Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Rapporteur Allowance", true);
                GetTotals();
            end;
        }
        field(39; "Driver Allowance"; Decimal)
        {
            Caption = 'Driver Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Driver Allowance", true);
                GetTotals();
            end;
        }
        field(40; "Retreat Allowance"; Decimal)
        {
            Caption = 'Retreat Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Retreat Allowance", true);
                GetTotals();
            end;
        }
        field(41; "Expert Allowance"; Decimal)
        {
            Caption = 'Expert Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Expert Allowance", true);
                GetTotals();
            end;
        }
        field(42; Accomodation; Decimal)
        {
            Caption = 'Accomodation';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField(Accomodation, true);
                GetTotals();
            end;
        }
        field(43; "Tuition Fee"; Decimal)
        {
            Caption = 'Tuition Fee';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Tuition Fee", true);
                GetTotals();
            end;
        }
        field(44; "Mileage Allowance"; Decimal)
        {
            Caption = 'Mileage Allowance';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Mileage Allowance", true);
                GetTotals();
            end;
        }
        field(45; "Quarter Per Diem"; Decimal)
        {
            Caption = 'Quarter Per Diem';

            trigger OnValidate()
            begin
                GetHeader();
                Header.TestField("Quarter Per Diem", true);
                GetTotals();
            end;
        }
        field(46; "Other Costs"; Decimal)
        {
            Caption = 'Other Costs';

            trigger OnValidate()
            begin
                GetTotals();
            end;
        }
        field(50; Currency; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                GetHeader();
                ExchRate.Reset();
                ExchRate.SetRange("Currency Code", Rec.Currency);
                ExchRate.SetRange("Starting Date", 0D, Header.Date);
                if ExchRate.FindLast()then Rec."Exchange Rate":=ExchRate."Relational Exch. Rate Amount"
                else
                    Rec."Exchange Rate":=1;
                GetTotals();
            end;
        }
        field(51; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var Emp: Record "Client Employee Master";
    Leave: Record "Employee Leave Application";
    Imprest: Record "Imprest Header";
    Header: Record "Imprest Memo Header";
    DSARates: Record "AEA Listing";
    ImprestSetup: Record "Advanced Finance Setup";
    ExchRate: Record "Currency Exchange Rate";
    BCEmp: Record Employee;
    MemoLines: Record "Imprest Memo Lines";
    CommitmentMgt: Codeunit "Commitment Management";
    local procedure CheckEmployeeValidity(EmpNo: Code[20])
    begin
        Rec.TestField("Account No.");
        Emp.Get(Rec."Account No.");
        Emp.TestField(Scale);
        Rec."Job Group":=Emp.Scale;
        if Rec.Type = Rec.Type::Staff then begin
            BCEmp.Get(Rec."Account No.");
            Rec.Name:=BCEmp."First Name" + ' ' + BCEmp."Last Name";
            Rec.Title:=BCEmp."Job Title";
            Rec.Email:=BCEmp."Company E-Mail";
        end;
        GetHeader();
        //Check Employee On Leave
        Leave.Reset();
        Leave.SetRange("Employee No", EmpNo);
        Leave.SetRange("Start Date", 0D, Header."Start Date");
        Leave.SetRange("Resumption Date", Header."Start Date", Header."End Date");
        Leave.SetRange(Status, Leave.Status::Released);
        if Leave.FindFirst()then Error('An employee on leave cannot be picked for an event.');
        //Check Employee with unsurrendered imprest
        Imprest.Reset();
        Imprest.SetRange("Employee No.", EmpNo);
        Imprest.SetRange(Type, Imprest.Type::Surrender);
        Imprest.SetFilter(Status, '%1|%2', Imprest.Status::Open, Imprest.Status::Rejected);
        Imprest.SetRange("Surrender Posted", false);
        If Imprest.FindFirst()then Error('An employee with an unsurrendered imprest cannot be picked for an event.');
        GetDefaultAllowances(Rec);
    end;
    local procedure GetHeader()
    begin
        Rec.TestField("No.");
        Header.Get(Rec."No.");
        Header.TestField("Date");
        Header.TestField("Start Date");
        Header.TestField("Activity Location");
        Rec.International:=Header.International;
        if Rec.Type = Rec.Type::Staff then Rec."Pay DSA":=Header.DSA;
        Rec."Global Dimension 1 Code":=Header."Global Dimension 1 Code";
        Rec."Global Dimension 2 Code":=Header."Global Dimension 2 Code";
        Rec.Location:=Header."Activity Location";
        Rec.Days:=Header."Total Days in the Field";
    end;
    local procedure GetDefaultAllowances(var Rec: Record "Imprest Memo Lines")
    begin
        GetHeader();
        ImprestSetup.Get();
        //DSA
        if Rec.Type = Rec.Type::Staff then begin
            Rec."Pay DSA":=true;
            if DSARates.Get(Header."Activity Location", Rec."Job Group")then Rec.DSA:=DSARates.Total * Header."Total Days in the Field"
            else
                Error('DSA for location ' + Header."Activity Location" + ' has not been set up for the Job Group ' + Rec."Job Group");
        end
        else
        begin
            if Rec."Pay DSA" = false then Rec.DSA:=0;
        end;
        if Rec.Cordinator then Rec."Cordination Allowance":=ImprestSetup."Cordination Allowance" * (Header."Total Days in the Field" + 2)
        else
            Rec."Cordination Allowance":=0;
        if Rec.Rapporteur then Rec."Rapporteur Allowance":=ImprestSetup."Rapporteur Allowance" * Header."Total Days in the Field"
        else
            Rec."Rapporteur Allowance":=0;
        if Rec.Secretary then Rec."Secretariat Allowance":=ImprestSetup."Secretariat Allowance" * Header."Total Days in the Field"
        else
            Rec."Secretariat Allowance":=0;
        if Rec."Facilitator Allowance" = 0 then begin
            if Rec.Facilitator then Rec."Facilitator Allowance":=ImprestSetup."Facilitator Allowance" * Header."Total Days in the Field"
            else
                Rec."Facilitator Allowance":=0;
        end;
        if Rec.Driver then Rec."Driver Allowance":=ImprestSetup."Driver Allowance" * (Header."Total Days in the Field" + 2)
        else
            Rec."Driver Allowance":=0;
        if Header.Accomodation then begin
            //Out of Pocket
            if Header."Out of Pocket Allowance" then Rec."Out of Pocket Allowance":=ImprestSetup."Out of Pocket Allowance" * Header."Total Days in the Field"
            else
                Rec."Out of Pocket Allowance":=0;
            //Retreat Allowance
            MemoLines.Reset();
            MemoLines.SetRange("No.", Header."No.");
            if MemoLines.Count > ImprestSetup."Max. No. of Retreaters" then begin
                //Message('To get retreat allowance, the Maximum Number of participants per event cannot be more than ' + Format(ImprestSetup."Max. No. of Retreaters") + ' ,therefore no particpant qualifies for Retreat Allowance.');
                "Retreat Allowance":=0;
            end
            else
            begin
                if Header."Total Days in the Field" > ImprestSetup."Max. No. of Retreat Days" then "Retreat Allowance":=0
                else
                    "Retreat Allowance":=ImprestSetup."Retreat Allowance" * Header."Total Days in the Field";
            end;
            //Experts are not paid Retreat andOut of Pocket Allowances
            if Rec.Type = Rec.Type::Expert then begin
                Rec."Retreat Allowance":=0;
                Rec."Out of Pocket Allowance":=0;
            end;
        end;
        //Expert Allowance
        if Rec.Expert then Rec."Expert Allowance":=ImprestSetup."Expert Allowance" * Header."Total Days in the Field"
        else
            Rec."Expert Allowance":=0;
        GetTotals();
        CommitmentMgt.ImprestMemoBudgetCheck(Header);
    end;
    local procedure GetTotals()
    begin
        Rec.Amount:=Rec.DSA + Rec."Air Ticket" + Rec.Conference + Rec."Ground Transport" + Rec.Accomodation + Rec."Cordination Allowance" + Rec."Facilitator Allowance" + Rec."Secretariat Allowance" + Rec."Out of Pocket Allowance" + Rec."Rapporteur Allowance" + Rec."Driver Allowance" + Rec."Retreat Allowance" + Rec."Expert Allowance" + Rec."Tuition Fee" + Rec."Mileage Allowance" + Rec."Quarter Per Diem" + Rec."Other Costs";
        if Rec."Exchange Rate" = 0 then Rec."Exchange Rate":=1;
        Rec."Amount LCY":=Rec.Amount * Rec."Exchange Rate";
    end;
}
