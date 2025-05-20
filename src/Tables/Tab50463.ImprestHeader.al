table 50463 "Imprest Header"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Imprest, Retire & Claim';
    DataCaptionFields = "No.", "Employee No.";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            // Editable = true;
            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No.")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                    EmpRec.TestField("Travels Customer Account");
                    "Payroll No.":=EmpRec."Travels Customer Account";
                end;
                if NAVEmp.Get("Employee No.")then begin
                    "Job Title":=NAVEmp."Job Title";
                    "Employee Name":=NAVEmp.FullName();
                    "Phone No.":=NAVEmp."Mobile Phone No.";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(6; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(7; Date; Date)
        {
            trigger OnValidate()
            begin
            // AdvancedFinanceSetup.Get;
            // if AdvancedFinanceSetup."Employee Payment Terms" = '' then
            //     Error(Text000);
            // if PaymentTerms.Get(AdvancedFinanceSetup."Employee Payment Terms") then
            //     "Due Date" := CalcDate(PaymentTerms."Due Date Calculation", "Date");
            end;
        }
        field(8; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(9; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(10; Grade; Code[10])
        {
        }
        field(11; Level; Code[10])
        {
        }
        field(12; Country; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(13; City; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(14; "Total Request Amount"; Decimal)
        {
            CalcFormula = Sum("Imprest Details"."Request Amount" WHERE("No."=FIELD("No."), Decision=CONST("Pay Cash to Traveller")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(15; Type; Option)
        {
            OptionCaption = 'Request,Surrender';
            OptionMembers = Request, Surrender;
        }
        field(16; "No. Series"; Code[11])
        {
            TableRelation = "No. Series";
        }
        field(18; "Surrender Date"; Date)
        {
            Caption = 'Retirement Date';
            // Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Surrender Date" <> 0D then begin
                    if "Surrender Date" > "Due Date" then "Overdue Days":="Surrender Date" - "Due Date"
                    else
                        "Overdue Days":=0;
                end;
            end;
        }
        field(19; "Total Days in the Field"; Integer)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Total Days in the Field" <> 0 then "End Date":="Start Date" + "Total Days in the Field" - 1;
            end;
        }
        field(20; "Job Title"; Text[30])
        {
        }
        field(21; "Request Posted"; Boolean)
        {
            Editable = false;
        }
        field(22; "Request Posted By"; Code[50])
        {
            Editable = false;
        }
        field(23; "Request Posted Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Due Date":=CALCDATE(Format("Total Days in the Field") + 'D', "Request Posted Date");
            end;
        }
        field(24; "Surrender Posted"; Boolean)
        {
            Editable = false;
        }
        field(25; "Surrender Posted By"; Code[50])
        {
            Editable = false;
        }
        field(26; "Surrender Posted Date"; Date)
        {
            Editable = false;
        }
        field(27; "Total Surrender Amount"; Decimal)
        {
            CalcFormula = Sum("Imprest Details"."Actual Spent" WHERE("No."=FIELD("No."), Decision=CONST("Pay Cash to Traveller")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(28; "Total Claim"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Details".Claim WHERE("No."=FIELD("No."), Decision=CONST("Pay Cash to Traveller")));
        }
        field(29; "Total Refund"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Details".Refund WHERE("No."=FIELD("No."), Decision=CONST("Pay Cash to Traveller")));
        }
        field(30; "Net Refund (Net Claim)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Details".Difference WHERE("No."=FIELD("No.")));
        }
        field(31; "Paying Bank Code"; Code[10])
        {
            TableRelation = "Bank Account";
        }
        field(32; "Pay Mode"; Code[10])
        {
            TableRelation = "Pay Mode";
        }
        field(33; "Payment Tx No.(Cheque No.)"; Code[10])
        {
            trigger OnValidate()
            begin
                FinanceMgnt.CodeRegExChecker("Payment Tx No.(Cheque No.)");
            end;
        }
        field(34; "Cheque Date"; Date)
        {
        }
        field(35; "Due Date"; Date)
        {
            Editable = false;
        }
        field(36; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(37; "Overdue Days"; Integer)
        {
        }
        field(38; "Receiving Account"; Code[10])
        {
            TableRelation = "Bank Account";
        }
        field(39; "Receipt Mode"; Code[10])
        {
            TableRelation = "Pay Mode";
        }
        field(40; "Receipt Tx No.(Cheque No.)"; Code[10])
        {
            trigger OnValidate()
            begin
                FinanceMgnt.CodeRegExChecker("Receipt Tx No.(Cheque No.)");
            end;
        }
        field(41; "Claim Paying Account"; Code[10])
        {
            TableRelation = "Bank Account";
        }
        field(42; "Claim Pay Mode"; Code[10])
        {
            TableRelation = "Pay Mode";
        }
        field(43; "Claim Payment Tx No"; Code[10])
        {
            trigger OnValidate()
            begin
                FinanceMgnt.CodeRegExChecker("Claim Payment Tx No");
            end;
        }
        field(44; "International TDY"; Boolean)
        {
        }
        field(45; Purpose; Code[150])
        {
        }
        field(46; "Departure Location"; Text[30])
        {
        }
        field(47; "Departure Date"; Date)
        {
        }
        field(48; "Return Location"; Text[30])
        {
        }
        field(49; "Return Date"; Date)
        {
        }
        field(50; Justification; Text[150])
        {
        }
        field(51; "Variation Authorized"; Boolean)
        {
        }
        field(52; Bus; Boolean)
        {
            Description = 'travel by';
        }
        field(53; Rail; Boolean)
        {
            Description = 'travel by';
        }
        field(54; POV; Boolean)
        {
            Description = 'travel by';
        }
        field(55; "Commercial Air"; Boolean)
        {
            Description = 'travel by';
        }
        field(56; "Govt Vehicle"; Boolean)
        {
            Description = 'travel by';
        }
        field(57; "No Cost Associated"; Boolean)
        {
        }
        field(58; "Daily Lodging"; Boolean)
        {
        }
        field(59; "Meals Provided"; Boolean)
        {
        }
        field(60; Breakfast; Boolean)
        {
        }
        field(61; Lunch; Boolean)
        {
        }
        field(62; Dinner; Boolean)
        {
        }
        field(63; "Rental Car"; Boolean)
        {
        }
        field(64; "Payroll No."; Code[20])
        {
            Caption = 'Imprest Debtor No';
            TableRelation = IF("Staff Claim"=CONST(true))Customer WHERE("Customer Posting Group"=CONST('ST-TRAVEL'))
            ELSE IF("Staff Claim"=CONST(false))Customer WHERE("Customer Posting Group"=CONST('ST-TRAVEL'));
        // trigger OnValidate()
        // begin
        //     Cust.Reset;
        //     Cust.SetRange(Cust."No.", "Payroll No.");
        //     if Cust.Find('-') then begin
        //         "Employee Name" := Cust.Name;
        //         "Phone No." := Cust."Phone No.";
        //         if "FIN Created" = true then begin
        //             "Employee No." := Cust."No.";
        //             Validate("Employee No.");
        //         end;
        //     end;
        // end;
        }
        field(65; "Phone No."; Code[20])
        {
        }
        field(66; "Total ITO Cost"; Decimal)
        {
            Caption = 'Total Imprest Cost';
            CalcFormula = Sum("Imprest Details"."Request Amount" WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(67; "TDY Location"; Code[20])
        {
            TableRelation = "Travel Locations";
        }
        field(68; "Staff Claim"; Boolean)
        {
        }
        field(69; "SharePoint Link"; Text[250])
        {
        }
        field(70; "Surrender Reviewed By"; Code[50])
        {
        }
        field(71; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; Uncommitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "FIN Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(74; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Imprest Request Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "PV Lines".No WHERE("Account No"=FIELD("Payroll No."), Surrendered=CONST(false), Posted=CONST(true));

            trigger OnValidate()
            begin
                PVLines.Reset;
                PVLines.SetRange(No, "Imprest Request Code");
                PVLines.SetRange("Account No", "Payroll No.");
                if PVLines.FindFirst then begin
                    if PVHeader.Get(PVLines.No)then begin
                        "Date":=PVHeader.Date;
                        Validate("Date");
                    end;
                end;
                if "Imprest Request Code" = '' then begin
                    "Date":=Today;
                    Validate("Date");
                end;
            end;
        }
        field(76; "Job Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(77; "P/No"; Code[20])
        {
            Caption = 'Personal Number';
            DataClassification = ToBeClassified;
        }
        field(78; Designation; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(79; "CBK Website Address"; Text[250])
        {
        }
        field(80; "Pending Approvals Ext"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(50463), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
            Editable = false;
        }
        field(81; "External Application"; Option)
        {
            Description = 'Apply on behalf of external stakeholders';
            OptionMembers = No, Yes;
        }
        field(82; Balance; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No."=FIELD("Payroll No.")));
            Editable = false;
            FieldClass = FlowField;
        // trigger OnValidate()
        // begin
        //     If Balance <> 0 then
        //         Error('Cannot request if balance is not 0');
        // end;
        }
        field(83; "Claim Posted"; Boolean)
        {
            Editable = false;
        }
        field(84; "Claim Posted By"; Code[50])
        {
            Editable = false;
        }
        field(85; "Claim Posted Date"; Date)
        {
            Editable = false;
        }
        field(86; "EFT No"; Text[30])
        {
        }
        field(87; "Surrender EFT No"; Text[30])
        {
        }
        field(88; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(50463), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
            Editable = false;
        }
        field(89; "Location Description"; Text[100])
        {
        }
        field(90; "Start Date"; Date)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No.")then begin
                    if Rec.Balance <> 0 then begin
                        Error('Your must not have an outstanding balance before requesting for a new Imprest');
                    end;
                end;
            end;
        }
        field(91; "Imprest Type"; Option)
        {
            OptionCaption = ' ,Standing, Temporary, special';
            OptionMembers = " ", "Standing", "Temporary", "Special";
            NotBlank = true;
        }
        field(92; "End Date"; Date)
        {
            Editable = false;
        }
        field(93; "Imprest Memo"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Imprest Memo Header" where(Status=const(Released));

            trigger OnValidate()
            var
                MemoLines: Record "Imprest Memo Lines";
                ImprestSetup: Record "Advanced Finance Setup";
                Counter: Integer;
                ProcurementDecision: Record "Imprest Procurement Decision";
            begin
                if Rec."Imprest Memo" <> '' then begin
                    ImprestSetup.Get();
                    Counter:=0;
                    MemoLines.Reset();
                    MemoLines.SetRange("No.", Rec."Imprest Memo");
                    MemoLines.SetRange("Account No.", Rec."Employee No.");
                    if MemoLines.FindFirst()then begin
                        repeat IF MemoLines."Amount LCY" <> 0 then begin
                                //DSA
                                if MemoLines.DSA <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("DSA Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."DSA Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='DSA';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines.DSA;
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines.DSA / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Air Ticket
                                if MemoLines."Air Ticket" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Air Ticket Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Air Ticket Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Air Ticket';
                                    ImprestLines.UoM:='DAY';
                                    ImprestLines.Quantity:=1;
                                    ImprestLines."Unit Cost":=MemoLines."Air Ticket";
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Conference
                                if MemoLines.Conference <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Conference Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Conference Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Conference';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines.Conference;
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines.Conference / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Ground Transport
                                if MemoLines."Ground Transport" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("G.Transport Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."G.Transport Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Ground Transport';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Ground Transport";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Ground Transport" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Cordination Allowance
                                if MemoLines."Cordination Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Cord. Allow Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Cord. Allow Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Cordination Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Cordination Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Cordination Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Facilitator Allowance
                                if MemoLines."Facilitator Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Facilitator Allow Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Facilitator Allow Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Facilitator Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Facilitator Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Facilitator Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Secretariat Allowance
                                if MemoLines."Secretariat Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Secretariat Allow Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Secretariat Allow Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Secretariat Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Secretariat Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Secretariat Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Out of Pocket Allowance
                                if MemoLines."Out of Pocket Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Out of Pocket Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Out of Pocket Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Out of Pocket Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Out of Pocket Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Out of Pocket Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Rapporteur Allowance
                                if MemoLines."Rapporteur Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Rapporteur Allow Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Rapporteur Allow Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Rapporteur Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Rapporteur Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Rapporteur Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Driver Allowance
                                if MemoLines."Driver Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Driver Allow Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Driver Allow Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Driver Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Driver Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Driver Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Retreat Allowance
                                if MemoLines."Retreat Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Retreat Allow Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Retreat Allow Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Retreat Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Retreat Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Retreat Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Expert Allowance
                                if MemoLines."Expert Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Expert Allow Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Expert Allow Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Expert Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Expert Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Expert Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Accomodation
                                if MemoLines.Accomodation <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Accomodation Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Accomodation Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Accomodation';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines.Accomodation;
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines.Accomodation / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Tuition Fee
                                if MemoLines."Tuition Fee" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Tuition Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Tuition Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Tuition Fee';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Tuition Fee";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Tuition Fee" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Mileage Allowance
                                if MemoLines."Mileage Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Mileage Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Mileage Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Mileage Allowance';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Mileage Allowance";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Mileage Allowance" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                                //Quarter Perdiem
                                if MemoLines."Quarter Per Diem" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Qtr. Per Diem Expense Code");
                                    ImprestLines.Init();
                                    ImprestLines."No.":=Rec."No.";
                                    ImprestLines."Line No":=Counter;
                                    ImprestLines."Expense Code":=ImprestSetup."Qtr. Per Diem Expense Code";
                                    ImprestLines.Validate("Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestLines."Expense Code")then ImprestLines.Decision:=ProcurementDecision.Decision;
                                    ImprestLines.Narration:='Quarter Perdiem';
                                    ImprestLines.UoM:='DAY';
                                    if MemoLines.Days = 0 then begin
                                        ImprestLines.Quantity:=1;
                                        ImprestLines."Unit Cost":=MemoLines."Quarter Per Diem";
                                    end
                                    else
                                    begin
                                        ImprestLines.Quantity:=MemoLines.Days;
                                        ImprestLines."Unit Cost":=MemoLines."Quarter Per Diem" / MemoLines.Days;
                                    end;
                                    ImprestLines.Validate("Unit Cost");
                                    ImprestLines."Global Dimension 1 Code":=MemoLines."Global Dimension 1 Code";
                                    ImprestLines."Global Dimension 2 Code":=MemoLines."Global Dimension 2 Code";
                                    ImprestLines.Insert();
                                end;
                            end;
                        until MemoLines.Next() = 0;
                    end
                    else
                        Error('You are not a participant in the selected memo! Please select a different one.');
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        AdvancedFinanceSetup.Get;
        if "No." = '' then if not "Staff Claim" then begin
                AdvancedFinanceSetup.TestField("Imprest Nos");
                NoSeriesMgt.InitSeries(AdvancedFinanceSetup."Imprest Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end
            else
            begin
                AdvancedFinanceSetup.TestField("Staff Claim Nos");
                NoSeriesMgt.InitSeries(AdvancedFinanceSetup."Staff Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
        "Date":=Today;
        "Created By":=UserId;
        if not "FIN Created" then begin
            if UserSetup.Get(UserId)then begin
                "Employee No.":=UserSetup."Employee No.";
                Validate("Employee No.");
                Commit();
            end;
        end;
    // if AdvancedFinanceSetup."Employee Payment Terms" = '' then
    //     Error(Text000);
    // if PaymentTerms.Get(AdvancedFinanceSetup."Employee Payment Terms") then
    //     "Due Date" := CalcDate(PaymentTerms."Due Date Calculation", "Date");
    end;
    var AdvancedFinanceSetup: Record "Advanced Finance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    EmpRec: Record "Employee Master";
    NAVEmp: Record Employee;
    Text000: Label 'Kindly set up the Employee Payment Terms on the Advanced Finance Setup';
    PaymentTerms: Record "Payment Terms";
    Cust: Record Customer;
    Commitments: Codeunit Commitments;
    PVHeader: Record "PV Header";
    PVLines: Record "PV Lines";
    Resource: Record Resource;
    FinanceMgnt: Codeunit "Finance Management";
    ImprestLines: Record "Imprest Details";
    procedure CalculateNetChange()
    begin
        CalcFields("Total Request Amount", "Total Surrender Amount");
        "Net Refund (Net Claim)":="Total Request Amount" - "Total Surrender Amount";
        if "Net Refund (Net Claim)" < 0 then begin
            "Total Claim":=Abs("Net Refund (Net Claim)");
            "Total Refund":=0;
        end
        else if "Net Refund (Net Claim)" > 0 then begin
                "Total Refund":="Net Refund (Net Claim)";
                "Total Claim":=0;
            end
            else if "Net Refund (Net Claim)" = 0 then begin
                    "Total Claim":=0;
                    "Total Refund":=0;
                end;
    end;
}
