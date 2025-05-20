table 50469 "Imprest Payroll Claims Header"
{
    Caption = 'Imprest Payroll Claims Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Created By"; Code[50])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; From; Code[20])
        {
        }
        field(5; "To"; Code[10])
        {
        }
        field(6; Subject; Text[50])
        {
        }
        field(7; Memo; Text[250])
        {
        }
        field(8; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; Archived; Boolean)
        {
        }
        field(11; "Posted By"; Code[50])
        {
        }
        field(12; "Archived By"; Code[50])
        {
        }
        field(13; "Recipient Name"; Text[30])
        {
        }
        field(14; "Recipient Email"; Text[80])
        {
        }
        field(15; "Sender Name"; Text[30])
        {
        }
        field(16; "Sender Email"; Text[80])
        {
        }
        field(17; Purpose; Code[150])
        {
        }
        field(18; "Activity Location"; Code[10])
        {
        }
        field(19; "Departure Location"; Text[30])
        {
        }
        field(20; "Departure Date"; Date)
        {
        }
        field(21; "Return Location"; Text[30])
        {
        }
        field(22; "Return Date"; Date)
        {
        }
        field(23; Justification; Text[150])
        {
        }
        field(25; "Start Date"; Date)
        {
            NotBlank = true;
        }
        field(26; "Total Days in the Field"; Integer)
        {
        }
        field(27; "End Date"; Date)
        {
            Editable = false;
        }
        field(28; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(50464), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
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
                    if MemoLines.FindFirst()then begin
                        repeat IF MemoLines."Amount LCY" <> 0 then begin
                                //DSA
                                if MemoLines.DSA <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("DSA Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."DSA Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."DSA Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Air Ticket
                                if MemoLines."Air Ticket" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Air Ticket Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Air Ticket Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Air Ticket Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Conference
                                if MemoLines.Conference <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Conference Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Conference Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Conference Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Ground Transport
                                if MemoLines."Ground Transport" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("G.Transport Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."G.Transport Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."G.Transport Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Cordination Allowance
                                if MemoLines."Cordination Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Cord. Allow Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Cord. Allow Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Cord. Allow Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Facilitator Allowance
                                if MemoLines."Facilitator Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Facilitator Allow Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Facilitator Allow Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Facilitator Allow Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Secretariat Allowance
                                if MemoLines."Secretariat Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Secretariat Allow Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Secretariat Allow Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Secretariat Allow Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Out of Pocket Allowance
                                if MemoLines."Out of Pocket Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Out of Pocket Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Out of Pocket Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Out of Pocket Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Rapporteur Allowance
                                if MemoLines."Rapporteur Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Rapporteur Allow Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Rapporteur Allow Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Rapporteur Allow Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Driver Allowance
                                if MemoLines."Driver Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Driver Allow Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Driver Allow Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Driver Allow Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Retreat Allowance
                                if MemoLines."Retreat Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Retreat Allow Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Retreat Allow Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Retreat Allow Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Expert Allowance
                                if MemoLines."Expert Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Expert Allow Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Expert Allow Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Expert Allow Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Accomodation
                                if MemoLines.Accomodation <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Accomodation Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Accomodation Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Accomodation Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Tuition Fee
                                if MemoLines."Tuition Fee" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Tuition Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Tuition Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Tuition Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Mileage Allowance
                                if MemoLines."Mileage Allowance" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Mileage Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Mileage Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Mileage Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                                end;
                                //Quarter Perdiem
                                if MemoLines."Quarter Per Diem" <> 0 then begin
                                    Counter:=Counter + 1;
                                    ImprestSetup.TestField("Qtr. Per Diem Expense Code");
                                    if ProcurementDecision.Get(Rec."Imprest Memo", ImprestSetup."Qtr. Per Diem Expense Code")then if ProcurementDecision.Decision = ProcurementDecision.Decision::"Process to Payroll" then begin
                                            ImprestLines.Init();
                                            ImprestLines."No.":=Rec."No.";
                                            ImprestLines."Line No":=Counter;
                                            ImprestLines."Expense Code":=ImprestSetup."Qtr. Per Diem Expense Code";
                                            ImprestLines."Employee No":=MemoLines."Account No.";
                                            ImprestLines."Employee Name":=MemoLines.Name;
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
                            end;
                        until MemoLines.Next() = 0;
                    end
                    else
                        Error('There are no payroll claims in the selected memo!');
                end;
            end;
        }
        field(60; Status;Enum "Sales Document Status")
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            ImprestMemoSetup.Get;
            ImprestMemoSetup.TestField("Imprest Memo Nos");
            NoSeriesMgt.InitSeries(ImprestMemoSetup."Imprest Payroll Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created By":=UserId;
        Rec.Date:=Today;
    end;
    var ImprestMemoSetup: Record "Advanced Finance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    ImprestLines: Record "Imprest Payroll Claim Lines";
    ExpenseCodes: Record "Expense Codes";
}
